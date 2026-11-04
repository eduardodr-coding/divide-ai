import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets.dart';
import 'donation_screens.dart';
import 'other_screens.dart';

// ------------------------------------------------------------- 02 Home
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _go(BuildContext context, Widget page) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));

  Widget _impact(IconData icon, Color color, String value, String label) {
    return Expanded(
      child: Column(
        children: [
          IconCircle(icon: icon, fg: color, size: 38, iconSize: 20),
          const SizedBox(height: 4.2),
          Text(value,
              style: const TextStyle(
                  fontSize: 18,
                  height: 1.2,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary)),
          const SizedBox(height: 1.4),
          Text(label,
              style: const TextStyle(
                  fontSize: 10.5, height: 1.3, color: AppColors.muted)),
        ],
      ),
    );
  }

  Widget _action(BuildContext context,
      {required IconData icon,
      required Color color,
      required Color chevron,
      required String title,
      required String sub,
      required Widget page}) {
    return Expanded(
      child: SizedBox(
        height: 112,
        child: AppCard(
          onTap: () => _go(context, page),
          padding: EdgeInsets.zero,
          child: Stack(
            children: [
              Positioned(
                left: 21,
                top: 19,
                child: IconCircle(icon: icon, fg: color, size: 40),
              ),
              Positioned(
                left: 17,
                top: 65,
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        height: 1.3,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary)),
              ),
              Positioned(
                left: 17,
                top: 85.5,
                child: Text(sub,
                    style: const TextStyle(
                        fontSize: 10.5, height: 1.3, color: AppColors.muted)),
              ),
              Positioned(
                left: 131,
                top: 67,
                child: Icon(Icons.chevron_right, color: chevron, size: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final o = statusInset(context) - 47;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 314 + o,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 196 + o,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
                ),
              ),
              Positioned(
                left: 24,
                top: 80.2 + o,
                child: const Text('Olá, Maria!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        height: 1.2,
                        fontWeight: FontWeight.w800)),
              ),
              Positioned(
                left: 24,
                top: 115.2 + o,
                child: const Text('Que bom ter você aqui!',
                    style: TextStyle(
                        color: AppColors.light, fontSize: 12, height: 1.3)),
              ),
              Positioned(
                right: 26,
                top: 81 + o,
                child: const Stack(
                  clipBehavior: Clip.none,
                  children: [
                    RoundIconButton(
                        icon: Icons.notifications_none, size: 42, iconSize: 22),
                    Positioned(
                      right: 7,
                      top: 6,
                      child: CircleAvatar(
                          radius: 3.5, backgroundColor: AppColors.orange),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                top: 168 + o,
                height: 146,
                child: AppCard(
                  padding: const EdgeInsets.fromLTRB(20, 21, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Impacto gerado',
                              style: TextStyle(
                                  fontSize: 13,
                                  height: 1.3,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary)),
                          Text('este mês',
                              style: TextStyle(
                                  fontSize: 11,
                                  height: 1.3,
                                  color: AppColors.muted)),
                        ],
                      ),
                      const SizedBox(height: 10.5),
                      Row(
                        children: [
                          _impact(Icons.card_giftcard_outlined,
                              AppColors.green, '12', 'Doações'),
                          _impact(Icons.view_in_ar_outlined, AppColors.primary,
                              '320 kg', 'Alimentos'),
                          _impact(Icons.people_outline, AppColors.orange, '45',
                              'Pessoas'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 21.75, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('O que você quer fazer?',
                  style: TextStyle(
                      fontSize: 15,
                      height: 1.3,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary)),
              const SizedBox(height: 12.75),
              Row(
                children: [
                  _action(context,
                      icon: Icons.card_giftcard_outlined,
                      color: AppColors.green,
                      chevron: AppColors.green,
                      title: 'Quero doar',
                      sub: 'Tenho alimentos',
                      page: const DonateScreen()),
                  const SizedBox(width: 16),
                  _action(context,
                      icon: Icons.shopping_bag_outlined,
                      color: AppColors.primary,
                      chevron: AppColors.primary,
                      title: 'Quero receber',
                      sub: 'Preciso de alimentos',
                      page: const ReceiveScreen()),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _action(context,
                      icon: Icons.insights,
                      color: AppColors.orange,
                      chevron: AppColors.orange,
                      title: 'Acompanhar',
                      sub: 'Minhas doações',
                      page: const TrackScreen()),
                  const SizedBox(width: 16),
                  _action(context,
                      icon: Icons.assignment_outlined,
                      color: AppColors.primary,
                      chevron: AppColors.primary,
                      title: 'Relatórios',
                      sub: 'Transparência',
                      page: const ReportsScreen()),
                ],
              ),
              const SizedBox(height: 20),
              SectionTitle('Perto de você',
                  action: 'Ver tudo',
                  onAction: () => _go(context, const ReceiveScreen())),
              const SizedBox(height: 12.5),
              SizedBox(
                height: 88,
                child: AppCard(
                  padding: EdgeInsets.zero,
                  onTap: () => _go(context, const DonationDetailScreen()),
                  child: Stack(
                    children: [
                      const Positioned(
                          left: 15, top: 15, child: FoodThumb(size: 56)),
                      const Positioned(
                        left: 85,
                        top: 20.5,
                        child: Text('Cesta de hortaliças',
                            style: TextStyle(
                                fontSize: 13,
                                height: 1.3,
                                fontWeight: FontWeight.w800,
                                color: AppColors.ink)),
                      ),
                      const Positioned(
                        left: 85,
                        top: 40.8,
                        child: Text('Hortifruti Bom Preço · 1,2 km',
                            style: TextStyle(
                                fontSize: 11,
                                height: 1.3,
                                color: AppColors.muted)),
                      ),
                      const Positioned(
                        left: 85,
                        top: 60,
                        child: Row(children: [
                          AppTag('Disponível'),
                          SizedBox(width: 8),
                          AppTag('Vence em 2d', kind: TagKind.orange),
                        ]),
                      ),
                    ],
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
