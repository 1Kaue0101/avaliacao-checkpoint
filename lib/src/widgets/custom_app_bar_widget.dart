import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:checkpoint_final/src/services/cart_service.dart';
import 'package:checkpoint_final/src/screens/cart_screen.dart';
import 'package:checkpoint_final/src/screens/login_screen.dart';

// Cores globais UseDev
class UseDevColors {
  static const Color dark = Color(0xFF0D0D1A);
  static const Color darkCard = Color(0xFF13131F);
  static const Color purple = Color(0xFF780BF7);
  static const Color neonGreen = Color(0xFF8FFF24);
  static const Color neonPink = Color(0xFFFF55DF);
  static const Color white = Colors.white;
  static const Color grey = Color(0xFFAAAAAA);
  static const Color lightBg = Color(0xFFF5F5F5);
  static const Color cardBg = Color(0xFFFFFFFF);
}

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    final cart = CartService();
    return Container(
      color: UseDevColors.dark,
      child: SafeArea(
        child: Column(
          children: [
            // Linha principal: menu | logo | ícones
            SizedBox(
              height: 52,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                    ),
                    const Spacer(),
                    Image.asset('assets/logo_usedev.png', height: 36),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(width: 4),
                    ListenableBuilder(
                      listenable: cart,
                      builder: (context, _) => Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                              size: 28,
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CartScreen(),
                              ),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          if (cart.itemCount > 0)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: const BoxDecoration(
                                  color: UseDevColors.neonGreen,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${cart.itemCount}',
                                    style: const TextStyle(
                                      color: UseDevColors.dark,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Barra de busca
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: SizedBox(
                height: 40,
                child: TextField(
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: 'O que você procura?',
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    suffixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
