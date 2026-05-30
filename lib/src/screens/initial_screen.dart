import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:checkpoint_final/src/models/product_model.dart';
import 'package:checkpoint_final/src/services/product_service.dart';
import 'package:checkpoint_final/src/widgets/custom_app_bar_widget.dart';
import 'package:checkpoint_final/src/widgets/hero_section_widget.dart';
import 'package:checkpoint_final/src/widgets/category_section_widget.dart';
import 'package:checkpoint_final/src/widgets/product_card_widget.dart';
import 'package:checkpoint_final/src/widgets/subscription_section_widget.dart';
import 'package:checkpoint_final/src/widgets/footer_widget.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final ProductService _productService = ProductService();

  List<ProductModel> _products = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final products = await _productService.fetchProducts(limit: 10);
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } on Exception catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UseDevColors.lightBg,
      appBar: const CustomAppBarWidget(),
      body: RefreshIndicator(
        color: UseDevColors.purple,
        onRefresh: _loadProducts,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const HeroSectionWidget(),
              const CategorySectionWidget(),
              // Seção "Promos Especiais"
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: Text(
                  'Promos especiais',
                  style: GoogleFonts.orbitron(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              _buildProductList(),
              // "Ver mais"
              if (!_isLoading && _errorMessage == null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Ver mais',
                        style: GoogleFonts.poppins(
                          color: UseDevColors.purple,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: UseDevColors.purple,
                        ),
                      ),
                    ),
                  ),
                ),
              const SubscriptionSectionWidget(),
              const FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductList() {
    if (_isLoading) {
      return const SizedBox(
        height: 260,
        child: Center(
          child: CircularProgressIndicator(color: UseDevColors.purple),
        ),
      );
    }
    if (_errorMessage != null) {
      return SizedBox(
        height: 260,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 56, color: Colors.grey),
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _loadProducts,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Tentar novamente'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: UseDevColors.purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _products.length,
      itemBuilder: (context, index) =>
          ProductCardWidget(product: _products[index]),
    );
  }
}
