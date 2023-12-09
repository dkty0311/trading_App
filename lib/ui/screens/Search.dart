import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataModel {
  final int seq;
  final String name;

  DataModel({required this.seq, required this.name});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      seq: json['seq'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class ResponseWithModel {
  final List<DataModel> data;

  ResponseWithModel({required this.data});

  factory ResponseWithModel.fromJson(List<dynamic> json) {
    List<DataModel> dataList = json.map((item) {
      return DataModel.fromJson(item);
    }).toList();

    return ResponseWithModel(data: dataList);
  }
}

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  List<DataModel> _searchResult = [];

  Future<void> searchItems(String item) async {
    String host = 'http://3.39.231.7'; // 호스트 URL을 넣어주세요
    try {
      http.Response response = await http.get(
        Uri.parse("$host/item/search/$item?start=0&count=10"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        List<dynamic> responseBody =
            jsonDecode(utf8.decode(response.bodyBytes));
        ResponseWithModel responseModel =
            ResponseWithModel.fromJson(responseBody);

        setState(() {
          _searchResult = responseModel.data;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      // 에러 처리
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              decoration: const InputDecoration(
                hintText: '검색어를 입력하세요',
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // '검색' 버튼이 눌렸을 때만 Future가 실행되도록 함
                setState(() {
                  _searchResult = []; // 검색을 시작하기 전에 결과를 초기화
                });
                searchItems(_searchText);
              },
              child: Text('검색'),
            ),
            Expanded(
              child: _searchText.isEmpty
                  ? ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_searchResult[index].name),
                        );
                      },
                    )
                  : FutureBuilder<void>(
                      future: searchItems(_searchText),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('검색 중 오류가 발생했습니다.');
                        } else {
                          return _searchResult.isNotEmpty
                              ? ListView.builder(
                                  itemCount: _searchResult.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(_searchResult[index].name),
                                    );
                                  },
                                )
                              : Text('검색 결과 없음');
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
