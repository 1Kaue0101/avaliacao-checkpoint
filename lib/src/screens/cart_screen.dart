import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:checkpoint_final/src/services/auth_service.dart';
import 'package:checkpoint_final/src/services/cart_service.dart';
import 'package:checkpoint_final/src/screens/login_screen.dart';
import 'package:checkpoint_final/src/widgets/custom_app_bar_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> _handleCheckout(BuildContext context) async {
    final isLoggedIn = await AuthService().isLoggedIn();
    if (!context.mounted) return;

    if (!isLoggedIn) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Login necessário',
            style: GoogleFonts.orbitron(fontSize: 15),
          ),
          content: Text(
            'Você precisa estar logado para finalizar sua compra.',
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: UseDevColors.purple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: const Text('Fazer Login'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Pedido realizado com sucesso! 🎉',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      CartService().clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartService();
    return Scaffold(
      backgroundColor: UseDevColors.lightBg,
      appBar: AppBar(
        backgroundColor: UseDevColors.dark,
        foregroundColor: Colors.white,
        title: Text(
          'Carrinho',
          style: GoogleFonts.orbitron(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListenableBuilder(
        listenable: cart,
        builder: (context, _) {
          if (cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 72,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Seu carrinho está vazio',
                    style: GoogleFonts.orbitron(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Continuar comprando',
                      style: GoogleFonts.poppins(
                        color: UseDevColors.purple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                width: 70,
                                height: 70,
                                color: Colors.white,
                                padding: const EdgeInsets.all(4),
                                child: Image.network(
                                  item.product.image,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, _, _) => const Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    item.formattedTotalPrice,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          cart.decrement(item.product.id),
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.remove,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        '${item.quantity}',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          cart.increment(item.product.id),
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: UseDevColors.purple,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                GestureDetector(
                                  onTap: () =>
                                      cart.removeProduct(item.product.id),
                                  child: Text(
                                    'Remover',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: Colors.red[400],
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.red[400],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Rodapé com total + botão
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total (${cart.itemCount} itens)',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          cart.formattedTotalPrice,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _handleCheckout(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UseDevColors.purple,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Finalizar Compra',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
