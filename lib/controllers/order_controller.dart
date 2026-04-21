import 'package:shop_app/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/services/manage_http_response.dart';

import '../global_variables.dart';


class OrderController {
  uploadOrders({
    required String id,
    required String fullName,
    required String email,
    required String state,
    required String city,
    required String productName,
    required int quantity,
    required int productPrice,
    required String category,
    required String image,
    required String buyerId,
    required String vendorId,
    required bool processing,
    required bool delivered,
    required context,
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
      manageHttpResponse(
          response: response, context: context, onSuccess: (){
            showSnackBar(context, 'Your order has been placed');
      });
    }catch (e){
      showSnackBar(context, e.toString());
    }
  }
}