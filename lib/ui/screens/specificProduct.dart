import 'package:flutter/material.dart';
import 'package:login_page_1/utils/productClass.dart'; // Import the file where the Product class is defined.

class SpecificProductScreen extends StatelessWidget {
  final Product product;

  SpecificProductScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Seq: ${product.seq}'),
            Text('Name: ${product.name}'),
            // Add other necessary information
          ],
        ),
      ),
    );
  }
}
