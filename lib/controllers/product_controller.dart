import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/models/products.dart';

import '../global_variables.dart';

class ProductController {
  //Define a function that returns a future containing list of the product model objects
  Future<List<Product>> loadPopularProducts()async{
    try{
      http.Response response = await http.get(
        Uri.parse("$uri/api/popular-products"),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
      );
      // check if the HTTP response status code is 200, which means the request was successful
      if (response.statusCode == 200) {
        // Decode the json response body into a List of dynamic object
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;

        // map each items in the list to product model object which we can use
        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();

        return products;
      } else {
        // if status code is not 200, throw an exception indicating failure to load the popular products
        throw Exception('Failed to load popular products');
      }
    } catch (e) {
      throw Exception('Error loading product : $e');
    }
  }
  //load product by category function
  Future<List<Product>> loadProductByCategory(String category) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products-by-category/$category'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // 🔥 PRINT STATUS CODE
      print("Status Code: ${response.statusCode}");

      // 🔥 PRINT RAW BODY
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        print("Decoded Data: $data"); // 🔥 decoded print

        List<Product> products = data
            .map((product) =>
            Product.fromMap(product as Map<String, dynamic>))
            .toList();

        return products;
      } else {
        print("Error Response: ${response.body}");
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print("Exception Occurred: $e");
      rethrow;
    }
  }
}