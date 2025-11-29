import 'package:flutter/material.dart';
import 'package:shop_app/views/screens/nav_screen/widgets/header_widget.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(),
          ],
        ),
      )
    );
  }
}
