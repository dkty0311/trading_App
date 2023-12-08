import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  List<String> _dataList = ['상훈이 애미', '상훈이 아버지', '❤️', '재국이애미', '재국이'];

  List<String> _filteredData() {
    return _dataList
        .where((item) => item.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredList = _filteredData();

    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 검색창을 시작 부분에 정렬
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
            SizedBox(height: 16.0), // 원하는 간격을 추가해 줄 수 있습니다.
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredList[index]),
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
