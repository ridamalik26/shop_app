
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                      ],
                    ),
                ),
              ),
            );
          })
    );
  }
}
