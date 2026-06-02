import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/controllers/product_controller.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/views/screens/nav_screen/widgets/product_item_widget.dart';

import '../../../../models/products.dart';

class PopularProductWidget extends ConsumerStatefulWidget {
  const PopularProductWidget({super.key});

  @override
  ConsumerState<PopularProductWidget> createState() => _PopularProductWidgetState();
}

class _PopularProductWidgetState extends ConsumerState<PopularProductWidget> {
  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }
    Future<void> _fetchProduct()async{
      final ProductController _productController = ProductController();
      try {
        final products = await _productController.loadPopularProducts();
        ref.read(productProvider.notifier).setProducts(products);
      }catch (e) {
        print("$e");
      }
    }
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
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
}
