import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _State extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *0.20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 118,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/icons/cartb.png',),
              fit: BoxFit.cover,
              ),
            ),
          ),
      ),
    );
  }
}
