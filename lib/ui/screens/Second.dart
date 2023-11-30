import 'package:flutter/material.dart';

class Second extends StatelessWidget {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3']; // 예시 아이템 데이터

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('관심 목록'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 열의 개수
          crossAxisSpacing: 8.0, // 열 간의 간격
          mainAxisSpacing: 8.0, // 행 간의 간격
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // 아이템을 탭하면 상세 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailPage(item: items[index]),
                ),
              );
            },
            child: Card(
              child: Center(
                child: Text(items[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ItemDetailPage extends StatelessWidget {
  final String item;

  const ItemDetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('상세 페이지'),
      ),
      body: Center(
        child: Text('상세 페이지: $item'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Second(),
  ));
}
