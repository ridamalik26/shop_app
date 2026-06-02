import 'package:flutter_riverpod/legacy.dart';
import 'package:shop_app/models/products.dart';

class ProductProvider extends StateNotifier<List<Product>>{
  ProductProvider(): super([]);

  //set the list of products
  void setProducts(List<Product> products){
    state = products;
  }
}

final productProvider =
    StateNotifierProvider<ProductProvider, List<Product>>((ref) {
  return ProductProvider();
});