import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.96),
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.96),
        elevation: 0,
        title: Text(
          'Delivery',
              style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            letterSpacing: 1.7,
            fontSize: 17
        ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                'Where will your order\n be shipped',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  letterSpacing: 1.7,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
