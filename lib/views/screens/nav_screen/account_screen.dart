import 'package:flutter/material.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/views/screens/detail/screens/order_screen.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(onPressed: () async{
        // await _authController.signOutUser(context: context);
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return OrderScreen();
        }));
      }, child: Text('My Orders')),
        
      ),
    );
  }
}
