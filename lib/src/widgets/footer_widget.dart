import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:checkpoint_final/src/widgets/custom_app_bar_widget.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UseDevColors.dark,
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo + slogan
          Center(child: Image.asset('assets/logo_usedev.png', height: 44)),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Hora de abraçar seu lado geek!',
              style: GoogleFonts.poppins(
                color: UseDevColors.neonGreen,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Color(0xFF2A2A3D)),
          ),
          _FooterSection(
            title: 'Funcionamento',
            items: const [
              'Segunda a Sexta – 8h às 18h',
              'sac@usedev.com.br',
              '0800 541 320',
            ],
          ),
          _FooterSection(
            title: 'Institucional',
            items: const [
              'Sobre nós',
              'Contato',
              'Política de Privacidade',
              'LGPD - Lei de proteção de dados',
            ],
          ),
          _FooterSection(
            title: 'Informações',
            items: const ['Entregas', 'Garantia', 'Trocas e devoluções'],
          ),
          // Formas de pagamento
          const SizedBox(height: 16),
          Text(
            'Formas de Pagamento',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _PaymentIcon(Icons.credit_card, 'VISA'),
              _PaymentIcon(Icons.credit_card, 'MC'),
              _PaymentIcon(Icons.pix, 'PIX'),
              _PaymentIcon(Icons.credit_card, 'ELO'),
              _PaymentIcon(Icons.diamond_outlined, 'PIX'),
            ],
          ),
          const SizedBox(height: 20),
          // Redes sociais
          Text(
            'Siga nossas redes:',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _SocialIcon(Icons.chat_bubble_outline, UseDevColors.neonGreen),
              const SizedBox(width: 16),
              _SocialIcon(Icons.camera_alt_outlined, UseDevColors.neonGreen),
              const SizedBox(width: 16),
              _SocialIcon(Icons.music_note_outlined, UseDevColors.neonGreen),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: Color(0xFF2A2A3D)),
          ),
          Center(
            child: Text(
              'Desenvolvido por Alura. Projeto fictício sem fins comerciais.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.white38, fontSize: 11),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  final String title;
  final List<String> items;
  const _FooterSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  color: UseDevColors.grey,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const _PaymentIcon(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, color: Colors.white70, size: 20),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _SocialIcon(this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
