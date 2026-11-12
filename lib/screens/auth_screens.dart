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
final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

String? validateEmail(String v) {
  if (v.trim().isEmpty) return 'Informe seu e-mail';
  if (!_emailPattern.hasMatch(v.trim())) return 'E-mail inválido';
  return null;
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController(text: 'senha123');
  String? _emailError, _passwordError;
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _emailError = validateEmail(_email.text);
      _passwordError =
          _password.text.isEmpty ? 'Informe sua senha' : null;
    });
    if (_emailError != null || _passwordError != null) return;
    setState(() => _loading = true);
    // Protótipo: sem backend ainda, simula a autenticação.
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (mounted) _enterApp(context);
  }

  void _forgotPassword() {
    final controller = TextEditingController(text: _email.text);
    showAppSheet<void>(
      context,
      title: 'Recuperar senha',
      builder: (sheet) {
        String? error;
        return StatefulBuilder(
          builder: (sheet, setSheet) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Enviaremos um link para você criar uma nova senha.',
                  style: AppTypography.caption),
              const SizedBox(height: AppSpacing.lg),
              AppField(
                label: 'E-mail',
                hint: 'maria@email.com',
                icon: Icons.mail_outline,
                controller: controller,
                keyboard: TextInputType.emailAddress,
                errorText: error,
              ),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                label: 'Enviar link',
                onPressed: () {
                  final e = validateEmail(controller.text);
                  if (e != null) return setSheet(() => error = e);
                  Navigator.pop(sheet);
                  showAppSnack(context,
                      'Link enviado para ${controller.text.trim()}');
                },
              ),
            ],
          ),
        );
      },
    ).whenComplete(controller.dispose);
  }

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
                  Column(
                    children: [
                      Container(
                        height: 262,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.light,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(28)),
                        ),
                        child: CustomPaint(painter: _LoginHeroPainter()),
                      ),
                      // Figma: "logo-divide-ai", 326 x 137, 24 abaixo do topo.
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Image.asset(
                          'assets/brand/logo-completa.png',
                          width: 326,
                          height: 137,
                          fit: BoxFit.contain,
                          semanticLabel:
                              'divide aí: menos desperdício, mais propósito',
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 24, 32, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppField(
                          label: 'E-mail',
                          hint: 'maria@email.com',
                          icon: Icons.person_outline,
                          iconLeft: 6,
                          iconSize: 17,
                          textLeft: 24,
                          height: 54,
                          keyboard: TextInputType.emailAddress,
                          action: TextInputAction.next,
                          controller: _email,
                          errorText: _emailError,
                          onChanged: (_) {
                            if (_emailError != null) {
                              setState(() => _emailError = null);
                            }
                          },
                        ),
                        const SizedBox(height: 15.5),
                        AppField(
                          label: 'Senha',
                          password: true,
                          textLeft: 24,
                          height: 54,
                          action: TextInputAction.done,
                          controller: _password,
                          errorText: _passwordError,
                          onChanged: (_) {
                            if (_passwordError != null) {
                              setState(() => _passwordError = null);
                            }
                          },
                        ),
                        const SizedBox(height: 15.5),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: _forgotPassword,
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
                            loading: _loading,
                            onPressed: _submit),
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
  bool _loading = false;
  final _name = TextEditingController(text: 'Maria Nascimento');
  final _email = TextEditingController(text: 'maria@email.com');
  final _document = TextEditingController();
  final _password = TextEditingController();
  final _errors = <String, String?>{};

  @override
  void dispose() {
    for (final c in [_name, _email, _document, _password]) {
      c.dispose();
    }
    super.dispose();
  }

  void _clear(String field) {
    if (_errors[field] != null) setState(() => _errors[field] = null);
  }

  Future<void> _submit() async {
    final digits = _document.text.replaceAll(RegExp(r'\D'), '');
    setState(() {
      _errors['name'] = _name.text.trim().split(RegExp(r'\s+')).length < 2
          ? 'Informe nome e sobrenome'
          : null;
      _errors['email'] = validateEmail(_email.text);
      _errors['document'] = digits.length == 11 || digits.length == 14
          ? null
          : 'CPF tem 11 dígitos e CNPJ tem 14';
      _errors['password'] =
          _password.text.length < 8 ? 'A senha precisa de 8 caracteres' : null;
    });
    if (_errors.values.any((e) => e != null)) return;
    if (!_accepted) {
      showAppSnack(context, 'Aceite os Termos de uso para continuar');
      return;
    }
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (mounted) _enterApp(context);
  }

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
                    child: AppIcon(Icons.check, size: 15, color: Colors.white),
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
                  AppField(
                      label: 'Nome completo',
                      icon: Icons.person_outline,
                      controller: _name,
                      action: TextInputAction.next,
                      errorText: _errors['name'],
                      onChanged: (_) => _clear('name')),
                  const SizedBox(height: 6),
                  AppField(
                      label: 'E-mail',
                      icon: Icons.mail_outline,
                      keyboard: TextInputType.emailAddress,
                      controller: _email,
                      action: TextInputAction.next,
                      errorText: _errors['email'],
                      onChanged: (_) => _clear('email')),
                  const SizedBox(height: 6),
                  AppField(
                      label: 'CPF ou CNPJ',
                      hint: '000.000.000-00',
                      icon: Icons.assignment_outlined,
                      keyboard: TextInputType.number,
                      controller: _document,
                      action: TextInputAction.next,
                      errorText: _errors['document'],
                      onChanged: (_) => _clear('document')),
                  const SizedBox(height: 6),
                  AppField(
                      label: 'Senha',
                      hint: 'mínimo 8 caracteres',
                      icon: Icons.shield_outlined,
                      password: true,
                      controller: _password,
                      action: TextInputAction.done,
                      errorText: _errors['password'],
                      onChanged: (_) => _clear('password')),
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
                                ? const AppIcon(Icons.check,
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
                    loading: _loading,
                    onPressed: _submit,
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
