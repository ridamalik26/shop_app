import 'package:flutter/cupertino.dart';
import 'package:shop_app/views/screens/nav_screen/widgets/header_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderWidget(),
      ],
    );
  }
}
