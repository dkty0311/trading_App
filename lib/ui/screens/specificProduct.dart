import 'package:flutter/material.dart';
import 'package:login_page_1/utils/productClass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

class SpecificProductScreen extends StatefulWidget {
  final Product product;

  SpecificProductScreen({required this.product});

  @override
  _SpecificProductScreenState createState() => _SpecificProductScreenState();
}

class _SpecificProductScreenState extends State<SpecificProductScreen> {
  late Future<List<String>> imagePaths;

  @override
  void initState() {
    super.initState();
    imagePaths = fetchData();
  }

  Future<List<String>> fetchData() async {
    http.Response response = await http.get(
      Uri.parse("http://3.39.231.7/item/images/${widget.product.seq}"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(jsonDecode(response.body));

      List<String> paths = data.map((image) {
        return 'http://3.39.231.7/item/images/?path=${image["path"]}&index=${image["index"]}';
      }).toList();

      return paths;
    } else {
      throw Exception('Failed to load image paths');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '상세페이지',
          style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Poppins'),
        ),
        backgroundColor: Color(0xFF755DC1),
        elevation: 0.0,
        centerTitle: false,
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: () {})],
      ),
      body: FutureBuilder<List<String>>(
        future: imagePaths,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<String> imagePaths = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 이미지 슬라이더
                  CarouselSlider(
                    items: imagePaths.map((imagePath) {
                      return Image.network(
                        imagePath,
                        width: double.infinity,
                        height: 400,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 350.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      viewportFraction: 1.0,
                    ),
                  ),
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '제품번호 : ${widget.product.seq}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Text('상품명 : ${widget.product.name}'),
                  Text('상품설명 : ${widget.product.description}'),
                  // 다른 필요한 정보들을 추가하세요
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
