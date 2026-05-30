import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:checkpoint_final/src/widgets/custom_app_bar_widget.dart';

class HeroSectionWidget extends StatelessWidget {
  const HeroSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fundo com imagem (grid roxo) + overlay escuro
        SizedBox(
          height: 340,
          width: double.infinity,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/banner_cta.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Conteúdo sobre a imagem
        SizedBox(
          height: 340,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Imagem hero (camiseta/personagem)
              Image.asset(
                'assets/hero_cta.png',
                height: 160,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 12),
              // Texto neon
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  style: GoogleFonts.orbitron(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                  ),
                  children: [
                    TextSpan(
                      text: 'Hora de abraçar\nseu ',
                      style: const TextStyle(color: UseDevColors.neonPink),
                    ),
                    TextSpan(
                      text: 'lado geek!',
                      style: const TextStyle(color: UseDevColors.neonGreen),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: UseDevColors.purple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Ver as novidades!',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
