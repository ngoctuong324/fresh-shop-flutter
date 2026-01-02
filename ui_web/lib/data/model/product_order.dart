class ProductOrder {
  final String name;
  final String qty;
  final String price;
  final String image;

  ProductOrder({
    required this.name,
    required this.qty,
    required this.price,
    required this.image,
  });

  static List<ProductOrder> sampleOrders = [
    ProductOrder(
      name: "Nước Ép Thơm",
      qty: "01",
      price: "30.000 VNĐ",
      image: "assets/images/nuoc-ep-thom.jpg",
    ),
    ProductOrder(
      name: "Sườn Cừu",
      qty: "01",
      price: "735.000 VNĐ",
      image: "assets/images/suon-cuu.png",
    ),
    ProductOrder(
      name: "Nước Ép Cà Rốt",
      qty: "01",
      price: "220.000 VNĐ",
      image: "assets/images/nuoc-ep-ca-rot.jpg",
    ),
  ];
}
