import 'package:mongo_dart/mongo_dart.dart';

class ProductModel {
  ProductModel({
    // required dynamic this.id,
    required dynamic objectStringId,
    required this.typeOfProduct,
    required this.name,
    required this.primaryPrice,
    this.primaryDiscountedPrice,
    this.secondaryPrice,
    this.secondaryDiscountedPrice,
    required this.categories,
    required this.tags,
    this.description,
    required this.images,
    this.quantity,
    this.primaryDiscountedRate,
    this.secondaryDiscountedRate,
  }) : id = (objectStringId is ObjectId
            ? objectStringId.toString()
            : objectStringId);

  String id;
  // ObjectId id;
  String typeOfProduct;
  String name;
  int primaryPrice;
  int? primaryDiscountedPrice;
  int? secondaryPrice;
  int? secondaryDiscountedPrice;
  List<String> categories;
  List<String> tags;
  String? description;
  List<Image> images;
  String? quantity;
  int? primaryDiscountedRate;
  int? secondaryDiscountedRate;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      objectStringId: json["_id"],
      typeOfProduct: json["typeOfProduct"],
      name: json["name"],
      primaryPrice: (json["primaryPrice"]),
      primaryDiscountedPrice: (json["primaryDiscountedPrice"]),
      secondaryPrice: (json["secondaryPrice"]),
      secondaryDiscountedPrice: (json["secondaryDiscountedPrice"]),
      categories: List<String>.from(json["categories"].map((x) => x)),
      tags: List<String>.from(json["tags"].map((x) => x)),
      description: json["description"],
      images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      quantity: json["quantity"],
      // primaryDiscountedRate: (json["primaryDiscountedRate"]) != null
      //     ? json['primaryDiscountedRate'].toInt()
      //     : null,
      primaryDiscountedRate: json['primaryDiscountedRate'].toInt(),
      secondaryDiscountedRate: json["secondaryDiscountedRate"].toInt());

  Map<String, dynamic> toJson() => {
        // "_id": id.toJson(),
        "_id": id,
        "typeOfProduct": typeOfProduct,
        "name": name,
        "primaryPrice": primaryPrice,
        "primaryDiscountedPrice": primaryDiscountedPrice,
        "secondaryPrice": secondaryPrice,
        "secondaryDiscountedPrice": secondaryDiscountedPrice,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
        "quantity": quantity,
        "primaryDiscountedRate": primaryDiscountedRate,
        "secondaryDiscountedRate": secondaryDiscountedRate,
      };
}

class Image {
  Image({
    required this.url,
    required this.publicId,
  });

  String url;
  String publicId;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
        publicId: json["public_id"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "public_id": publicId,
      };
}
