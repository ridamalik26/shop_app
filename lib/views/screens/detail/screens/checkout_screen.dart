import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/controllers/order_controller.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/user_provider.dart';
import 'package:shop_app/views/screens/detail/screens/shipping_address_screen.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String selectPaymentMethod = 'stripe';
  final OrderController _orderController = OrderController();

  Future<void> _placeOrder(BuildContext context) async {
    final user = ref.read(userProvider)!;
    final cartData = ref.read(cartProvider);

    for (final cartItem in cartData.values) {
      await _orderController.uploadOrders(
        id: '',
        fullName: user.fullName,
        email: user.email,
        state: user.state,
        city: user.city,
        locality: user.locality,
        productName: cartItem.productName,
        quantity: cartItem.quantity,
        productPrice: cartItem.productPrice,
        category: cartItem.category,
        image: cartItem.image[0],
        buyerId: user.id,
        vendorId: cartItem.vendorId,
        processing: true,
        delivered: false,
        context: context,
      );
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your order has been placed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final user = ref.watch(userProvider);
    final hasAddress = (user?.state ?? '').trim().isNotEmpty &&
        (user?.city ?? '').trim().isNotEmpty &&
        (user?.locality ?? '').trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ShippingAddressScreen();
                  }));
                },
                child: Container(
                  width: double.infinity,
                  height: 74,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFEFF0F2)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Container(
                        width: 43,
                        height: 43,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBF7F5),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Image.network(
                            height: 26,
                            width: 26,
                            'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F2ee3a5ce3b02828d0e2806584a6baa88.png',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hasAddress ? 'Delivery Address' : 'Add Address',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              hasAddress
                                  ? '${user!.state}, ${user.city}'
                                  : 'State, City',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3,
                              ),
                            ),
                            Text(
                              hasAddress ? user!.locality : 'Locality',
                              style: GoogleFonts.lato(
                                color: const Color(0xFF7F808C),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Your Item',
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.builder(
                itemCount: cartData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final cartItem = cartData.values.toList()[index];
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: 91,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFEFF0F2)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 6,
                            top: 6,
                            child: SizedBox(
                              width: 311,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 78,
                                    height: 78,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Image.network(
                                      cartItem.image[0],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(width: 11),
                                  Expanded(
                                    child: Container(
                                      height: 78,
                                      alignment: const Alignment(0, -0.51),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                cartItem.productName,
                                                style: GoogleFonts.quicksand(
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.3,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                cartItem.category,
                                                style: GoogleFonts.lato(
                                                  color: Colors.blueGrey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    "\$${cartItem.productPrice.toDouble().toStringAsFixed(2)}",
                                    style: GoogleFonts.robotoSerif(
                                      fontSize: 14,
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Text(
                'Choose Payment Method',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RadioGroup<String>(
                groupValue: selectPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    selectPaymentMethod = value!;
                  });
                },
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: Text(
                        'Stripe',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      value: 'stripe',
                    ),
                    RadioListTile<String>(
                      title: Text(
                        'Cash on Delivery',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: 'cashOnDelivery',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(25, 12, 25, 24),
        child: SizedBox(
          height: 58,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3854EE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () async {
              final u = ref.read(userProvider);
              if ((u?.state ?? '').trim().isEmpty ||
                  (u?.city ?? '').trim().isEmpty ||
                  (u?.locality ?? '').trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter your shipping address'),
                  ),
                );
              } else {
                await _placeOrder(context);
              }
            },
            child: Text(
              selectPaymentMethod == 'stripe' ? 'Pay Now' : 'Place Order',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
