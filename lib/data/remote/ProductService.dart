import 'package:das_app/data/model/all_products_response.dart';
import 'package:flutter/cupertino.dart';

import '../model/product_response.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<ProductResponse> getProducts(String userId) async {
    final response = await http.post(
      Uri.parse('http://das.makslab.com/api.php'),

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id':userId,
        'method': 'getProductsByUser',
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return ProductResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to get products.');
    }
  }

  static requestStock(String userId,int supervisorId,List<DataList> products) async {
    final response = await http.post(
      Uri.parse('http://das.makslab.com/api.php'),

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId':userId,
        'supervisorId':'$supervisorId',
        'products': jsonEncode(products.map((e) => e.toJson()).toList()),
        'method': 'requestStock',
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      debugPrint(response.body);
      return ProductResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to get sock request.');
    }
  }

  static Future<AllProductsResponse> getAllProducts() async {
    final response = await http.post(
      Uri.parse('http://das.makslab.com/api.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'method': 'getAllProducts',
      }),
    );
    if (response.statusCode == 200) {
      return AllProductsResponse.fromJson(
          jsonDecode(response.body) as List< dynamic>);
    } else {
      throw Exception('Failed to get all products.');
    }
  }
}