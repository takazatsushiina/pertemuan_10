import 'dart:convert';


class ProductModel {

  //inisialisasi variabel data product
  final String name ;
  final String description;
  final int price;

  //constructor
  ProductModel({
    required this.name,
    required this.description,
    required this.price
  });


  //Object -> map
  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'description': description,
      'price': price,
    };
  }

  //map -> obeject
  factory ProductModel.forMap(
    Map<String, dynamic> map, 
  ) {
    return ProductModel(
      name: map['name'] ??'',
      description: map['description'] ??'',
      price: map['price'] ?? 0,
         
    );
  }

  //Object -> json string 
  String toJson () => jsonEncode(toMap());
// JSON STRING -> OBJECT
  factory ProductModel.fromJson(String source) {
    return ProductModel.forMap(
      jsonDecode(source),
    );
  }

}


