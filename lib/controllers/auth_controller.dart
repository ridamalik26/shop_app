import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/provider/user_provider.dart';
import 'package:shop_app/services/manage_http_response.dart';
import 'package:shop_app/views/screens/authentication_screen/login_screen.dart';
import 'package:shop_app/views/screens/main_screen.dart';

final providerContainer = ProviderContainer();
class AuthController {
  // -----------------------------
  // SIGN UP
  // -----------------------------
  Future<void> signUpUsers({
    required context,
    required String fullName,
    required String email,
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
          showSnackBar(context, 'Account has been Created for you');
        },
      );
    } catch (e) {}
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
        onSuccess: () async {
          //Access sharedPreferences for token and user data storage
          SharedPreferences preferences = await SharedPreferences.getInstance();

          //Extract the authentication token from the response body
          String token = jsonDecode(response.body)['token'];
          
          //Store tne authentication token securely in sharedPreference
          
          await preferences.setString('auth_token', token);

          //Encode the user data received from the backend as json
          final userJson = jsonEncode(jsonDecode(response.body)['user']);

          //update the application state with the user data using Riverpod
          providerContainer.read(userProvider.notifier).setUser(userJson);

          //store the data in sharePreference for future use

          await preferences.setString('user', userJson);
          
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> MainScreen()), (route) => false);
          showSnackBar(context, "Login Successful");
        },
      );
    } catch (e) {}
  }
}
