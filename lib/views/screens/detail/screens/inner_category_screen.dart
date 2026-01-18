import 'package:flutter/material.dart';
import 'package:shop_app/models/category.dart' as model;
import 'package:shop_app/models/category.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;

  const InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.15 ,
        child: Stack(
          children: [
            Image.asset('assets/icons/searchBanner.jpeg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 1,
              top: 68,
              child: IconButton(onPressed: (){
                  Navigator.of(context).pop();
              },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
                left: 55,
                top: 68,
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter text',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF7F7F7F, ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      prefixIcon: Image.asset('assets/icons/search.png',
                      ),
                      suffixIcon: Image.asset('assets/icons/cam.png'),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      focusColor: Colors.black,
                    ),
                  ),
                )
            ),
            Positioned(
              left: 311,
              top: 78,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: (){},
                  child: Ink(
                    width: 31,
                    height: 31,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/icons/bell.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 354,
              top: 78,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: (){},
                  child: Ink(
                    width: 31,
                    height: 31,
                    decoration: const    BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/icons/message.png'
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
