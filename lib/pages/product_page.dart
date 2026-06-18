import 'package:flutter/material.dart';
import 'package:pertemuan_10/pages/product_detail_page.dart';
import 'package:pertemuan_10/widgets/product_card.dart';
import '../models/product_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductModel> products = [];

  Future<void> loadProducts() async {
    final res = await SharedPreferences.getInstance();
    List<String> productList = res.getStringList('products') ?? [];;
    setState(() {
      products = productList 
      .reversed
      .take(3)
      .map((item) => ProductModel.fromJson(item))
      .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProducts();
  }

  //metode save product
  Future<void> saveProducts() async {
    final res = await SharedPreferences.getInstance();
    List<String> productList = products.map((item) => item.toJson()).toList();
    await res.setStringList('products', productList);
  }

  //metode add product
  Future<void> addProducts(ProductModel product) async {
    setState(() {
      products.add(product);
    });

    await saveProducts();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Produk berhasil ditambahkan")),
      );
  }


  // metode update product
  Future<void> updateProducts(int index, ProductModel product) async {
    setState(() {
      products[index] = product;
    });

    await saveProducts();
  }

  //metode delete product 
  Future<void> deleteProducts(int index) async {
    setState(() {
      products.removeAt(index);
    });

    await saveProducts();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Produk berhasil dihapus")),
      );
  }

  void showForm({ProductModel? product, int? index}) {
    TextEditingController nameController = TextEditingController(
      text: product?.name ?? "",
    );
    TextEditingController descriptionController = TextEditingController(
      text: product?.description ?? "",
    );
    TextEditingController priceController = TextEditingController(
      text: product?.price.toString() ?? "",
    );

    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        title: Text(product == null ? "Tambah Produk" : "Edit Produk"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Deskripsi"),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: "Harga"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: (){
              final newProduct = ProductModel(
                name: nameController.text, 
                description: descriptionController.text, 
                price: int.parse(priceController.text),
                );
                if (product == null) {
                  addProducts(newProduct);
                } else {
                  updateProducts(index!, newProduct);
                }
            } , child: Text("Simpan"),
            ),
        ],
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produk", style: TextStyle(
          color: Colors.white,
          fontWeight: .bold
          ),
        ),
        backgroundColor: Colors.purple,
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: Icon(
            Icons.chevron_left,
            color: Colors.white,
          )),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => showForm(), 
                    child: const Text("Tambah Produk"),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20,),
             Expanded(
                child: products.isEmpty
                    ? const Center(child: Text("Belum ada produk"))
                    : ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(
                            product: product, 
                            onDelete: () => deleteProducts(index),
                            onEdit: () =>
                            showForm(product: product, index: index),
                            onTap: () => Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (_) => ProductDetailPage(product: product))
                            )
                        
                       );    
                      },
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
