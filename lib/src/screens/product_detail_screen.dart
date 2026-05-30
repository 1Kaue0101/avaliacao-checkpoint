import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:checkpoint_final/src/models/product_model.dart';
import 'package:checkpoint_final/src/services/cart_service.dart';
import 'package:checkpoint_final/src/widgets/custom_app_bar_widget.dart';
import 'package:checkpoint_final/src/widgets/footer_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({required this.product, super.key});
  final ProductModel product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? _selectedColor;
  String? _selectedSize;
  int _quantity = 1;

  static const _colors = ['Bege', 'Branca', 'Cinza'];
  static const _sizes = ['P', 'M', 'G', 'GG'];

  void _addToCart() {
    for (int i = 0; i < _quantity; i++) {
      CartService().addProduct(widget.product);
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${widget.product.title} adicionado ao carrinho!',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: UseDevColors.purple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UseDevColors.lightBg,
      appBar: AppBar(
        backgroundColor: UseDevColors.dark,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detalhes do Produto',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem grande
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 280,
              padding: const EdgeInsets.all(24),
              child: Image.network(
                widget.product.image,
                fit: BoxFit.contain,
                loadingBuilder: (_, child, p) => p == null
                    ? child
                    : const Center(
                        child: CircularProgressIndicator(
                          color: UseDevColors.purple,
                        ),
                      ),
                errorBuilder: (_, _, _) => const Icon(
                  Icons.broken_image,
                  size: 80,
                  color: Colors.grey,
                ),
              ),
            ),

            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome
                  Text(
                    widget.product.title,
                    style: GoogleFonts.orbitron(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Ações (share, favorito)
                  Row(
                    children: [
                      Icon(
                        Icons.share_outlined,
                        color: Colors.grey[600],
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.favorite_border,
                        color: Colors.grey[600],
                        size: 22,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Descrição curta
                  Text(
                    widget.product.description.length > 60
                        ? '${widget.product.description.substring(0, 60)}...'
                        : widget.product.description,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Preço
                  Text(
                    // Exibe só o número (sem "R$") como no Figma
                    widget.product.price
                        .toStringAsFixed(2)
                        .replaceAll('.', ','),
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Cor do tecido
                  Text(
                    'Escolha a cor do tecido',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._colors.map(
                    (color) => RadioListTile<String>(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        color,
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      value: color,
                      groupValue: _selectedColor,
                      activeColor: UseDevColors.purple,
                      onChanged: (v) => setState(() => _selectedColor = v),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Quantidade (dropdown)
                  _StyledDropdown(
                    label: 'Quantidade',
                    value: _quantity.toString(),
                    items: List.generate(10, (i) => '${i + 1}'),
                    onChanged: (v) => setState(() => _quantity = int.parse(v!)),
                  ),
                  const SizedBox(height: 12),

                  // Tamanho (dropdown)
                  _StyledDropdown(
                    label: 'Tamanho',
                    value: _selectedSize,
                    items: _sizes,
                    onChanged: (v) => setState(() => _selectedSize = v),
                  ),

                  const SizedBox(height: 24),

                  // Botão adicionar ao carrinho
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _addToCart,
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      label: Text(
                        'Adicionar ao carrinho',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UseDevColors.purple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}

class _StyledDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _StyledDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(
            label,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
