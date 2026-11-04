import 'package:flutter/material.dart';

import '../data.dart';
import '../theme.dart';
import '../widgets.dart';
import 'other_screens.dart';
import 'shell.dart';

void _push(BuildContext context, Widget page) =>
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));

/// Card de doação usado em "Quero receber" e "Minhas doações".
class _DonationTile extends StatelessWidget {
  final IconData icon;
  final bool done;
  final String title, sub;
  final Widget tag;
  final List<Widget> extras;
  final VoidCallback? onTap;

  const _DonationTile({
    required this.icon,
    this.done = false,
    required this.title,
    required this.sub,
    required this.tag,
    required this.extras,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: AppCard(
        padding: EdgeInsets.zero,
        onTap: onTap,
        child: Stack(
          children: [
            Positioned(
              left: 15,
              top: 15,
              child: FoodThumb(
                icon: icon,
                size: 68,
                bg: done ? AppColors.grayTint : null,
                fg: done ? AppColors.muted : null,
                iconSize: done ? 34 : 30,
              ),
            ),
            Positioned(
              left: 97,
              top: 21.5,
              child: Text(title,
                  style: TextStyle(
                      fontSize: 13,
                      height: 1.3,
                      fontWeight: FontWeight.w800,
                      color: done ? AppColors.muted : AppColors.ink)),
            ),
            Positioned(
              left: 97,
              top: 41.9,
              child: Text(sub,
                  style: const TextStyle(
                      fontSize: 11, height: 1.3, color: AppColors.muted)),
            ),
            Positioned(left: 97, top: 63, child: tag),
            ...extras,
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------ 04 Quero doar
class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  bool _confirmed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenFrame(
        child: Column(
          children: [
            const AppHeader(
                title: 'Quero doar',
                subtitle: 'Passo 1 de 2 · Sobre o alimento'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 17, 24, 40),
                children: [
                  DashedBox(
                    height: 120,
                    child: const Stack(
                      children: [
                        Positioned(
                          top: 23,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: IconCircle(
                                icon: Icons.camera_alt_outlined,
                                size: 48,
                                iconSize: 24),
                          ),
                        ),
                        Positioned(
                          top: 75.5,
                          left: 0,
                          right: 0,
                          child: Text('Adicionar fotos do alimento',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13,
                                  height: 1.4,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary)),
                        ),
                        Positioned(
                          top: 95,
                          left: 0,
                          right: 0,
                          child: Text('até 3 fotos · ajuda quem vai receber',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11,
                                  height: 1.3,
                                  color: AppColors.muted)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 11),
                  const AppField(
                      label: 'O que você vai doar?',
                      initial: 'Cesta de hortaliças',
                      icon: Icons.view_in_ar_outlined),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Expanded(
                        child: AppField(
                            label: 'Quantidade',
                            initial: '8 kg',
                            keyboard: TextInputType.number),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: AppField(
                            label: 'Validade',
                            initial: '20/08/2026',
                            textLeft: 19,
                            suffix: Icon(Icons.calendar_today_outlined,
                                size: 18, color: AppColors.muted)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const AppField(
                      label: 'Local de retirada',
                      initial: 'Hortifruti Bom Preço · Centro',
                      icon: Icons.storefront_outlined),
                  const SizedBox(height: 6),
                  const AppField(
                      label: 'Janela para retirada',
                      initial: 'Hoje, 14h às 18h',
                      icon: Icons.schedule),
                  const SizedBox(height: 6),
                  const AppField(
                      label: 'Observações (opcional)',
                      hint: 'Retirar na entrada de serviço',
                      icon: Icons.edit_outlined),
                  const SizedBox(height: 26.5),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _confirmed = !_confirmed),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: _confirmed
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: _confirmed
                                    ? AppColors.primary
                                    : AppColors.green,
                                width: 2),
                          ),
                          child: _confirmed
                              ? const Icon(Icons.check,
                                  size: 14, color: Colors.white)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                            'Confirmo que o alimento está próprio para consumo.',
                            style: TextStyle(
                                fontSize: 11.5, color: AppColors.muted)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 19.5),
                  PrimaryButton(
                    label: 'Publicar doação',
                    icon: Icons.check_circle_outline,
                    onPressed: _confirmed
                        ? () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PublishedScreen()))
                        : null,
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

// ------------------------------------------------ 05 Doação publicada
class _PublishedArtPainter extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final dx = (s.width - 390) / 2;
    c.translate(dx, 0);
    Paint p(Color color) => Paint()..color = color;
    const center = Offset(195, 96);
    c.drawCircle(center, 96, p(const Color(0xFFDBE8CE)));
    c.drawCircle(center, 70, p(const Color(0xFFBBDCB4)));
    c.drawCircle(center, 52, p(AppColors.primary));
    c.drawCircle(const Offset(106, 54), 6, p(AppColors.green));
    c.drawCircle(const Offset(292, 34), 9, p(AppColors.orange));
    c.drawCircle(const Offset(118, 158), 7.5, p(const Color(0xFFFFBE81)));
    c.drawCircle(const Offset(284, 156), 5, p(const Color(0xFF99BCA1)));
    final check = Path()
      ..moveTo(170, 97)
      ..lineTo(188, 114)
      ..lineTo(216, 80);
    c.drawPath(
      check,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class PublishedScreen extends StatelessWidget {
  const PublishedScreen({super.key});

  Widget _kv(double center, String k, String v) => Positioned(
        top: center - 8,
        left: 19,
        right: 19,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(k,
                style: const TextStyle(
                    fontSize: 12, height: 1.33, color: AppColors.muted)),
            Text(v,
                style: const TextStyle(
                    fontSize: 12,
                    height: 1.33,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenFrame(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 142, 24, 40),
          children: [
            SizedBox(
              height: 192,
              child: CustomPaint(painter: _PublishedArtPainter()),
            ),
            const SizedBox(height: 20.4),
            const Text('Doação publicada!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26,
                    height: 1.2,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary)),
            const SizedBox(height: 7.4),
            const Text(
                'Já está visível para as instituições\ne pessoas cadastradas perto de você.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13, height: 1.54, color: AppColors.muted)),
            const SizedBox(height: 27),
            SizedBox(
              height: 156,
              child: AppCard(
                padding: EdgeInsets.zero,
                child: Stack(
                  children: [
                    const Positioned(
                      left: 19,
                      top: 18,
                      child: Text('Resumo da doação',
                          style: TextStyle(
                              fontSize: 12,
                              height: 1.33,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary)),
                    ),
                    const Positioned(
                      right: 19,
                      top: 15,
                      child: AppTag('#DA-4822', height: 22, width: 70),
                    ),
                    const Positioned(
                      left: 19,
                      right: 19,
                      top: 45,
                      child: Divider(height: 1, color: AppColors.border),
                    ),
                    _kv(64.5, 'Alimento', 'Cesta de hortaliças · 8 kg'),
                    _kv(92.5, 'Retirada', 'Hoje, 14h às 18h'),
                    _kv(120.5, 'Validade', '20/08/2026'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 62,
              decoration: BoxDecoration(
                  color: AppColors.pale,
                  borderRadius: BorderRadius.circular(18)),
              child: const Stack(
                children: [
                  Positioned(
                    left: 16,
                    top: 11,
                    child: IconCircle(
                        icon: Icons.eco_outlined,
                        size: 40,
                        iconSize: 20,
                        bg: Colors.white),
                  ),
                  Positioned(
                    left: 68,
                    top: 13.5,
                    child: Text('Você evitou 8 kg de desperdício',
                        style: TextStyle(
                            fontSize: 13,
                            height: 1.3,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary)),
                  ),
                  Positioned(
                    left: 68,
                    top: 33.8,
                    child: Text('equivale a 12 refeições completas',
                        style: TextStyle(
                            fontSize: 11.5,
                            height: 1.3,
                            color: AppColors.muted)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Acompanhar doação',
              icon: Icons.insights,
              onPressed: () => _push(context, const TrackScreen()),
            ),
            const SizedBox(height: 8),
            OutlineAppButton(
              height: 48,
              label: 'Voltar ao início',
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const AppShell()),
                  (_) => false),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------- 06 Quero receber
class ReceiveScreen extends StatefulWidget {
  const ReceiveScreen({super.key});

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  static const _filters = ['Todos', 'Hortifruti', 'Padaria', 'Frios'];
  static const _widths = [64.0, 100.5, 79.5, 64.5];
  int _filter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navFor(context, 0),
      body: Column(
        children: [
          const AppHeader(title: 'Quero receber', height: 93, rowCenter: 53),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              children: [
                Row(
                  children: [
                    const Expanded(
                        child: SearchBox(hint: 'Buscar alimento ou doador')),
                    const SizedBox(width: 10),
                    Container(
                      width: 46,
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(14)),
                      child: const Icon(Icons.filter_list,
                          color: Colors.white, size: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 34,
                  child: Row(
                    children: [
                      for (var i = 0; i < _filters.length; i++) ...[
                        if (i > 0) const SizedBox(width: 9.5),
                        GestureDetector(
                          onTap: () => setState(() => _filter = i),
                          child: Container(
                            width: _widths[i],
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: i == _filter
                                  ? AppColors.primary
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(17),
                              border: Border.all(
                                  color: i == _filter
                                      ? AppColors.primary
                                      : AppColors.light),
                            ),
                            child: Text(_filters[i],
                                style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    color: i == _filter
                                        ? Colors.white
                                        : AppColors.primary)),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 23.5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('18 doações · mais próximas primeiro',
                        style: TextStyle(
                            fontSize: 12, height: 1.33, color: AppColors.muted)),
                    Row(children: [
                      Text('Ordenar',
                          style: TextStyle(
                              fontSize: 12,
                              height: 1.33,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary)),
                      SizedBox(width: 3),
                      Icon(Icons.keyboard_arrow_down,
                          size: 18, color: AppColors.primary),
                    ]),
                  ],
                ),
                const SizedBox(height: 12.5),
                for (final d in nearbyDonations)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _DonationTile(
                      icon: d.icon,
                      title: d.title,
                      sub: '${d.place} · ${d.distance}',
                      tag: AppTag(d.expiry, kind: d.expiryKind),
                      onTap: () => _push(context, const DonationDetailScreen()),
                      extras: [
                        Positioned(
                          right: 17,
                          top: 22,
                          child: Text('${d.kg} kg',
                              style: const TextStyle(
                                  fontSize: 12.5,
                                  height: 1.3,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary)),
                        ),
                        const Positioned(
                          right: 10,
                          top: 63,
                          child: Icon(Icons.chevron_right,
                              size: 24, color: AppColors.green),
                        ),
                      ],
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

// ---------------------------------------------- 07 Detalhe da doação
class DonationDetailScreen extends StatelessWidget {
  const DonationDetailScreen({super.key});

  Widget _row(double iconTop, double titleTop, double subTop, IconData icon,
      Color color, String title, String sub) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
            left: 20, top: iconTop, child: Icon(icon, color: color, size: 22)),
        Positioned(
          left: 53,
          top: titleTop,
          child: Text(title,
              style: const TextStyle(
                  fontSize: 12.5,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink)),
        ),
        Positioned(
          left: 53,
          top: subTop,
          child: Text(sub,
              style: const TextStyle(
                  fontSize: 11, height: 1.3, color: AppColors.muted)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final o = statusInset(context) - 47;
    return Scaffold(
      body: ScreenFrame(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 268 + o,
              decoration: const BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: (MediaQuery.of(context).size.width - 144) / 2,
                    top: 78 + o,
                    child: Container(
                      width: 144,
                      height: 144,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFC6E4C5)),
                      child: Center(
                        child: appIcon(Icons.view_in_ar_outlined,
                            size: 64, color: AppColors.primary),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 21,
                    top: 77 + o,
                    child: RoundIconButton(
                      icon: Icons.chevron_left,
                      iconSize: 26,
                      bg: Colors.white,
                      fg: AppColors.primary,
                      onTap: () => Navigator.maybePop(context),
                    ),
                  ),
                  Positioned(
                    right: 21,
                    top: 77 + o,
                    child: const RoundIconButton(
                      icon: Icons.favorite_border,
                      bg: Colors.white,
                      fg: AppColors.primary,
                    ),
                  ),
                  Positioned(
                    bottom: 23,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 18,
                            height: 5,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(3))),
                        const SizedBox(width: 6.5),
                        for (final i in [0, 1]) ...[
                          Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                  color: Color(0xFF60A772),
                                  shape: BoxShape.circle)),
                          if (i == 0) const SizedBox(width: 4),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 15.9, 24, 34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Cesta de hortaliças',
                      style: TextStyle(
                          fontSize: 21,
                          height: 1.2,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary)),
                  const SizedBox(height: 8.9),
                  const Row(children: [
                    AppTag('Vence em 2 dias',
                        kind: TagKind.orange,
                        height: 24,
                        width: 96,
                        fontSize: 12,
                        hPad: 4),
                    SizedBox(width: 8),
                    AppTag('8 kg', height: 24, width: 62, fontSize: 12),
                    SizedBox(width: 8),
                    AppTag('Hortifruti', height: 24, width: 78, fontSize: 12),
                  ]),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 88,
                    child: AppCard(
                      padding: EdgeInsets.zero,
                      child: Stack(
                        children: [
                          const Positioned(
                            left: 17,
                            top: 19,
                            child: IconCircle(
                                icon: Icons.storefront_outlined,
                                size: 48,
                                iconSize: 24,
                                bg: AppColors.light,
                                fg: AppColors.primary),
                          ),
                          const Positioned(
                            left: 77,
                            top: 23,
                            child: Text('Hortifruti Bom Preço',
                                style: TextStyle(
                                    fontSize: 14.5,
                                    height: 1.3,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.ink)),
                          ),
                          const Positioned(
                            left: 77,
                            top: 45,
                            child: Text('Doador desde 2024 · 38 doações',
                                style: TextStyle(
                                    fontSize: 11,
                                    height: 1.3,
                                    color: AppColors.muted)),
                          ),
                          const Positioned(
                            left: 77,
                            top: 61,
                            child: Row(children: [
                              Icon(Icons.star,
                                  size: 14, color: AppColors.orange),
                              SizedBox(width: 4),
                              Text('4,9',
                                  style: TextStyle(
                                      fontSize: 12,
                                      height: 1.3,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.ink)),
                            ]),
                          ),
                          const Positioned(
                            right: 15,
                            top: 25,
                            child: IconCircle(
                                icon: Icons.chat_bubble_outline,
                                size: 36,
                                iconSize: 18,
                                bg: AppColors.pale,
                                fg: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.25),
                  const SectionTitle('Detalhes da retirada'),
                  const SizedBox(height: 13.25),
                  SizedBox(
                    height: 138,
                    child: AppCard(
                      padding: EdgeInsets.zero,
                      child: Stack(
                        children: [
                          _row(13, 15.9, 34.9, Icons.location_on_outlined,
                              AppColors.green, 'Rua das Palmeiras, 340 · Centro',
                              '1,2 km de você'),
                          const Positioned(
                            left: 19,
                            right: 19,
                            top: 63,
                            child: Divider(height: 1, color: AppColors.border),
                          ),
                          _row(73, 75.9, 94.9, Icons.schedule, AppColors.green,
                              'Hoje, das 14h às 18h',
                              'Leve sacola ou caixa própria'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SectionTitle('O que vem na cesta'),
                  const SizedBox(height: 12.5),
                  const SizedBox(
                    height: 54,
                    child: AppCard(
                      padding: EdgeInsets.symmetric(horizontal: 19),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Alface, tomate, cenoura, abobrinha e couve.',
                            style: TextStyle(
                                fontSize: 12.5, color: AppColors.muted)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  PrimaryButton(
                    label: 'Solicitar esta doação',
                    icon: Icons.check_circle_outline,
                    height: 54,
                    onPressed: () => _push(context, const TrackScreen()),
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

// ------------------------------------------- 03 Acompanhar doação
class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key});

  // (ícone, título, subtítulo, hora, estado: 2 = feito, 1 = atual, 0 = pendente)
  static const _steps = [
    (Icons.check_circle_outline, 'Doação registrada',
        'Hortifruti Bom Preço · 8 kg', '14:02', 2),
    (Icons.people_outline, 'Conexão confirmada',
        'Casa de Apoio Esperança aceitou', '14:35', 2),
    (Icons.local_shipping_outlined, 'Em entrega',
        'Retirada a caminho do destino', '15:10', 1),
    (Icons.check_circle_outline, 'Confirmação', 'Aguardando recebimento',
        '--:--', 0),
  ];

  Widget _step(int i) {
    final s = _steps[i];
    final state = s.$5;
    final y = i * 74.0;
    final Color titleColor = state == 1
        ? AppColors.orange
        : state == 2
            ? AppColors.primary
            : AppColors.muted;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (i < _steps.length - 1)
          Positioned(
            left: 33.5,
            top: 41 + y + 16,
            child: Container(
              width: 3,
              height: 42,
              color: state == 0 || i == 2 ? AppColors.border : AppColors.green,
            ),
          ),
        if (state == 1)
          Positioned(
            left: 35 - 22.0,
            top: 41 + y - 22,
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFFFEBD9)),
            ),
          ),
        Positioned(
          left: 19,
          top: 41 + y - 16,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: state == 0
                  ? Colors.white
                  : state == 1
                      ? AppColors.orange
                      : AppColors.primary,
              border:
                  state == 0 ? Border.all(color: AppColors.border, width: 2) : null,
            ),
            child: Icon(s.$1,
                size: 17, color: state == 0 ? AppColors.hint : Colors.white),
          ),
        ),
        Positioned(
          left: 67,
          top: 24.9 + y,
          child: Text(s.$2,
              style: TextStyle(
                  fontSize: state == 0 ? 15 : 14,
                  height: 1.3,
                  fontWeight: state == 0 ? FontWeight.w400 : FontWeight.w800,
                  color: titleColor)),
        ),
        Positioned(
          left: 67,
          top: 45.8 + y,
          child: Text(s.$3,
              style: const TextStyle(
                  fontSize: 11, height: 1.3, color: AppColors.muted)),
        ),
        Positioned(
          right: 19,
          top: 27 + y,
          child: Text(s.$4,
              style: TextStyle(
                  fontSize: 12,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                  color: state == 1 ? AppColors.orange : AppColors.muted)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final o = statusInset(context) - 47;
    return Scaffold(
      bottomNavigationBar: navFor(context, 1),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 232 + o,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const AppHeader(
                  title: 'Acompanhar doação',
                  height: 101,
                  rowCenter: 53,
                  trailing: RoundIconButton(icon: Icons.chat_bubble_outline),
                ),
                Positioned(
                  left: 24,
                  right: 24,
                  top: 124 + o,
                  height: 108,
                  child: AppCard(
                    padding: EdgeInsets.zero,
                    child: const Stack(
                      children: [
                        Positioned(
                            left: 17, top: 17, child: FoodThumb(size: 72)),
                        Positioned(
                          left: 105,
                          top: 24.1,
                          child: Text('Cesta de hortaliças',
                              style: TextStyle(
                                  fontSize: 16,
                                  height: 1.3,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.ink)),
                        ),
                        Positioned(
                          left: 105,
                          top: 48.7,
                          child: Text('8 kg · Validade 20/08/2026',
                              style: TextStyle(
                                  fontSize: 12,
                                  height: 1.3,
                                  color: AppColors.muted)),
                        ),
                        Positioned(
                          left: 105,
                          top: 71,
                          child: Row(children: [
                            AppTag('Em entrega',
                                kind: TagKind.orange, height: 22, width: 92),
                            SizedBox(width: 6),
                            AppTag('#DA-4821', height: 22, width: 74),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status da entrega',
                        style: TextStyle(
                            fontSize: 15,
                            height: 1.3,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary)),
                    Text('Etapa 3 de 4',
                        style: TextStyle(
                            fontSize: 12, height: 1.3, color: AppColors.muted)),
                  ],
                ),
                const SizedBox(height: 14.25),
                SizedBox(
                  height: 300,
                  child: AppCard(
                    padding: EdgeInsets.zero,
                    child: Stack(
                      children: [for (var i = 0; i < _steps.length; i++) _step(i)],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 88,
                  child: AppCard(
                    padding: EdgeInsets.zero,
                    child: const Stack(
                      children: [
                        Positioned(
                          left: 19,
                          top: 21,
                          child: IconCircle(
                              icon: Icons.location_on_outlined,
                              size: 44,
                              iconSize: 22,
                              fg: AppColors.orange),
                        ),
                        Positioned(
                          left: 77,
                          top: 14.9,
                          child: Text('Casa de Apoio Esperança',
                              style: TextStyle(
                                  fontSize: 14,
                                  height: 1.3,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.ink)),
                        ),
                        Positioned(
                          left: 77,
                          top: 36.9,
                          child: Text('Rua das Acácias, 128 · 1,2 km',
                              style: TextStyle(
                                  fontSize: 11,
                                  height: 1.3,
                                  color: AppColors.muted)),
                        ),
                        Positioned(
                          left: 77,
                          top: 54.9,
                          child: Text('Chegada prevista às 15:40',
                              style: TextStyle(
                                  fontSize: 11,
                                  height: 1.3,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.green)),
                        ),
                        Positioned(
                          right: 11,
                          top: 32,
                          child: Icon(Icons.chevron_right,
                              size: 22, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  label: 'Confirmar recebimento',
                  icon: Icons.check_circle_outline,
                  shift: 36,
                  onPressed: () => Navigator.maybePop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------ 08 Minhas doações
class MyDonationsScreen extends StatefulWidget {
  const MyDonationsScreen({super.key});

  @override
  State<MyDonationsScreen> createState() => _MyDonationsScreenState();
}

class _MyDonationsScreenState extends State<MyDonationsScreen> {
  bool _ongoing = true;

  static const _ongoingItems = [
    ('Cesta de hortaliças', 'Casa de Apoio Esperança', '8 kg', 'hoje',
        'Em entrega', TagKind.orange, Icons.local_shipping_outlined),
    ('Pães e bolos do dia', 'Aguardando um receptor', '5 kg', 'hoje',
        'Publicada', TagKind.green, Icons.view_in_ar_outlined),
  ];
  static const _doneItems = [
    ('Frutas variadas', 'Instituto Semear', '12 kg', '12/08', 'Concluída',
        TagKind.gray, Icons.check_circle_outline),
    ('Arroz e feijão', 'Casa de Apoio Esperança', '20 kg', '05/08',
        'Concluída', TagKind.gray, Icons.check_circle_outline),
  ];

  Widget _tab(String label, bool value) {
    final sel = _ongoing == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _ongoing = value),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: sel ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(11)),
          child: Text(label,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: sel ? FontWeight.w800 : FontWeight.w400,
                  color: sel ? Colors.white : AppColors.muted)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // No Figma a aba "Em andamento" mostra também as concluídas, em cinza.
    final items = _ongoing ? [..._ongoingItems, ..._doneItems] : _doneItems;
    return Column(
      children: [
        const AppHeader(
          title: 'Minhas doações',
          height: 103,
          rowCenter: 63,
          trailing: RoundIconButton(icon: Icons.filter_list),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            children: [
              Container(
                height: 46,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14)),
                child: Row(children: [
                  _tab('Em andamento', true),
                  _tab('Concluídas', false),
                ]),
              ),
              const SizedBox(height: 16),
              Container(
                height: 60,
                decoration: BoxDecoration(
                    color: AppColors.pale,
                    borderRadius: BorderRadius.circular(16)),
                child: Stack(
                  children: [
                    const Positioned(
                      left: 22,
                      top: 20,
                      child: Icon(Icons.eco_outlined,
                          size: 20, color: AppColors.green),
                    ),
                    const Positioned(
                      left: 56,
                      top: 12.5,
                      child: Text('45 kg doados em agosto',
                          style: TextStyle(
                              fontSize: 13,
                              height: 1.3,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary)),
                    ),
                    const Positioned(
                      left: 56,
                      top: 33,
                      child: Text('seu melhor mês até aqui',
                          style: TextStyle(
                              fontSize: 11.5,
                              height: 1.3,
                              color: AppColors.muted)),
                    ),
                    Positioned(
                      right: 20,
                      top: 23.5,
                      child: GestureDetector(
                        onTap: () => _push(context, const ReportsScreen()),
                        child: const Text('Ver relatório',
                            style: TextStyle(
                                fontSize: 12,
                                height: 1.3,
                                fontWeight: FontWeight.w700,
                                color: AppColors.orange)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (final it in items)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _DonationTile(
                    icon: it.$7,
                    done: it.$6 == TagKind.gray,
                    title: it.$1,
                    sub: it.$2,
                    tag: AppTag(it.$5, kind: it.$6),
                    onTap: () => _push(context, const TrackScreen()),
                    extras: [
                      Positioned(
                        right: 17,
                        top: 22,
                        child: Text(it.$3,
                            style: TextStyle(
                                fontSize: 12.5,
                                height: 1.3,
                                fontWeight: FontWeight.w800,
                                color: it.$6 == TagKind.gray
                                    ? AppColors.muted
                                    : AppColors.primary)),
                      ),
                      Positioned(
                        right: 17,
                        top: 40,
                        child: Text(it.$4,
                            style: const TextStyle(
                                fontSize: 11,
                                height: 1.3,
                                color: AppColors.muted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
