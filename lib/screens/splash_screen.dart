import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'auth_screens.dart';

/// Abertura do app (animação de `splash.html` em 1 s no total).
///
/// Na web a abertura é o HTML em `web/index.html`, que aparece enquanto o
/// Flutter carrega; esta tela é usada nas plataformas nativas.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  static const _bg = Color(0xFFFDF6EC);
  // Entrada em 1,2 s + fade de 0,3 s: 1,5 s no total, como na web.
  static const _total = Duration(milliseconds: 1200);

  late final _intro = AnimationController(vsync: this, duration: _total)
    ..forward().whenComplete(_goToLogin);
  late final _float = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1600))
    ..repeat();

  /// Intervalo [start, end] em segundos, na linha do tempo de 1,2 s.
  Animation<double> _at(double start, double end, Curve curve) =>
      CurvedAnimation(
        parent: _intro,
        curve: Interval(start / 1.2, math.min(end / 1.2, 1), curve: curve),
      );

  late final _glow = _at(.03, .73, Curves.easeOut);
  late final _ring1 = _at(.13, .93, Curves.easeOut);
  late final _ring2 = _at(.33, 1.13, Curves.easeOut);
  late final _icon = _at(.10, .55, const Cubic(.34, 1.56, .64, 1));
  late final _word = _at(.40, .80, const Cubic(.2, .8, .2, 1));
  late final _tag = _at(.65, .98, Curves.easeOut);

  void _goToLogin() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => const LoginScreen(),
      transitionsBuilder: (_, a, __, child) =>
          FadeTransition(opacity: a, child: child),
    ));
  }

  @override
  void dispose() {
    _intro.dispose();
    _float.dispose();
    super.dispose();
  }

  Widget _ring(Animation<double> a) => AnimatedBuilder(
        animation: a,
        builder: (_, __) {
          final t = a.value;
          // 0 -> 20%: aparece; 20% -> 100%: some enquanto cresce até 3,2x
          final opacity = t < .2 ? t / .2 * .8 : .8 * (1 - (t - .2) / .8);
          return Opacity(
            opacity: opacity.clamp(0, 1),
            child: Transform.scale(
              scale: .3 + 2.9 * t,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color(0x593C8A45), width: 2),
                ),
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .72;
    return Scaffold(
      backgroundColor: _bg,
      body: Semantics(
        label: 'divide aí: menos desperdício, mais propósito.',
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _glow,
              builder: (_, child) => Opacity(
                opacity: _glow.value,
                child: Transform.scale(
                    scale: .4 + .6 * _glow.value, child: child),
              ),
              child: Container(
                width: 420,
                height: 420,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    Color(0x38F08C35),
                    Color(0x2EAAD3A1),
                    Color(0x00AAD3A1),
                  ], stops: [0, .45, .7]),
                ),
              ),
            ),
            _ring(_ring1),
            _ring(_ring2),
            SizedBox(
              width: width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: Listenable.merge([_icon, _float]),
                    builder: (_, child) {
                      final t = _icon.value;
                      final f = _intro.isCompleted || t >= 1
                          ? math.sin(_float.value * math.pi)
                          : 0.0;
                      return Opacity(
                        opacity: (t / .6).clamp(0, 1),
                        child: Transform.translate(
                          offset: Offset(0, -6 * f),
                          child: Transform.rotate(
                            angle: (1 - t) * -25 * math.pi / 180,
                            child: Transform.scale(
                                scale: (.2 + .8 * t) * (1 + .02 * f),
                                child: child),
                          ),
                        ),
                      );
                    },
                    child: Image.asset('assets/brand/splash/icone.png',
                        width: width * .46),
                  ),
                  const SizedBox(height: 14),
                  AnimatedBuilder(
                    animation: _word,
                    builder: (_, child) => Opacity(
                      opacity: _word.value.clamp(0, 1),
                      child: Transform.translate(
                        offset: Offset(0, 16 * (1 - _word.value)),
                        child: ClipRect(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            widthFactor: _word.value.clamp(0, 1),
                            child: child,
                          ),
                        ),
                      ),
                    ),
                    child: Image.asset('assets/brand/splash/nome.png',
                        width: width),
                  ),
                  const SizedBox(height: 14),
                  AnimatedBuilder(
                    animation: _tag,
                    builder: (_, child) => Opacity(
                      opacity: _tag.value,
                      child: Transform.translate(
                          offset: Offset(0, 14 * (1 - _tag.value)),
                          child: child),
                    ),
                    child: Column(children: [
                      Image.asset('assets/brand/splash/slogan-1.png',
                          width: width * .69),
                      const SizedBox(height: 6),
                      Image.asset('assets/brand/splash/slogan-2.png',
                          width: width * .56),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
