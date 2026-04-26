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
    required WidgetRef ref,
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
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String token = jsonDecode(response.body)['token'];
          await preferences.setString('auth_token', token);

          final userJson = jsonEncode(jsonDecode(response.body)['user']);

          ref.read(userProvider.notifier).setUser(userJson);
          await preferences.setString('user', userJson);

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainScreen()), (route) => false);
          showSnackBar(context, "Login Successful");
        },
      );
    } catch (e) {}
  }
  //sign out
  Future<void> signOutUser({required context})async{
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //clear the token and user from SharedPreference
      await preferences.remove('auth_token');
      await preferences.remove('user');
      //clear the user state
      providerContainer.read(userProvider.notifier).signOut();
      //navigate the user back to the login screen

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
        return const LoginScreen();
      }), (route) => false);

      showSnackBar(context, 'Signed Out ');
    } catch (e){
      showSnackBar(context, "error signing out");
    }
  }
  //Update user's state,city and locality
  Future<void> updateUserLocation({
    required context,
    required WidgetRef ref,
    required String id,
    required String state,
    required String city,
    required String locality,
  })async{
    try{
      final http.Response response = await http.put(Uri.parse('$uri/api/users/$id'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          'state':state,
          'city':city,
          'locality':locality,
        }),
      );
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () async{
            final updatedUser = jsonDecode(response.body);
            SharedPreferences preferences = await SharedPreferences.getInstance();
            final userJson = jsonEncode(updatedUser);
            // Update Riverpod state so the UI reflects the new address
            ref.read(userProvider.notifier).setUser(userJson);
            // Persist updated user data so it survives app restarts
            await preferences.setString('user', userJson);
      });
    }catch (e) {
      showSnackBar(context, 'Error updating location');
    }
  }
}
