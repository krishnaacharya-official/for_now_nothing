class SampleModel {
  final String name;
  final String avatar;

  SampleModel({required this.name, required this.avatar});

  factory SampleModel.fromjson(Map<String, dynamic> json, String id) {
    return SampleModel(name: json['name'], avatar: json['avatar']);
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'avatar': avatar};
  }

  @override
  String toString() {
    return name + avatar;
  }
}
