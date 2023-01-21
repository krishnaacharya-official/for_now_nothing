class AddressModel {
  String? id;
  String fullName;
  String phoneNumber;
  String houseNumber;
  String roadName;
  String cityName;
  bool isDefault;
  String type;

  AddressModel(
      {required this.type,
      required this.fullName,
      required this.phoneNumber,
      required this.houseNumber,
      required this.roadName,
      required this.cityName,
      required this.isDefault,
      this.id});

  factory AddressModel.fromJson(Map<String, dynamic> json, String id) {
    return AddressModel(
        type: json['type'],
        isDefault: json['isDefault'],
        fullName: json['fullName'],
        phoneNumber: json['phoneNumber'],
        houseNumber: json['houseNumber'],
        roadName: json['roadName'],
        cityName: json['cityName'],
        id: id);
  }
  factory AddressModel.fromJsonString(Map<String, String> json) {
    return AddressModel(
        type: json['type']!,
        isDefault: json['isDefault']!.toLowerCase() == "true",
        fullName: json['fullName']!,
        phoneNumber: json['phoneNumber']!,
        houseNumber: json['houseNumber']!,
        roadName: json['roadName']!,
        cityName: json['cityName']!,
        id: json['id']);
  }

  Map<String, dynamic> toJsonString(String id) {
    final Map<String, String> data = <String, String>{};
    data['type'] = type;
    data['isDefault'] = isDefault.toString();
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['houseNumber'] = houseNumber;
    data['roadName'] = roadName;
    data['cityName'] = cityName;
    data['id'] = id;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['isDefault'] = isDefault;
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['houseNumber'] = houseNumber;
    data['roadName'] = roadName;
    data['cityName'] = cityName;
    return data;
  }
}
