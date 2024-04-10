import 'dart:convert';

import 'package:fic4_project/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

import '../models/request/product_model.dart';

class ProductDatasource {
  Future<ProductResponseModel> createProduct(ProductModel model) async {
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/products/'),
      headers: headers,
      body: model.toJson(),
      
    );
    print(response);
    return ProductResponseModel.fromJson(response.body);
  }

  Future<ProductResponseModel> updateProduct(ProductModel model, int id) async {
    final response = await http.put(
      Uri.parse('https://api.escuelajs.co/api/v1/products/$id'),
      body: model.toMap(),
    );
    return ProductResponseModel.fromJson(response.body);
  }

  Future<ProductResponseModel> getProductById(int id) async {
    final response = await http.put(
      Uri.parse('https://api.escuelajs.co/api/v1/products/$id'),
    );
    return ProductResponseModel.fromJson(response.body);
  }

  Future<List<ProductResponseModel>> getAllProduct() async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products/'),
    );

    final result = List<ProductResponseModel>.from(jsonDecode(response.body)
        .map((x) => ProductResponseModel.fromMap(x))
        .toList());
    return result;
  }
}
