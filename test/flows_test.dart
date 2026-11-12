import 'package:divide_ai/data.dart';
import 'package:divide_ai/main.dart';
import 'package:divide_ai/screens/donation_screens.dart';
import 'package:divide_ai/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fonts.dart';

Future<void> _pumpPhone(WidgetTester tester, Widget home) async {
  tester.view.physicalSize = const Size(390, 844) * 3;
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(MaterialApp(theme: buildTheme(), home: home));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  group('Login', () {
    testWidgets('exige e-mail válido antes de entrar', (tester) async {
      tester.view.physicalSize = const Size(390, 844) * 3;
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const DivideAiApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Entrar'));
      await tester.pump();
      expect(find.text('Informe seu e-mail'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField).first, 'maria@');
      await tester.tap(find.text('Entrar'));
      await tester.pump();
      expect(find.text('E-mail inválido'), findsOneWidget);

      await tester.enterText(
          find.byType(TextFormField).first, 'maria@email.com');
      await tester.tap(find.text('Entrar'));
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();
      expect(find.text('Olá, Maria!'), findsOneWidget);
    });
  });

  group('Quero receber', () {
    testWidgets('mostra as 18 doações ordenadas por distância',
        (tester) async {
      await _pumpPhone(tester, const ReceiveScreen());
      expect(nearbyDonations, hasLength(18));
      expect(find.text('18 doações · mais próximas primeiro'), findsOneWidget);
    });

    testWidgets('busca ignora acentos e maiúsculas', (tester) async {
      await _pumpPhone(tester, const ReceiveScreen());
      // "LATICINIOS" deve achar "Laticínios Vale Verde" (2 doações).
      await tester.enterText(find.byType(TextField), 'LATICINIOS');
      await tester.pumpAndSettle();

      expect(find.text('Iogurtes e queijos'), findsOneWidget);
      expect(find.text('Cesta de hortaliças'), findsNothing);
      expect(find.text('2 doações · mais próximas primeiro'), findsOneWidget);
    });

    testWidgets('chip filtra por categoria', (tester) async {
      await _pumpPhone(tester, const ReceiveScreen());
      await tester.tap(find.text('Frios'));
      await tester.pumpAndSettle();

      final frios =
          nearbyDonations.where((d) => d.category == 'Frios').length;
      expect(find.text('$frios doações · mais próximas primeiro'),
          findsOneWidget);
      expect(find.text('Cesta de hortaliças'), findsNothing);
    });

    testWidgets('busca sem resultado mostra estado vazio', (tester) async {
      await _pumpPhone(tester, const ReceiveScreen());
      await tester.enterText(find.byType(TextField), 'pizza');
      await tester.pumpAndSettle();

      expect(find.text('Nenhuma doação encontrada'), findsOneWidget);
      expect(find.text('0 doações · mais próximas primeiro'), findsOneWidget);
    });

    testWidgets('abre o detalhe da doação tocada', (tester) async {
      await _pumpPhone(tester, const ReceiveScreen());
      await tester.tap(find.text('Frutas variadas'));
      await tester.pumpAndSettle();

      expect(find.byType(DonationDetailScreen), findsOneWidget);
      expect(find.text('Rua São Jorge, 77 · Vila Nova'), findsOneWidget);
      expect(find.text('Banana, maçã, laranja, mamão e manga.'),
          findsOneWidget);
    });
  });

  testWidgets('solicitar doação pede confirmação', (tester) async {
    await _pumpPhone(tester, const DonationDetailScreen());
    await tester.tap(find.text('Solicitar esta doação'));
    await tester.pumpAndSettle();
    expect(find.text('Solicitar doação?'), findsOneWidget);

    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();
    expect(find.text('Solicitar doação?'), findsNothing);
    expect(find.byType(TrackScreen), findsNothing);
  });
}
