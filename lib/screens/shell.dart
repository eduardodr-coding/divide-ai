import 'package:flutter/material.dart';

import '../widgets.dart';
import 'donation_screens.dart';
import 'home_screen.dart';
import 'other_screens.dart';

void _openDonate(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const DonateScreen()));

/// Volta para a estrutura principal já na aba escolhida.
void goToTab(BuildContext context, int index) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => AppShell(initialIndex: index)),
    (_) => false,
  );
}

/// Barra inferior para telas empilhadas que também a exibem no Figma.
Widget navFor(BuildContext context, int current) => AppBottomNav(
      current: current,
      onSelect: (i) => goToTab(context, i),
      onAdd: () => _openDonate(context),
    );

/// Estrutura com barra de navegação inferior e botão central "+".
class AppShell extends StatefulWidget {
  final int initialIndex;
  const AppShell({super.key, this.initialIndex = 0});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _index = widget.initialIndex;

  static const _pages = <Widget>[
    HomeScreen(),
    MyDonationsScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: AppBottomNav(
        current: _index,
        onSelect: (i) => setState(() => _index = i),
        onAdd: () => _openDonate(context),
      ),
    );
  }
}
