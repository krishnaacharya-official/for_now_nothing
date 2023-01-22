import 'package:vivans_in_10_days/models/product_model.dart';

class HomeProductModel {
  @override
  String toString() {
    // TODO: implement toString
    var string = '';
    for (var element in products) {
      string += element.name;
    }
    return image.url + string;
  }

  Image image;
  String title;
  List<ProductModel> products;
  String sId;

  HomeProductModel(
      {required this.image,
      required this.title,
      required this.products,
      required this.sId});

  factory HomeProductModel.fromJson(Map<String, dynamic> json) =>
      HomeProductModel(
          image: Image.fromJson(json['image']),
          title: json['title'],
          // products: json['products'].cast<String>(),
          products: List<ProductModel>.from(
              json['products'].map((x) => ProductModel.fromJson(x))),
          sId: json['_id']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image.toJson();
    data['title'] = title;
    // data['products'] = products;
    data['products'] = List<ProductModel>.from(products.map((e) => e));
    data['_id'] = sId;
    return data;
  }
}

class Image {
  String url;
  String publicId;

  Image({required this.url, required this.publicId});

  factory Image.fromJson(Map<String, dynamic> json) =>
      Image(url: json['url'], publicId: json['public_id']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['public_id'] = publicId;
    return data;
  }
}
