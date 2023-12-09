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
  late Map<String, dynamic> data;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    fetchData().then((value) {
      setState(() {
        data = value;
      });
    });
  }

  Future<Map<String, dynamic>> fetchData() async {
    http.Response response = await http.get(
        Uri.parse("http://3.39.231.7/item?item_seq=${widget.product.seq}"));
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '상세페이지',
          style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Poppins'),
        ),
        backgroundColor: const Color(0xFF755DC1),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () {}),
          IconButton(
            icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 데이터 로딩 중에 보여질 위젯
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // 에러가 발생했을 때 보여질 위젯
            return Text('Error: ${snapshot.error}');
          } else {
            // 데이터를 성공적으로 가져왔을 때의 처리
            Map<String, dynamic> data = snapshot.data!;
            List<Map<String, dynamic>> images =
                List<Map<String, dynamic>>.from(data["images"]);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 이미지 슬라이더
                  CarouselSlider(
                    items: images.map((image) {
                      return Image.network(
                        'http://3.39.231.7/item/images/?path=${image["path"]}&index=${image["index"]}',
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
                    width: double.infinity,
                    height: 10,
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      '제품번호 : ${widget.product.seq}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '${widget.product.name}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.amber,
                    padding: EdgeInsets.all(8.0),
                    width: double.infinity,
                    height: 400,
                    child: Text(
                      '상품설명 : ${data["description"]}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Text('상품설명 : ${data["description"]}'),
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
