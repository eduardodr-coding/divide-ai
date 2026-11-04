import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/auth_screens.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const DivideAiApp());
}

class DivideAiApp extends StatelessWidget {
  const DivideAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'divide aí',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const LoginScreen(),
      // Em telas largas (web/desktop) mostra o app no frame de 390x844 do Figma.
      builder: (context, child) {
        final media = MediaQuery.of(context);
        if (media.size.width <= 600) return child!;
        final size = Size(390, math.min(media.size.height, 844));
        return ColoredBox(
          color: const Color(0xFFF2F0EB),
          child: Center(
            child: SizedBox.fromSize(
              size: size,
              child: MediaQuery(
                data: media.copyWith(size: size),
                child: ClipRect(child: child!),
              ),
            ),
          ),
        );
      },
    );
  }
}
