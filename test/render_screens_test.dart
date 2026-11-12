// Renderiza cada tela em 390x844 (o frame do Figma) e salva um PNG em
// build/screens/ para comparar com o design.
//
//   flutter test test/render_screens_test.dart --tags render
@Tags(['render'])
library;

import 'dart:io';
import 'dart:ui' as ui;

import 'package:divide_ai/screens/auth_screens.dart';
import 'package:divide_ai/screens/donation_screens.dart';
import 'package:divide_ai/screens/other_screens.dart';
import 'package:divide_ai/screens/shell.dart';
import 'package:divide_ai/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fonts.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
    Directory('build/screens').createSync(recursive: true);
  });

  final screens = <String, Widget>{
    '01-login': const LoginScreen(),
    '02-home': const AppShell(initialIndex: 0),
    '03-acompanhar': const TrackScreen(),
    '04-quero-doar': const DonateScreen(),
    '05-doacao-publicada': const PublishedScreen(),
    '06-quero-receber': const ReceiveScreen(),
    '07-detalhe': const DonationDetailScreen(),
    '08-minhas-doacoes': const AppShell(initialIndex: 1),
    '09-relatorios': const ReportsScreen(),
    '10-mensagens': const AppShell(initialIndex: 2),
    '11-perfil': const AppShell(initialIndex: 3),
    '12-criar-conta': const CreateAccountScreen(),
  };

  for (final e in screens.entries) {
    testWidgets('render ${e.key}', (tester) async {
      tester.view.physicalSize = const Size(390, 844) * 2;
      tester.view.devicePixelRatio = 2;
      tester.view.padding = FakeViewPadding.zero;
      addTearDown(tester.view.reset);

      final key = GlobalKey();
      await tester.pumpWidget(RepaintBoundary(
        key: key,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: buildTheme(),
          home: e.value,
        ),
      ));
      await tester.pumpAndSettle();
      // Os SVGs (flutter_svg) carregam de forma assíncrona.
      for (var i = 0; i < 3; i++) {
        await tester.runAsync(
            () => Future<void>.delayed(const Duration(milliseconds: 150)));
        await tester.pumpAndSettle();
      }

      await tester.runAsync(() async {
        final boundary =
            key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        final image = await boundary.toImage(pixelRatio: 2);
        final png = await image.toByteData(format: ui.ImageByteFormat.png);
        File('build/screens/${e.key}.png')
            .writeAsBytesSync(png!.buffer.asUint8List());
      });
    });
  }
}
