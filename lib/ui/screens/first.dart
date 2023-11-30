import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final List<String> _items = List.generate(30, (index) => 'Item ${index + 1}');

class first extends StatelessWidget {
  const first({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 6,
            childAspectRatio: 1 / 2),
        itemCount: _items.length,
        itemBuilder: (context, index) => Card(
              margin: const EdgeInsets.all(8),
              elevation: 8,
              child: GridTile(
                header: GridTileBar(
                  backgroundColor: Color(0xFF755DC1),
                  title: const Text('플레이스테이션4'),
                  subtitle: Text('2023-12-02 ${_items[index].split(' ')[1]}'),
                ),
                footer: GridTileBar(
                  backgroundColor: Colors.blue.shade100,
                  title: const Text('(하트)32'),
                  subtitle: Text(
                    '20,000\$ ${_items[index].split(' ')[1]}',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                child: Center(
                  child: Text(
                    _items[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ));
  }
}
