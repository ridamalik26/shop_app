import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/provider/category_provider.dart';
import 'package:shop_app/views/screens/detail/screens/inner_category_screen.dart';
import 'package:shop_app/views/screens/nav_screen/widgets/reusable_text_widget.dart';

import '../../../../controllers/category_controller.dart';
import 'package:shop_app/models/category.dart' as model;

class CategoryWidget extends ConsumerStatefulWidget {
  const CategoryWidget({super.key});

  @override
  ConsumerState<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends ConsumerState<CategoryWidget> {

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async{
    final CategoryController categoryController = CategoryController();
    try{
      final categories = await categoryController.loadCategories();
      ref.read(categoryProvider.notifier).setCategories(categories);
    }catch(e){ }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableTextWidget(title: 'Categories', subtitle: 'View All'),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final model.Category category = categories[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return InnerCategoryScreen(category: category);
                    },
                  ),
                );
              },
              child: Column(
                children: [
                  Image.network(
                    category.image,
                    height: 47,
                    width: 47,
                  ),
                  Text(
                    category.name,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
