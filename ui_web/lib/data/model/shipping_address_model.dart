class ShippingAddressModel {
  final String fullName;
  final String phone;
  final String province;
  final String district;
  final String ward;
  final String detail;

  ShippingAddressModel({
    required this.fullName,
    required this.phone,
    required this.province,
    required this.district,
    required this.ward,
    required this.detail,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phone': phone,
      'province': province,
      'district': district,
      'ward': ward,
      'detail': detail,
    };
  }

  factory ShippingAddressModel.fromMap(Map<String, dynamic> map) {
    return ShippingAddressModel(
      fullName: map['fullName'],
      phone: map['phone'],
      province: map['province'],
      district: map['district'],
      ward: map['ward'],
      detail: map['detail'],
    );
  }
}
