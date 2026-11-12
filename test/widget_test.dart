import 'package:divide_ai/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('abre na tela de login e entra no app', (tester) async {
    await tester.pumpWidget(const DivideAiApp());
    await tester.pumpAndSettle();

    expect(find.text('Entrar'), findsOneWidget);
    expect(find.text('Criar conta'), findsOneWidget);
  });
}
