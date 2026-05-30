import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:checkpoint_final/src/widgets/custom_app_bar_widget.dart';

class SubscriptionSectionWidget extends StatelessWidget {
  const SubscriptionSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UseDevColors.neonGreen,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Inscreva-se para ganhar\ndescontos!',
            textAlign: TextAlign.center,
            style: GoogleFonts.orbitron(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Cadastre seu email, receba novidades e descontos imperdíveis antes de todo mundo!',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 14),
          TextField(
            keyboardType: TextInputType.emailAddress,
            style: GoogleFonts.poppins(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Digite seu melhor endereço de email',
              hintStyle: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey[600],
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: UseDevColors.purple,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                'Inscrever',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
