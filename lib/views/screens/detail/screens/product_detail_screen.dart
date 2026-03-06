import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/models/products.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Popular Product",
          style: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
          )
        ],
      ),

      //  BODY OUTSIDE APPBAR
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 260,
              height: 275,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    top: 50,
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8DDFF),
                        borderRadius: BorderRadius.circular(130),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    top: 0,
                    child: Container(
                      width: 216,
                      height: 274,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9CA8FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: PageView.builder(
                        itemCount: widget.product.images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.product.images[index],
                            width: 198,
                            height: 225,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.productName, style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Color(
                    0xFF3C55Ef
                  ),
                ),
                ),
                Text(
                  "\$${widget.product.productPrice}", style: GoogleFonts.roboto(
                   fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(
                      0xFF3C55Ef
                  ),
                ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.product.category,
            style: GoogleFonts.roboto(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    letterSpacing: 1.7,
                    color: const Color(0xFF363330),
                  ),
                ),
                Text(
                  widget.product.description,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 15,
                    letterSpacing: 2,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}