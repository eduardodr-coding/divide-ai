import 'package:flutter/material.dart';

import '../data.dart';
import '../theme.dart';
import '../widgets.dart';
import 'auth_screens.dart';
import 'shell.dart';

// --------------------------------------------------------- 09 Relatórios
class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  static const _periods = ['Mês', 'Trimestre', 'Ano', 'Tudo'];
  static const _periodWidths = [49.5, 93.5, 50.0, 57.5];
  static const _months = ['Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago'];
  static const _barHeights = [59.0, 69.0, 54.0, 79.0, 89.0, 105.5];
  static const _barCenters = [57.0, 105.5, 153.5, 202.0, 250.5, 299.0];
  static const _categories = [
    ('Hortifruti', 128.0),
    ('Padaria', 74.0),
    ('Laticínios', 52.0),
    ('Mercearia', 41.0),
    ('Outros', 25.0),
  ];
  int _period = 0;

  Widget _axis(String t, double lineY) => Positioned(
        left: 0,
        width: 24,
        top: lineY - 7,
        child: Text(t,
            textAlign: TextAlign.right,
            style: const TextStyle(
                fontSize: 10.5, height: 1.3, color: AppColors.axis)),
      );

  Widget _grid(double y) => Positioned(
        left: 33,
        right: 17,
        top: y,
        child: Container(height: 1, color: AppColors.grayTint),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navFor(context, 0),
      body: Column(
        children: [
          const AppHeader(
            title: 'Relatórios',
            subtitle: 'Transparência do seu impacto',
            height: 93,
            rowCenter: 53,
            trailing: RoundIconButton(icon: Icons.file_download_outlined),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              children: [
                SizedBox(
                  height: 34,
                  child: Row(
                    children: [
                      for (var i = 0; i < _periods.length; i++) ...[
                        if (i > 0) const SizedBox(width: 9.5),
                        GestureDetector(
                          onTap: () => setState(() => _period = i),
                          child: Container(
                            width: _periodWidths[i],
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _period == i
                                  ? AppColors.primary
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(17),
                              border: Border.all(
                                  color: _period == i
                                      ? AppColors.primary
                                      : AppColors.light),
                            ),
                            child: Text(_periods[i],
                                style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    color: _period == i
                                        ? Colors.white
                                        : AppColors.primary)),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 106,
                  child: AppCard(
                    padding: EdgeInsets.zero,
                    child: Stack(
                      children: [
                        const Positioned(
                          left: 19,
                          top: 11.5,
                          child: Text('320 kg',
                              style: TextStyle(
                                  fontSize: 44,
                                  height: 1.1,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary)),
                        ),
                        const Positioned(
                          right: 19,
                          top: 21.5,
                          child: AppTag('+18% vs. jul',
                              kind: TagKind.orange,
                              height: 23,
                              width: 88,
                              fontSize: 11.5,
                              hPad: 0),
                        ),
                        const Positioned(
                          left: 19,
                          top: 62.4,
                          child: Text('de alimentos resgatados em agosto',
                              style: TextStyle(
                                  fontSize: 12.5,
                                  height: 1.3,
                                  color: AppColors.muted)),
                        ),
                        const Positioned(
                          left: 19,
                          top: 81,
                          child: Text('Equivale a 480 refeições',
                              style: TextStyle(
                                  fontSize: 11.5,
                                  height: 1.3,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.green)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 200,
                  child: AppCard(
                    padding: EdgeInsets.zero,
                    child: Stack(
                      children: [
                        const Positioned(
                          left: 19,
                          top: 16,
                          child: Text('Alimentos resgatados por mês',
                              style: TextStyle(
                                  fontSize: 13,
                                  height: 1.3,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary)),
                        ),
                        const Positioned(
                          left: 19,
                          top: 32.8,
                          child: Text('quilos',
                              style: TextStyle(
                                  fontSize: 11,
                                  height: 1.3,
                                  color: AppColors.muted)),
                        ),
                        const Positioned(
                          left: 279,
                          width: 40,
                          top: 29,
                          child: Text('320',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  height: 1.3,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.ink)),
                        ),
                        _grid(50.5),
                        _grid(103.5),
                        _grid(156.5),
                        _axis('320', 50.5),
                        _axis('160', 103.5),
                        _axis('0', 156.5),
                        for (var i = 0; i < _months.length; i++) ...[
                          Positioned(
                            left: _barCenters[i] - 13,
                            top: 156.5 - _barHeights[i],
                            child: Container(
                              width: 26,
                              height: _barHeights[i],
                              decoration: BoxDecoration(
                                color: i == _months.length - 1
                                    ? AppColors.primary
                                    : AppColors.bar,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(3)),
                              ),
                            ),
                          ),
                          Positioned(
                            left: _barCenters[i] - 20,
                            width: 40,
                            top: 164.7,
                            child: Text(_months[i],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10.5,
                                    height: 1.3,
                                    fontWeight: i == _months.length - 1
                                        ? FontWeight.w800
                                        : FontWeight.w400,
                                    color: i == _months.length - 1
                                        ? AppColors.ink
                                        : AppColors.muted)),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 186,
                  child: AppCard(
                    padding: EdgeInsets.zero,
                    child: Stack(
                      children: [
                        const Positioned(
                          left: 19,
                          top: 16,
                          child: Text('Por categoria de alimento',
                              style: TextStyle(
                                  fontSize: 13,
                                  height: 1.3,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary)),
                        ),
                        const Positioned(
                          left: 19,
                          top: 32.4,
                          child: Text('quilos no mês',
                              style: TextStyle(
                                  fontSize: 11,
                                  height: 1.3,
                                  color: AppColors.muted)),
                        ),
                        for (var i = 0; i < _categories.length; i++) ...[
                          Positioned(
                            left: 19,
                            top: 72 + i * 24 - 7.2,
                            child: Text(_categories[i].$1,
                                style: const TextStyle(
                                    fontSize: 11,
                                    height: 1.3,
                                    color: AppColors.ink)),
                          ),
                          Positioned(
                            left: 107,
                            top: 72 + i * 24 - 6,
                            child: Container(
                              width: 174,
                              height: 12,
                              decoration: BoxDecoration(
                                  color: AppColors.grayTint,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 174 * _categories[i].$2 / 128,
                                  decoration: BoxDecoration(
                                      color: AppColors.bar,
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 19,
                            top: 72 + i * 24 - 7.2,
                            child: Text('${_categories[i].$2.toInt()}',
                                style: const TextStyle(
                                    fontSize: 11,
                                    height: 1.3,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary)),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------- 10 Mensagens
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppHeader(
          title: 'Mensagens',
          showBack: false,
          height: 93,
          rowCenter: 53,
          trailing: RoundIconButton(icon: Icons.edit_outlined),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            children: [
              const SearchBox(hint: 'Buscar conversa', height: 48),
              const SizedBox(height: 20),
              for (final c in conversations)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    height: 86,
                    child: AppCard(
                      padding: EdgeInsets.zero,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 17,
                            top: 18,
                            child: IconCircle(
                              icon: c.isStore
                                  ? Icons.storefront_outlined
                                  : Icons.people_outline,
                              size: 48,
                              iconSize: 24,
                              fg: AppColors.primary,
                              bg: c.isStore
                                  ? const Color(0xFFFFE2C2)
                                  : c.support
                                      ? const Color(0xFFDCE7DA)
                                      : AppColors.light,
                            ),
                          ),
                          Positioned(
                            left: 77,
                            top: 21.5,
                            child: Text(c.name,
                                style: const TextStyle(
                                    fontSize: 13,
                                    height: 1.3,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.ink)),
                          ),
                          Positioned(
                            left: 77,
                            top: 43.2,
                            child: Text(c.last,
                                style: TextStyle(
                                    fontSize: c.unread > 0 ? 11.5 : 12,
                                    height: 1.3,
                                    color: c.unread > 0
                                        ? AppColors.primary
                                        : AppColors.muted,
                                    fontWeight: c.unread > 0
                                        ? FontWeight.w700
                                        : FontWeight.w400)),
                          ),
                          Positioned(
                            right: 17,
                            top: 21.4,
                            child: Text(c.time,
                                style: TextStyle(
                                    fontSize: 11,
                                    height: 1.3,
                                    fontWeight: c.unread > 0
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    color: c.unread > 0
                                        ? AppColors.orange
                                        : AppColors.muted)),
                          ),
                          if (c.unread > 0)
                            Positioned(
                              right: 15,
                              top: 45,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: AppColors.orange,
                                child: Text('${c.unread}',
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800)),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// ----------------------------------------------------------- 11 Perfil
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _items = [
    (Icons.person_outline, 'Dados da conta', 'Nome, e-mail e telefone'),
    (Icons.location_on_outlined, 'Endereços de retirada',
        '2 endereços cadastrados'),
    (Icons.notifications_none, 'Notificações', 'Alertas de doações próximas'),
    (Icons.shield_outlined, 'Privacidade e segurança',
        'Senha e verificação em duas etapas'),
    (Icons.assignment_outlined, 'Meus relatórios', 'Histórico e exportações'),
  ];

  static const _line = Color(0xFF1C8432);

  Widget _stat(double centerX, double o, String v, String l) => Positioned(
        left: centerX - 50,
        width: 100,
        top: 217.1 + o,
        child: Column(
          children: [
            Text(v,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    height: 1.2,
                    fontWeight: FontWeight.w800)),
            const SizedBox(height: 2.4),
            Text(l,
                style: const TextStyle(
                    color: AppColors.light, fontSize: 11, height: 1.3)),
          ],
        ),
      );

  Widget _pill(double left, double w, double o, String t) => Positioned(
        left: left,
        top: 182 + o,
        child: Container(
          width: w,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.green, borderRadius: BorderRadius.circular(11)),
          child: Text(t,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final o = statusInset(context) - 47;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 273.5 + o,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 79.8 + o,
                left: 0,
                right: 0,
                child: const Text('Perfil',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        height: 1.2,
                        fontWeight: FontWeight.w700)),
              ),
              Positioned(
                right: 21,
                top: 71 + o,
                child: const RoundIconButton(icon: Icons.settings_outlined),
              ),
              Positioned(
                left: 32,
                top: 124 + o,
                child: const CircleAvatar(
                  radius: 34,
                  backgroundColor: AppColors.light,
                  child: Icon(Icons.person_outline,
                      size: 36, color: AppColors.green),
                ),
              ),
              Positioned(
                left: 76,
                top: 168 + o,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: const Icon(Icons.camera_alt_outlined,
                      size: 12, color: Colors.white),
                ),
              ),
              Positioned(
                left: 116,
                top: 133.1 + o,
                child: const Text('Maria Nascimento',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        height: 1.2,
                        fontWeight: FontWeight.w800)),
              ),
              Positioned(
                left: 116,
                top: 159.7 + o,
                child: const Text('maria.nascimento@email.com',
                    style: TextStyle(
                        color: AppColors.light, fontSize: 12, height: 1.3)),
              ),
              _pill(116, 78, o, 'Doadora'),
              _pill(200, 92, o, 'Desde 2024'),
              Positioned(
                left: 24,
                right: 24,
                top: 207 + o,
                child: Container(height: 1, color: _line),
              ),
              Positioned(
                left: 140,
                top: 222 + o,
                child: Container(width: 1, height: 34, color: _line),
              ),
              Positioned(
                left: 250,
                top: 222 + o,
                child: Container(width: 1, height: 34, color: _line),
              ),
              _stat(90, o, '12', 'Doações'),
              _stat(195, o, '320 kg', 'Alimentos'),
              _stat(300, o, '4,9', 'Avaliação'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 22.5, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 66,
                child: AppCard(
                  color: AppColors.orangeTint,
                  bordered: false,
                  padding: EdgeInsets.zero,
                  child: const Stack(
                    children: [
                      Positioned(
                        left: 15,
                        top: 12,
                        child: IconCircle(
                            icon: Icons.workspace_premium_outlined,
                            size: 42,
                            iconSize: 22,
                            bg: Colors.white,
                            fg: AppColors.orange),
                      ),
                      Positioned(
                        left: 70,
                        top: 14,
                        child: Text('Doadora Ouro',
                            style: TextStyle(
                                fontSize: 13,
                                height: 1.3,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary)),
                      ),
                      Positioned(
                        left: 70,
                        top: 33.9,
                        child: Text('faltam 3 doações para o nível Diamante',
                            style: TextStyle(
                                fontSize: 11,
                                height: 1.3,
                                color: AppColors.muted)),
                      ),
                      Positioned(
                        right: 8,
                        top: 22,
                        child: Icon(Icons.chevron_right,
                            size: 22, color: AppColors.orange),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Conta',
                  style: TextStyle(
                      fontSize: 15,
                      height: 1.3,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary)),
              const SizedBox(height: 12.5),
              SizedBox(
                height: 270,
                child: AppCard(
                  padding: EdgeInsets.zero,
                  child: Stack(
                    children: [
                      for (var i = 0; i < _items.length; i++) ...[
                        Positioned(
                          left: 11,
                          top: i * 54.0 + 10,
                          child: IconCircle(
                              icon: _items[i].$1, size: 32, iconSize: 17),
                        ),
                        Positioned(
                          left: 53,
                          top: i * 54.0 + 9.5,
                          child: Text(_items[i].$2,
                              style: const TextStyle(
                                  fontSize: 13,
                                  height: 1.3,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.ink)),
                        ),
                        Positioned(
                          left: 53,
                          top: i * 54.0 + 28.3,
                          child: Text(_items[i].$3,
                              style: const TextStyle(
                                  fontSize: 10.5,
                                  height: 1.3,
                                  color: AppColors.muted)),
                        ),
                        Positioned(
                          right: 11,
                          top: i * 54.0 + 15,
                          child: const Icon(Icons.chevron_right,
                              size: 22, color: AppColors.muted),
                        ),
                        if (i < _items.length - 1)
                          Positioned(
                            left: 49,
                            right: 15,
                            top: (i + 1) * 54.0 - 1,
                            child: Container(height: 1, color: AppColors.border),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.5),
              SizedBox(
                width: double.infinity,
                height: 53,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (_) => false),
                  icon: const Icon(Icons.logout, size: 20),
                  label: const Text('Sair da conta',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.red,
                    side: const BorderSide(
                        color: Color(0xFFF0D9CF), width: 1.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
