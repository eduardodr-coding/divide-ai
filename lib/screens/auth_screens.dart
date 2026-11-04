import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets.dart';
import 'shell.dart';

void _enterApp(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => const AppShell()),
    (_) => false,
  );
}

/// Ilustração do topo do login, desenhada nas coordenadas do frame 390x262.
class _LoginHeroPainter extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final dx = (s.width - 390) / 2;
    c.translate(dx, 0);
    Paint p(Color color) => Paint()..color = color;

    // círculo claro ao fundo
    c.drawCircle(const Offset(195, 140), 84, p(const Color(0xFFC0E1BF)));

    // prédios
    final bar = p(const Color(0xFF70B27D));
    for (final r in const [
      Rect.fromLTWH(30, 140, 34, 76),
      Rect.fromLTWH(70, 112, 26, 104),
      Rect.fromLTWH(102, 154, 22, 62),
      Rect.fromLTWH(268, 130, 28, 86),
      Rect.fromLTWH(302, 106, 24, 110),
      Rect.fromLTWH(332, 148, 30, 68),
    ]) {
      c.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(4)), bar);
    }

    // linha do chão
    c.drawRect(Rect.fromLTWH(-dx, 216, s.width, 7), p(const Color(0xFF6CBA69)));

    // alça da cesta
    c.drawArc(
      Rect.fromCircle(center: const Offset(191.5, 145), radius: 22.5),
      3.14159,
      3.14159,
      false,
      Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
    );

    // frutas
    c.drawCircle(const Offset(172, 150), 13, p(AppColors.green));
    c.drawCircle(const Offset(212, 149), 16, p(AppColors.primary));
    c.save();
    c.translate(223, 132);
    c.rotate(-0.6);
    c.drawOval(
        Rect.fromCenter(center: Offset.zero, width: 22, height: 10),
        p(AppColors.green));
    c.restore();
    c.drawCircle(const Offset(191, 154), 11, p(const Color(0xFFFFD9A3)));

    // vaso laranja
    final pot = Path()
      ..moveTo(152, 175)
      ..lineTo(238, 175)
      ..lineTo(232, 214)
      ..quadraticBezierTo(231, 220, 225, 220)
      ..lineTo(165, 220)
      ..quadraticBezierTo(159, 220, 158, 214)
      ..close();
    c.drawPath(pot, p(const Color(0xFFF2621F)));

    // borda da cesta
    c.drawRRect(
        RRect.fromRectAndRadius(
            const Rect.fromLTWH(144, 160, 102, 15), const Radius.circular(7.5)),
        p(AppColors.primary));
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ---------------------------------------------------------------- 01 Login
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenFrame(
        child: LayoutBuilder(
          builder: (context, box) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: box.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 262,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.light,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(28)),
                    ),
                    child: CustomPaint(painter: _LoginHeroPainter()),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 24, 32, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppField(
                          label: 'E-mail',
                          hint: 'maria@email.com',
                          icon: Icons.person_outline,
                          iconLeft: 6,
                          iconSize: 17,
                          textLeft: 24,
                          height: 54,
                          keyboard: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 15.5),
                        const AppField(
                          label: 'Senha',
                          initial: 'senha123',
                          password: true,
                          textLeft: 24,
                          height: 54,
                        ),
                        const SizedBox(height: 15.5),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text('Esqueci minha senha',
                                style: TextStyle(
                                    color: AppColors.orange,
                                    fontSize: 12,
                                    height: 1.33,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                        const SizedBox(height: 18.5),
                        PrimaryButton(
                            label: 'Entrar',
                            onPressed: () => _enterApp(context)),
                        const SizedBox(height: 9.5),
                        OutlineAppButton(
                          label: 'Criar conta',
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CreateAccountScreen()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------- 12 Criar conta
class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _donor = true;
  bool _accepted = false;

  Widget _roleCard({
    required bool selected,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String sub,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          height: 108,
          decoration: BoxDecoration(
            color: selected ? AppColors.pale : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: selected ? AppColors.primary : AppColors.border,
                width: selected ? 2 : 1),
          ),
          child: Stack(
            children: [
              Positioned(
                left: selected ? 18 : 19,
                top: selected ? 12 : 13,
                child: IconCircle(
                  icon: icon,
                  fg: iconColor,
                  bg: selected ? Colors.white : AppColors.cream,
                ),
              ),
              if (selected)
                const Positioned(
                  right: 12,
                  top: 8,
                  child: CircleAvatar(
                    radius: 11,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.check, size: 15, color: Colors.white),
                  ),
                ),
              Positioned(
                left: 16,
                top: 58,
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 13,
                        height: 1.3,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary)),
              ),
              Positioned(
                left: 16,
                top: 77.7,
                child: Text(sub,
                    style: const TextStyle(
                        fontSize: 10.5, height: 1.3, color: AppColors.muted)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _terms(List<Widget> line) => Row(children: line);

  @override
  Widget build(BuildContext context) {
    const small = TextStyle(fontSize: 12, height: 1.5, color: AppColors.muted);
    const link = TextStyle(
        fontSize: 12,
        height: 1.5,
        fontWeight: FontWeight.w700,
        color: AppColors.orange);
    return Scaffold(
      body: ScreenFrame(
        child: Column(
          children: [
            const AppHeader(
                title: 'Criar conta', subtitle: 'Leva menos de 2 minutos'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 46, 24, 40),
                children: [
                  const Text('Como você quer participar?',
                      style: TextStyle(
                          fontSize: 15,
                          height: 1.3,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary)),
                  const SizedBox(height: 20.25),
                  Row(
                    children: [
                      _roleCard(
                        selected: _donor,
                        icon: Icons.card_giftcard_outlined,
                        iconColor: AppColors.primary,
                        title: 'Quero doar',
                        sub: 'Tenho alimentos',
                        onTap: () => setState(() => _donor = true),
                      ),
                      const SizedBox(width: 14),
                      _roleCard(
                        selected: !_donor,
                        icon: Icons.shopping_bag_outlined,
                        iconColor: AppColors.green,
                        title: 'Quero receber',
                        sub: 'Preciso de alimentos',
                        onTap: () => setState(() => _donor = false),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const AppField(
                      label: 'Nome completo',
                      initial: 'Maria Nascimento',
                      icon: Icons.person_outline),
                  const SizedBox(height: 6),
                  const AppField(
                      label: 'E-mail',
                      initial: 'maria@email.com',
                      icon: Icons.mail_outline,
                      keyboard: TextInputType.emailAddress),
                  const SizedBox(height: 6),
                  const AppField(
                      label: 'CPF ou CNPJ',
                      hint: '000.000.000-00',
                      icon: Icons.assignment_outlined,
                      keyboard: TextInputType.number),
                  const SizedBox(height: 6),
                  const AppField(
                      label: 'Senha',
                      hint: 'mínimo 8 caracteres',
                      icon: Icons.shield_outlined,
                      password: true),
                  const SizedBox(height: 21.5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.5),
                        child: GestureDetector(
                          onTap: () => setState(() => _accepted = !_accepted),
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _accepted
                                  ? AppColors.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: _accepted
                                      ? AppColors.primary
                                      : AppColors.green,
                                  width: 2),
                            ),
                            child: _accepted
                                ? const Icon(Icons.check,
                                    size: 14, color: Colors.white)
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _terms(const [
                            Text('Li e aceito os', style: small),
                            SizedBox(width: 8),
                            Text('Termos de uso', style: link),
                          ]),
                          _terms(const [
                            Text('e a', style: small),
                            SizedBox(width: 6),
                            Text('Política de privacidade.', style: link),
                          ]),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 26.5),
                  PrimaryButton(
                    label: 'Criar minha conta',
                    onPressed: _accepted ? () => _enterApp(context) : null,
                  ),
                  const SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Já tem conta?',
                          style: TextStyle(
                              fontSize: 12,
                              height: 1.33,
                              color: AppColors.muted)),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: const Text('Entrar',
                            style: TextStyle(
                                fontSize: 12,
                                height: 1.33,
                                fontWeight: FontWeight.w700,
                                color: AppColors.orange)),
                      ),
                    ],
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
