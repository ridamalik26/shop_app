import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/models/products.dart';
import 'package:shop_app/views/screens/detail/screens/product_detail_screen.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ProductDetailScreen(product: product);
        }));
      },
      child: Container(
        width: 130,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Image.network(product.images[0], height: 180, width: 130,
                  fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 15,
                    right: 2,
                    child: Image.asset('assets/icons/love.png',
                    width: 26,
                    height: 26,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset('assets/icons/cart.png'),
                  height: 26,
                    width: 26,
                  )
                ],
              ),
            ),
            Text(
              product.productName,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
              fontSize: 13,
              color: const Color(0xff212121),
                fontWeight: FontWeight.bold,
            ),),
            product.averageRating==0?SizedBox():Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 12,),
                SizedBox(width: 4,),
                Text(
                  product.averageRating.toStringAsFixed(1),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Text(product.category,
              style: GoogleFonts.quicksand(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: const Color(
                  0xff867D84,
                ),
              ),
            ),
            Text('\$${product.productPrice.toStringAsFixed(2)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                color: Colors.purple
              ),
            )
          ],
        ),
      ),
    );
  }
}
