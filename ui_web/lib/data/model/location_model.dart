class LocationModel {
  final String name;
  final int code;

  LocationModel({required this.name, required this.code});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(name: json['name'], code: json['code']);
  }
}
