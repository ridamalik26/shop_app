import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/views/screens/nav_screen/widgets/reusable_text_widget.dart';

import '../../../../controllers/category_controller.dart';
import '../../../../models/category.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  //a future that will hold the list of categories once loaded from the api
  late Future<List<Category>> futureCategories;

  @override
  void initState(){

    super.initState();
    futureCategories = CategoryController().loadCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableTextWidget(title: 'Categories', subtitle: 'View all'),
        FutureBuilder(
            future: futureCategories,
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(),
                );
              }else if(snapshot.hasError){
                return Center(child: Text('Error ${snapshot.error}'),
                );
              }else if(!snapshot.hasData || snapshot.data!.isEmpty){
                return const Center(child: Text('No Categories'),);
              }else{
                final categories = snapshot.data!;
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categories.length ,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index){
                      final category = categories[index];
                      return Column(
                        children: [
                          Image.network(category.image,
                            height: 47,
                            width: 47,
                          ),
                          Text(category.name, style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),),
                        ],
                      );
                    });
              }
            }),
      ],
    );
  }
}
