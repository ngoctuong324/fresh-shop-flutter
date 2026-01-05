class Product {
  final String id;
  final String name;
  final String description;
  final String image;
  String get assetImage => 'assets/images/$image';
  final String category;
  final double price;
  final String unit;
  final double rate;
  final bool isRecent;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.price,
    required this.unit,
    required this.rate,
    required this.isRecent,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'category': category,
      'price': price,
      'unit': unit,
      'rate': rate,
      'isRecent': isRecent,
    };
  }
}
