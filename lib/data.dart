import 'package:flutter/material.dart';

import 'widgets.dart';

class Donation {
  final String title;
  final String place;
  final String distance;
  final int kg;
  final String expiry;
  final TagKind expiryKind;
  final IconData icon;

  const Donation({
    required this.title,
    required this.place,
    required this.distance,
    required this.kg,
    required this.expiry,
    required this.expiryKind,
    this.icon = Icons.view_in_ar_outlined,
  });
}

const nearbyDonations = <Donation>[
  Donation(
    title: 'Cesta de hortaliças',
    place: 'Hortifruti Bom Preço',
    distance: '1,2 km',
    kg: 8,
    expiry: 'Vence em 2 dias',
    expiryKind: TagKind.orange,
  ),
  Donation(
    title: 'Pães e bolos do dia',
    place: 'Padaria Trigo de Ouro',
    distance: '2,4 km',
    kg: 5,
    expiry: 'Vence hoje',
    expiryKind: TagKind.red,
  ),
  Donation(
    title: 'Frutas variadas',
    place: 'Mercado São Jorge',
    distance: '3,1 km',
    kg: 12,
    expiry: 'Vence em 4 dias',
    expiryKind: TagKind.green,
  ),
  Donation(
    title: 'Iogurtes e queijos',
    place: 'Laticínios Vale Verde',
    distance: '3,8 km',
    kg: 6,
    expiry: 'Vence em 3 dias',
    expiryKind: TagKind.green,
  ),
];

class Conversation {
  final String name;
  final String last;
  final String time;
  final bool isStore;
  final bool support;
  final int unread;

  const Conversation(this.name, this.last, this.time,
      {this.isStore = false, this.support = false, this.unread = 0});
}

const conversations = <Conversation>[
  Conversation('Casa de Apoio Esperança', 'Estamos a caminho, chegamos 15h40',
      '15:12',
      unread: 2),
  Conversation('Hortifruti Bom Preço', 'Cesta separada, pode retirar!', '14:38',
      isStore: true),
  Conversation('Instituto Semear', 'Muito obrigada pela doação de ontem!',
      'Ontem'),
  Conversation('Padaria Trigo de Ouro', 'Vou publicar mais 5 kg amanhã',
      'Ontem',
      isStore: true),
  Conversation('Suporte divide aí', 'Seu relatório de julho está pronto',
      '12/08',
      support: true),
];
