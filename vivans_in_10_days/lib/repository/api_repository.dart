// ignore_for_file: slash_for_doc_comments
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:vivans_in_10_days/helpers/constants.dart';
import 'package:vivans_in_10_days/models/product_model.dart';
import 'package:vivans_in_10_days/models/products_main_model.dart';

class ApiRepository {
  static var db, productsCollection;
  static connect() async {
    db = await Db.create(Constants.MONGO_CONN_URL);
    await db.open();
    productsCollection = db.collection('products');
  }

  static const baseUrl = "http://10.0.2.2:8000";

  // static const baseUrl = "http://localhost:8000";
  Future<List<dynamic>> fetchProducts() async {
    try {
      // Make the GET request
      final response = await http.get(Uri.parse("$baseUrl/product"));

      // parse the json response
      final productsJson = jsonDecode(response.body)['data'] as List;
      final products = productsJson
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(
            "Request successful: ${response.statusCode} ${products.toString()}");
      } else {
        print("Request failed: ${response.statusCode}");
      }
      return products;
    } on http.ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }
    /**bug: You need to handle if timeout is reached saying sorry we are not able to reach you  , retry! in the UI 
     * and off to on internet state should also should check products */
    /**And then we should have retry button, where it should retry to fetch products */
  }

  Future<List<dynamic>> fetchHomeCategoryProducts() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/mobile/homeMain"));
      final productsJson = jsonDecode(response.body)['data']['data'] as List;
      final products = productsJson
          .map((productJson) => HomeProductModel.fromJson(productJson))
          .toList();

      return products;
    } on http.ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  Future<List<dynamic>> fetchHomeSpecialProducts() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/mobile/homeSpecial"));
      final productsJson = jsonDecode(response.body)['data']['data'] as List;
      final products = productsJson
          .map((productJson) => HomeProductModel.fromJson(productJson))
          .toList();

      return products;
    } on http.ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  Future<List<dynamic>> fetchProductsByCategory(String category) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/product/$category"));
      final productsJson = jsonDecode(response.body)['data'] as List;
      final products = productsJson
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList();
      // if (response.statusCode >= 200 && response.statusCode < 300) {
      //   print(
      //       "Request successful: ${response.statusCode} ${products.toString()}");
      // } else {
      //   print("Request failed: ${response.statusCode}");
      // }
      printJson(products);
      return products;
    } on http.ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  void printJson(jsonData) {
    var encoder = const JsonEncoder.withIndent('  ');
    var jsonString = encoder.convert(jsonData);
    print(jsonString);
  }

  Future<List<dynamic>> fetchProductsByCategoryAscDesc(
      String category, bool asc) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/product/$category/$asc"));
      final productsJson = jsonDecode(response.body)['data'] as List;
      final products = productsJson
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList();
      printJson(products);
      return products;
    } on http.ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  Future<List<dynamic>> fetchFilteredProducts(
      List<Map<String, int>> selectedPriceRange,
      List<String> selectedTags) async {
    await connect();
    print("I am inside fetchFilteredProducts");
    SelectorBuilder? selector;

    if (selectedPriceRange.isNotEmpty) {
      selector = where.eq("primaryPrice", {
        "\$gte": selectedPriceRange[0]['lower'],
        "\$lt": selectedPriceRange[0]['upper']
      });
      for (var range in selectedPriceRange.sublist(1)) {
        selector = selector?.or(where.eq(
            "primaryPrice", {"\$gte": range['lower'], "\$lt": range['upper']}));
      }
    }
    if (selectedTags.isNotEmpty) {
      selector = selector != null
          ? selector.and(where.oneFrom("tags", selectedTags))
          : where.oneFrom("tags", selectedTags);
    }

    try {
      var response = selector != null
          ? await productsCollection.find(selector).toList()
          : await productsCollection.find().toList();
      // print("The response is ${response.length}");
      final products = response
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList();
      printJson(products);
      return products;
    } catch (e) {
      rethrow;
    }
  }
}

// class ApiRepository {
//   final ApiService apiService = ApiService();
//   ApiRepository();

// /**alert: dynamic because some product loses some attribute may be secondaryDiscountedPrice */

//   Future<List<dynamic>> getHomeMain() async {
//     try {
//       final response = await apiService.sendRequest.get('/mobile/homeMain');
//       if (response.data != null) {
//         return response.data['data']['data']
//             .map((e) => HomeProductModel.fromJson(e))
//             .toList();
//       }
//       return <HomeProductModel>[];
//     } catch (ex) {
//       rethrow;
//     }
//   }

//   Future<List<HomeProductModel>> getHomeSpecial() async {
//     try {
//       final response = await apiService.sendRequest.get('/mobile/homeSpecial');
//       if (response.data != null) {
//         return List<HomeProductModel>.from(response.data['data']['data']
//             .map((e) => HomeProductModel.fromJson(e)));
//         // .toList() as List<HomeMainModel>;
//       }
//       return <HomeProductModel>[];
//     } catch (ex) {
//       rethrow;
//     }
//   }
// }
