import 'package:flutter/material.dart';

/// Paleta medida diretamente no PNG exportado do Figma.
class AppColors {
  static const primary = Color(0xFF006631);
  static const green = Color(0xFF38A334);
  static const light = Color(0xFFA0D29E);
  static const orange = Color(0xFFFF902A);
  static const cream = Color(0xFFFFF6EB);
  static const ink = Color(0xFF1F2D22);
  static const muted = Color(0xFF7A8A7D);
  static const border = Color(0xFFE7EFE5);
  static const pale = Color(0xFFE8F3E6);
  static const orangeTint = Color(0xFFFFF1E0);
  static const grayTint = Color(0xFFEDF2EB);
  static const red = Color(0xFFC4462A);
  static const redTint = Color(0xFFFDE9E4);
  static const hint = Color(0xFFC3D2C0);
  static const axis = Color(0xFFAEBBAC);
  static const bar = Color(0xFF4E9A4B);
}

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.orange,
    ),
    scaffoldBackgroundColor: AppColors.cream,
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
  );
}
