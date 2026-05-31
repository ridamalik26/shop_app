
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
            return ListTile(
              title: Text(order.productName),
            );
          })
    );
  }
}
