
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/controllers/order_controller.dart';
import 'package:shop_app/provider/order_provider.dart';
import 'package:shop_app/provider/user_provider.dart';

import '../../../../models/order.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }
  Future<void> _fetchOrders()async{
    final user =ref.read(userProvider);
    if(user!=null){
      final OrderController orderController = OrderController();
      try{
        final orders = await orderController.loadOrders(buyerId: user.id);
        ref.read(orderProvider.notifier).setOrders(orders);
      }catch (e) {
        print('Error fetching order:$e');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderProvider);
    return Scaffold(
      body: orders.isEmpty?Center(child: Text('No Order Found'),):
          ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index){
            final Order order = orders[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25 ),
              child: Container(
                width: 335,
                height: 153,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                  child: SizedBox(
                  width: double.infinity,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 336,
                            height: 154,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(
                                  0xFFEFF0F2,
                                )
                              ),
                              borderRadius: BorderRadius.circular(9,)
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                    left: 13,
                                    top: 9,
                                    child: Container(
                                      width: 78,
                                      height: 78,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xFFBCC5FF
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                              left: 10,
                                              top: 5,
                                              child: Image.network(order.image,
                                                width: 58,
                                                height: 67,
                                                fit: BoxFit.cover,
                                              ),
                                          ),
                                        ],
                                      ),
                                    ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 101,
                            top: 14,
                            child: SizedBox(
                              width: 216,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            order.productName,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4,),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              order.category,
                                              style: GoogleFonts.montserrat(
                                                color: const Color(0xFF7F808C),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12
                                              ),
                                          ),
                                        ),
                                        const SizedBox(height: 2,),
                                        Text(
                                          "\$${order.productPrice.toStringAsFixed(2)}",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            color: Color(0xFF0B0C1E,)
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                        ),
                        Positioned(
                            left: 13,
                            top: 113,
                            child: Container(
                              width: 100,
                              height: 25,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: order.delivered==true
                                    ? const Color(0xFF3C55EF):
                                order.processing==true?
                                  Colors.purple:Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                      left: 9,
                                      top: 3,
                                      child: Text(
                                        order.delivered==true
                                            ?"Delivered"
                                            : order.processing == true
                                            ? "Processing"
                                            : "Cancelled",
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.3,
                                        ),
                                      ),
                                  ),
                                ],
                              ),
                            ),
                        ),
                      ],
                    ),
                ),
              ),
            );
          })
    );
  }
}
