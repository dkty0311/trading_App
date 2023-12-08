import 'package:flutter/material.dart';
import 'package:login_page_1/utils/productClass.dart';

class SpecificProductScreen extends StatelessWidget {
  final Product product;

  SpecificProductScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '상세페이지',
            style:
                TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Poppins'),
          ),
          backgroundColor: Color(0xFF755DC1),
          elevation: 0.0,
          centerTitle: false,
          actions: [IconButton(icon: Icon(Icons.logout), onPressed: () {})],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.network(
                  'http://3.39.231.7/item/images?path=${product.imagePath}',
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),

              Container(
                width: double.infinity,
                height: 20,
                color: Colors.red,
                child: Text(
                  '제품번호 : ${product.seq}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                ),
              ),
              Text('제품번호 : ${product.seq}'),
              Text('상품명 : ${product.name}'),
              Text('상품설명 : ${product.description}')

              // 다른 필요한 정보들을 추가하세요
            ],
          ),
        ));
  }
}
