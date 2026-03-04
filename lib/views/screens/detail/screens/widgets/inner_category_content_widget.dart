import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/controllers/product_controller.dart';
import 'package:shop_app/controllers/subcategory_controller.dart';
import 'package:shop_app/models/category.dart';
import 'package:shop_app/views/screens/detail/screens/widgets/inner_banner_widget.dart';
import 'package:shop_app/views/screens/detail/screens/widgets/subcategory_tile_widget.dart';
import 'package:shop_app/views/screens/nav_screen/widgets/reusable_text_widget.dart';

import '../../../../../models/products.dart';
import '../../../../../models/subcategory.dart';
import '../../../nav_screen/widgets/product_item_widget.dart';


class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;

  const InnerCategoryContentWidget({super.key, required this.category});

  @override
  State<InnerCategoryContentWidget> createState() => _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState extends State<InnerCategoryContentWidget> {
  late Future<List<Subcategory>> _subCategories;
  late Future<List<Product>> futureProducts;
  final SubcategoryController _subcategoryController = SubcategoryController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subCategories = _subcategoryController.getSubCategoriesByCategoryName(widget.category.name);
    futureProducts = ProductController().loadProductByCategory(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWidget(image: widget.category.banner),
            Center(child: Text('Shop By Subcategories', style: GoogleFonts.quicksand(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.7,
            ),),
            ),
            const SizedBox(height: 10),
            FutureBuilder(
              future: _subCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Categories'));
                } else {
                  final subcategories = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: List.generate(
                        (subcategories.length / 7).ceil(),
                            (setIndex) {
                          // for each row, calculate the starting and ending indices
                          final start = setIndex * 7;
                          final end = (setIndex + 1) * 7;

                          // Create a padding widget to add spacing around the row
                          return Padding(
                            padding: EdgeInsets.all(8.9),
                            child: Row(
                              // create a row of the subcategory tile
                              children: subcategories
                                  .sublist(
                                start,
                                end > subcategories.length
                                    ? subcategories.length
                                    : end,
                              )
                                  .map(
                                    (subcategory) => SubcategoryTileWidget(
                                  image: subcategory.image,
                                  title: subcategory.subCategoryName,
                                ),
                              )
                                  .toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  );

                }
              },
            ),
            const ReusableTextWidget(title: 'Popular Product', subtitle: 'View all'),
        FutureBuilder(future: futureProducts, builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasError){
            return Center(child: Text('Error ${snapshot.error}'),);
          }else if (!snapshot.hasData || snapshot.data!.isEmpty){
            return Center(
              child: Text('No Products under this category'),
            );
          }else{
            final products = snapshot.data;
            return SizedBox(
              height: 250,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products!.length,
                  itemBuilder: (context, index){
                    final product = products[index];
                    return ProductItemWidget( product: product,);
                  }),
            );
          }
        })
          ],
        ),
      ),
    );
  }
}
