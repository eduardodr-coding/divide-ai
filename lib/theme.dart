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
  static const fabRing = cream;
  static const homeIndicator = Color(0xFFA6C9B7);
}

/// Tipografia do Figma (Inter; "leading normal" do Figma = altura ~1.21).
/// Os nomes seguem o papel do texto nas telas.
class AppTypography {
  AppTypography._();

  static const _h = 1.21;

  /// "Olá, Maria!" (Figma: Inter Bold 24).
  static const greeting = TextStyle(
      fontSize: 24, height: _h, fontWeight: FontWeight.w700, color: Colors.white);

  /// Título do cabeçalho verde.
  static const headerTitle = TextStyle(
      fontSize: 17, height: 1.2, fontWeight: FontWeight.w700, color: Colors.white);

  /// Subtítulo do cabeçalho (Figma: Inter Regular 13, #A0D29E).
  static const headerSubtitle =
      TextStyle(fontSize: 13, height: _h, color: AppColors.light);

  /// Títulos de seção (Figma: Inter Bold 15, #006631).
  static const section = TextStyle(
      fontSize: 15, height: _h, fontWeight: FontWeight.w700, color: AppColors.primary);

  /// Título de card (Figma: Inter Bold 14).
  static const cardTitle = TextStyle(
      fontSize: 14, height: _h, fontWeight: FontWeight.w700, color: AppColors.ink);

  /// Número de métrica (Figma: Inter Bold 18, #006631).
  static const metric = TextStyle(
      fontSize: 18, height: _h, fontWeight: FontWeight.w700, color: AppColors.primary);

  /// Texto de botão (Figma: Inter Bold 16).
  static const button =
      TextStyle(fontSize: 16, height: _h, fontWeight: FontWeight.w700);

  /// Rótulo de campo (Figma: Inter Bold 12, #006631).
  static const fieldLabel = TextStyle(
      fontSize: 12, height: 1.33, fontWeight: FontWeight.w700, color: AppColors.primary);

  /// Texto digitado / placeholder (Figma: Inter 14).
  static const input =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.ink);
  static const hint = TextStyle(fontSize: 14, color: AppColors.muted);

  /// Links laranja ("Ver tudo", "Esqueci minha senha"): Inter Bold 12.
  static const link = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.orange);

  /// Texto secundário (Figma: Inter Regular 11, #7A8A7D).
  static const caption = TextStyle(fontSize: 11, color: AppColors.muted);

  /// Texto auxiliar menor (Figma: Inter Regular 10.5).
  static const small = TextStyle(fontSize: 10.5, color: AppColors.muted);

  /// Etiquetas (Figma: Inter Bold 11).
  static const tag = TextStyle(fontSize: 11, fontWeight: FontWeight.w700);

  /// Rótulos da barra inferior (Figma: Inter 10).
  static const navLabel = TextStyle(fontSize: 10, height: _h);
}

/// Espaçamentos recorrentes no Figma.
class AppSpacing {
  AppSpacing._();
  static const xxs = 4.0;
  static const xs = 6.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 20.0;

  /// Margem lateral das telas (cards começam em x=24 no frame de 390).
  static const screen = 24.0;
}

/// Raios de canto do Figma.
class AppRadius {
  AppRadius._();
  static const chip = 20.0;
  static const field = 14.0;
  static const button = 16.0;
  static const card = 18.0;
  static const cardLarge = 22.0;
  static const header = 25.0;
  static const bottomNav = 24.0;
  static const sheet = 28.0;
}

/// O Figma é "flat": cards usam borda #E7EFE5 em vez de sombra.
/// A única sombra é a de diálogos e folhas inferiores.
class AppShadows {
  AppShadows._();
  static const none = <BoxShadow>[];
  static const overlay = [
    BoxShadow(color: Color(0x1F1F2D22), blurRadius: 24, offset: Offset(0, 8)),
  ];
}

/// Medidas fixas do frame do Figma (iPhone 390 x 844).
class AppDimensions {
  AppDimensions._();
  static const frame = Size(390, 844);
  static const statusBar = 47.0;
  static const headerHeight = 85.0;
  static const bottomNav = 88.0;
  static const button = 56.0;
  static const field = 50.0;
  static const fab = 50.0;
  static const fabRing = 58.0;

  /// Tamanho nominal dos ícones do Figma (traço 1.56 -> 18.7; 1.7 -> 20.4).
  static const iconSm = 18.7;
  static const iconMd = 20.4;
}

/// Transição entre telas: a nova tela surge com fade e sobe suavemente,
/// enquanto a anterior recua um pouco.
class AppPageTransitions extends PageTransitionsBuilder {
  const AppPageTransitions();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final enter = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
    final exit =
        CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeInOut);
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(enter),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero)
            .animate(enter),
        child: ScaleTransition(
          scale: Tween<double>(begin: 1, end: 0.97).animate(exit),
          child: child,
        ),
      ),
    );
  }
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
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: AppPageTransitions(),
      TargetPlatform.iOS: AppPageTransitions(),
      TargetPlatform.windows: AppPageTransitions(),
      TargetPlatform.macOS: AppPageTransitions(),
      TargetPlatform.linux: AppPageTransitions(),
      TargetPlatform.fuchsia: AppPageTransitions(),
    }),
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
