import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:checkpoint_final/src/widgets/custom_app_bar_widget.dart';

class _CategoryItem {
  final String label;
  final String imageUrl;
  const _CategoryItem({required this.label, required this.imageUrl});
}

// Imagens via Unsplash (domínio público, sem autenticação)
const _categories = [
  _CategoryItem(
    label: 'Camisetas',
    imageUrl:
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400&q=80',
  ),
  _CategoryItem(
    label: 'Decoração',
    imageUrl:
        'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400&q=80',
  ),
  _CategoryItem(
    label: 'Canecas',
    imageUrl:
        'https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?w=400&q=80',
  ),
  _CategoryItem(
    label: 'Acessórios',
    imageUrl:
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&q=80',
  ),
];

class CategorySectionWidget extends StatelessWidget {
  const CategorySectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            'Categorias',
            style: GoogleFonts.orbitron(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) =>
                _CategoryCard(item: _categories[index]),
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final _CategoryItem item;
  const _CategoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              // Mostra shimmer enquanto carrega
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: UseDevColors.darkCard,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: UseDevColors.neonGreen,
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              // Fallback com ícone + label se a imagem falhar
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: BoxDecoration(
                  color: UseDevColors.dark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.white30,
                      size: 36,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.label,
                      style: GoogleFonts.poppins(
                        color: Colors.white38,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          item.label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
