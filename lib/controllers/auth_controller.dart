import 'dart:convert';

import 'package:shop_app/global_variables.dart';
import 'package:shop_app/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/services/manage_http_response.dart';

class AuthController {
  // -----------------------------
  // SIGN UP
  // -----------------------------
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
        token: '',
      );

      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account has been Created for you');
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  // -----------------------------
  // SIGN IN
  // -----------------------------
  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Login Successful");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }
}
