class OrderProduct {
  final String? productId;
  final String name;
  final double price;
  final int quantity;
  final double totalPrice;
  final String? image;

  OrderProduct({
    this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    this.image,
  });

  factory OrderProduct.fromMap(Map<String, dynamic> map) {
    return OrderProduct(
      productId: map['productId'] as String?,
      name: map['name'] as String? ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0,
      quantity: map['quantity'] as int? ?? 1,
      totalPrice: (map['totalPrice'] as num?)?.toDouble() ?? 0,
      image: map['image'] as String? ?? 'default.png',
    );
  }
}
