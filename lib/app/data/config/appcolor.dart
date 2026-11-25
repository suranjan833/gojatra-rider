import 'package:material_ui/material_ui.dart';

class AppColors {
  AppColors._();

  // 2.1 Core Brand & Surface Colors
  static const Color warmIvory = Color(0xFFF8F6F0);
  static const Color deepForestGreen = Color(0xFF075B30);
  static const Color primaryDark = Color(0xFF054424);
  static const Color primaryLight = Color(0xFFEBF3EE);
  static const Color primaryMuted = Color(0xFF265939);
  static const Color forestCharcoal = Color(0xFF10251A);
  static const Color nearBlack = Color(0xFF171A18);
  static const Color softSlate = Color(0xFF656B66);
  static const Color textMuted = Color(0xFF888F8A);
  static const Color softWhite = Color(0xFFFFFFFB);
  static const Color stone = Color(0xFFF0EDE5);
  static const Color surfaceWarm = Color(0xFFF2ECE1);
  static const Color warmBeige = Color(0xFFDED7C9);
  static const Color borderLight = Color(0xFFEBE5DB);

  // Semantic Mappings
  static const Color background = warmIvory;
  static const Color primary = deepForestGreen;
  static const Color textPrimary = nearBlack;
  static const Color textSecondary = softSlate;
  static const Color surface = softWhite;
  static const Color cardBackground = softWhite;
  static const Color surfaceMuted = stone;
  static const Color border = warmBeige;
  static const Color divider = warmBeige;

  // 2.2 Accent & Functional Status Colors
  static const Color champagneGold = Color(0xFFC9A55A);
  static const Color freshGreen = Color(0xFF159447);
  static const Color mistBlue = Color(0xFFDCEAF0);
  static const Color error = Color(0xFFD32F2F);
  static const Color errorRed = Color(0xFFDC2626);
  static const Color info = Color(0xFF0284C7);
  static const Color accentOrange = Color(0xFFFE7002);
  static const Color shadow = Color(0x10000000);

  // 2.3 Gradients
  static const LinearGradient forestCharcoalGradient = LinearGradient(
    colors: [Color(0xFF132D20), Color(0xFF0D1E15)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF075B30), Color(0xFF054424)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient acceptButtonGradient = LinearGradient(
    colors: [Color(0xFF0A753E), Color(0xFF075B30), Color(0xFF054424)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
