import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:checkpoint_final/src/models/product_model.dart';
import 'package:checkpoint_final/src/screens/product_detail_screen.dart';
import 'package:checkpoint_final/src/widgets/custom_app_bar_widget.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({required this.product, super.key});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: UseDevColors.cardBg,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Imagem quadrada à esquerda
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: SizedBox(
                width: 110,
                height: 110,
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  loadingBuilder: (_, child, progress) => progress == null
                      ? child
                      : const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                  errorBuilder: (_, _, _) =>
                      const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
            // Infos à direita
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.formattedPrice,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
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
  }
}
