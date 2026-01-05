class ShippingAddressModel {
  final String fullName;
  final String phone;
  final String detail;
  final String ward;
  final String district;
  final String province;

  ShippingAddressModel({
    required this.fullName,
    required this.phone,
    required this.detail,
    required this.ward,
    required this.district,
    required this.province,
  });

  Map<String, dynamic> toMap() {
    return {
      "fullName": fullName,
      "phone": phone,
      "detail": detail,
      "ward": ward,
      "district": district,
      "province": province,
    };
  }

  factory ShippingAddressModel.fromMap(Map<String, dynamic> map) {
    return ShippingAddressModel(
      fullName: map["fullName"],
      phone: map["phone"],
      detail: map["detail"],
      ward: map["ward"],
      district: map["district"],
      province: map["province"],
    );
  }
}
