import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../provider/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
      ),

      body: cartItems.isEmpty
          ? const Center(
        child: Text(
          "Your cart is empty",
          style: TextStyle(fontSize: 18),
        ),
      )
          : Column(
        children: [

          /// CART ITEMS
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {

                final cartItem =
                cartItems.values.toList()[index];

                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),

                  child: Row(
                    children: [

                      /// PRODUCT IMAGE
                      ClipRRect(
                        borderRadius:
                        BorderRadius.circular(12),
                        child: Image.network(
                          cartItem.image[0],
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 12),

                      /// PRODUCT NAME + PRICE
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Text(
                              cartItem.productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              "\$${cartItem.productPrice}",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// QUANTITY BUTTONS
                      Row(
                        children: [

                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              cartNotifier
                                  .decrementCartItem(
                                  cartItem.productId);
                            },
                          ),

                          Text(
                            cartItem.quantity.toString(),
                            style: const TextStyle(
                                fontSize: 16),
                          ),

                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              cartNotifier
                                  .incrementCartItem(
                                  cartItem.productId);
                            },
                          ),
                        ],
                      ),

                      /// DELETE BUTTON
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          cartNotifier.removeCartItem(
                              cartItem.productId);
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),

          /// TOTAL PRICE SECTION
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.black12,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [

                const Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "\$${cartNotifier.calculateTotalAmount()}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}