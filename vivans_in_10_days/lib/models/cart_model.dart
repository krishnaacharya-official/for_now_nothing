class CartModel {
  String? id;
  List<CartProductModel> productList;
  int totalDiscountedPrice;
  int totalActualPrice;
  CartModel(
      {this.id,
      required this.productList,
      required this.totalActualPrice,
      required this.totalDiscountedPrice});
  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      id: json['id'],
      productList: List<CartProductModel>.from(
          json["productList"].map((x) => CartProductModel.fromJson(x, x.id))),
      totalActualPrice: json['totalActualPrice'],
      totalDiscountedPrice: json['totalDiscountedPrice']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "productList": List<dynamic>.from(productList.map((e) => e)),
        "totalDiscountedPrice": totalDiscountedPrice,
        "totalActualPrice": totalActualPrice,
      };
}

class CartProductModel {
  String productId;
  String imageUrl;
  String name;
  String typeOfProduct;
  int actualPrice;
  int discountedPrice;
  int quantity;
  int discountedRate;
  CartProductModel(
      {required this.actualPrice,
      required this.typeOfProduct,
      required this.discountedPrice,
      required this.discountedRate,
      required this.imageUrl,
      required this.productId,
      required this.name,
      required this.quantity});
  factory CartProductModel.fromJson(
          Map<String, dynamic> json, String productId) =>
      CartProductModel(
          typeOfProduct: json['typeOfProduct'],
          actualPrice: json['actualPrice'],
          discountedPrice: json['discountedPrice'],
          discountedRate: json["discountedRate"],
          imageUrl: json["imageUrl"],
          name: json["name"],
          productId: productId,
          quantity: json["quantity"]);

  Map<String, dynamic> toJson() => {
        "actualPrice": actualPrice,
        "discountedPrice": discountedPrice,
        "discountedRate": discountedRate,
        "imageUrl": imageUrl,
        "name": name,
        "quantity": quantity,
        "typeOfProduct": typeOfProduct
      };
}
