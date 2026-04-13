import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *0.20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 118,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/icons/cartb.png',
                ),
              fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 322,
                    top: 52,
                    child: Stack(
                      children: [
                        Image.asset('assets/icons/not.png',
                        width: 25,
                          height: 25,
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade800,
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                              ),
                              child: Center(
                                child: Text('1', style: TextStyle() ,),
                              ),
                            ),
                        ),
                      ],
                    ),
                )
              ],
            ),
          ),
      ),
    );
  }
}
