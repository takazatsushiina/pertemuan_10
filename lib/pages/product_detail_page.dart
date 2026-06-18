import 'package:flutter/material.dart';
import '../models/product_models.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;



  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Produk"),),
      body: Padding(
        padding: .all(20),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: .bold),
            ),
            const SizedBox(height: 10,),
            Text("Rp ${product.price}"),
            const SizedBox(height: 10,),
            Text(product.description)
          ],
        ),),
    );
  }
}