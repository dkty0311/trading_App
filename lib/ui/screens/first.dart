import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:login_page_1/utils/productClass.dart';

import 'package:login_page_1/ui/screens/specificProduct.dart';

void main() {
  runApp(MyApp());
}

class ResponseWithModel {
  final dynamic data;
  final int statusCode;

  ResponseWithModel(this.data, this.statusCode);

  factory ResponseWithModel.fromJson(String jsonString, int statusCode) {
    return ResponseWithModel(json.decode(jsonString), statusCode);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Product List'),
        ),
        body: first(),
      ),
    );
  }
}

class first extends StatelessWidget {
  const first({Key? key}) : super(key: key);

  Future<List<Product>> fetchData() async {
    // recommendItems 함수 호출하여 데이터 가져오기
    http.Response response = await http.get(
      Uri.parse("http://3.39.231.7/item/recommend?start=0&count=30"),
      headers: {"Content-Type": "application/json"},
    );

    String responseBody = utf8.decoder.convert(response.bodyBytes);
    ResponseWithModel responseModel =
        ResponseWithModel.fromJson(responseBody, response.statusCode);

    List<Product> productList = [];

    if (responseModel.statusCode == 200) {
      List<dynamic> data = responseModel.data;

      for (Map<String, dynamic> productMap in data) {
        Product product = Product.fromJson(productMap);
        productList.add(product);
      }
    }

    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터 로딩 중에 보여질 위젯
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // 에러가 발생했을 때 보여질 위젯
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // 데이터를 성공적으로 가져왔을 때의 처리
          List<Product> products = snapshot.data ?? [];

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 6,
              childAspectRatio: 1 / 2,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SpecificProductScreen(product: products[index]),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.all(8),
                elevation: 8,
                child: GridTile(
                  header: GridTileBar(
                    backgroundColor: Color(0xFF755DC1),
                    title: Text(products[index].name),
                    subtitle: Text(products[index].createdAt),
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.blue.shade100,
                    title: Text('(하트)${products[index].savedCnt}'),
                    subtitle: Text(
                      '${products[index].price}\원',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                          'http://3.39.231.7/item/images?path=${products[index].imagePath}'),
                    ),
                    // child: Text(
                    //   'Item ${products[index].seq}',
                    //   style: const TextStyle(fontSize: 16),
                    // ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
