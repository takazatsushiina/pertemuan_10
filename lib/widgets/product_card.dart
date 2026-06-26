import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pertemuan10_2306021/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(15),
          title: Text(
            product.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: .start,
            spacing: 5,
            children: [
              Text("Rp ${product.price}"),
              Text(product.description),
            product.image.isNotEmpty
              ? Image.memory(
                  base64Decode(product.image),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  )
                  :const Icon(Icons.image, size: 120),
            ],
          ),
          leading: onEdit != null
              ? IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: onEdit,
                )
              : null,
          trailing: onDelete != null
              ? IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                )
              : null,
        ),
      ),
    );
  }
}
