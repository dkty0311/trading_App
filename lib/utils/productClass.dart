class Product {
  final int seq;
  final String name;
  final String createdAt;
  final int price;
  final int savedCnt;
  final String? imagePath;
  final String? description;

  Product(
      {required this.seq,
      required this.name,
      required this.createdAt,
      required this.price,
      required this.savedCnt,
      required this.imagePath,
      required this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        seq: json['seq'],
        name: json['name'],
        createdAt: json['created_at'],
        price: json['price'],
        savedCnt: json['saved_cnt'],
        imagePath: json['image_path'],
        description: json['description']);
  }
}
