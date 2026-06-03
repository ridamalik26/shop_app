import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/services/manage_http_response.dart';

import '../global_variables.dart';


class OrderController {
  Future<void> uploadOrders({
    required String id,
    required String fullName,
    required String email,
    required String state,
    required String city,
    required String locality,
    required String productName,
    required int quantity,
    required int productPrice,
    required String category,
    required String image,
    required String buyerId,
    required String vendorId,
    required bool processing,
    required bool delivered,
    required BuildContext context,
}
)async
  {
    try{
      final Order order = Order(
          id: id,
          fullName: fullName,
          email: email,
          state: state,
          city: city,
          locality: locality,
          productName: productName,
          quantity: quantity,
          productPrice: productPrice,
          category: category,
          image: image,
          buyerId: buyerId,
          vendorId: vendorId,
          processing: processing,
          delivered: delivered);

      http.Response response =  await http.post(Uri.parse("$uri/api/orders"),
        body: order.toJson(),
          headers: <String, String>{
            "Content-Type": 'application/json; charset=UTF-8'
              },
      );
      if (context.mounted) {
        manageHttpResponse(
            response: response, context: context, onSuccess: () {});
      }
    }catch (e){
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  //Method to get orders by buyer id

  Future<List<Order>> loadOrders({required String buyerId})async{
    try{
      //Send an HTTP GET req to get the orders by the buyerID
      http.Response response = await http.get(Uri.parse('$uri/api/orders/$buyerId'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
      );
      //check the response status code is 200(0)
      if(response.statusCode==200){
        //parse the json response body into dynamic list
        //this convert the json data into a format that can be further processed in dart
        List<dynamic> data = jsonDecode(response.body);
        //map the dynamic list to list to orders object using the form json factory method
        //this step converts the raw data into list of the orders instance, which are easier to work with
        List<Order> orders = data.map((order)=> Order.fromJson(order)).toList();
        return orders;
      } else {
        throw Exception("failed to load Orders");
      }
    } catch (e) {
        throw Exception('error Loading Orders: $e');
    }
  }

  Future<void> deleteOrder({required String id, required context})async{
    try{
      http.Response response = await http.delete(Uri.parse("$uri/api/orders/$id"),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
      );
      manageHttpResponse(response: response, context: context, onSuccess: () {
        
      });
    }
  catch (e) {
      showSnackBar(context, e.toString());
  }
  }
}