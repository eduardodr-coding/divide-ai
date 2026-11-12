import 'package:flutter/material.dart';

import 'widgets.dart';

class Donation {
  final String title;
  final String place;
  final String distance;
  final double km;
  final int kg;
  final String expiry;
  final int daysLeft;
  final TagKind expiryKind;
  final IconData icon;

  /// Categoria usada pelos chips de "Quero receber".
  final String category;
  final String address;
  final String window;
  final String note;
  final String contents;
  final int donorSince;
  final int donorCount;
  final String rating;

  const Donation({
    required this.title,
    required this.place,
    required this.distance,
    required this.km,
    required this.kg,
    required this.expiry,
    required this.daysLeft,
    required this.expiryKind,
    required this.category,
    required this.address,
    required this.window,
    required this.contents,
    required this.donorSince,
    required this.donorCount,
    required this.rating,
    this.note = 'Leve sacola ou caixa própria',
    this.icon = Icons.view_in_ar_outlined,
  });

  /// "Vence em 2 dias" -> "Vence em 2d" (formato curto da Home).
  String get expiryShort => expiry.replaceAll(RegExp(r' dias?$'), 'd');
}

/// Doações próximas (dados de exemplo). As 4 primeiras são as do Figma;
/// a lista tem 18 itens, como diz a tela "Quero receber".
const nearbyDonations = <Donation>[
  Donation(
    title: 'Cesta de hortaliças',
    place: 'Hortifruti Bom Preço',
    distance: '1,2 km',
    km: 1.2,
    kg: 8,
    expiry: 'Vence em 2 dias',
    daysLeft: 2,
    expiryKind: TagKind.orange,
    category: 'Hortifruti',
    address: 'Rua das Palmeiras, 340 · Centro',
    window: 'Hoje, das 14h às 18h',
    contents: 'Alface, tomate, cenoura, abobrinha e couve.',
    donorSince: 2024,
    donorCount: 38,
    rating: '4,9',
  ),
  Donation(
    title: 'Pães e bolos do dia',
    place: 'Padaria Trigo de Ouro',
    distance: '2,4 km',
    km: 2.4,
    kg: 5,
    expiry: 'Vence hoje',
    daysLeft: 0,
    expiryKind: TagKind.red,
    category: 'Padaria',
    address: 'Av. Brasil, 1.020 · Jardim América',
    window: 'Hoje, das 17h às 19h',
    contents: 'Pão francês, pão de forma, bolo de fubá e roscas.',
    donorSince: 2025,
    donorCount: 21,
    rating: '4,8',
  ),
  Donation(
    title: 'Frutas variadas',
    place: 'Mercado São Jorge',
    distance: '3,1 km',
    km: 3.1,
    kg: 12,
    expiry: 'Vence em 4 dias',
    daysLeft: 4,
    expiryKind: TagKind.green,
    category: 'Hortifruti',
    address: 'Rua São Jorge, 77 · Vila Nova',
    window: 'Amanhã, das 9h às 12h',
    contents: 'Banana, maçã, laranja, mamão e manga.',
    donorSince: 2023,
    donorCount: 54,
    rating: '4,9',
  ),
  Donation(
    title: 'Iogurtes e queijos',
    place: 'Laticínios Vale Verde',
    distance: '3,8 km',
    km: 3.8,
    kg: 6,
    expiry: 'Vence em 3 dias',
    daysLeft: 3,
    expiryKind: TagKind.green,
    category: 'Frios',
    address: 'Rua das Acácias, 512 · Centro',
    window: 'Hoje, das 15h às 18h',
    contents: 'Iogurte natural, queijo minas e requeijão.',
    note: 'Leve bolsa térmica',
    donorSince: 2024,
    donorCount: 17,
    rating: '4,7',
  ),
  Donation(
    title: 'Legumes da estação',
    place: 'Feira do Produtor',
    distance: '4,0 km',
    km: 4.0,
    kg: 15,
    expiry: 'Vence em 3 dias',
    daysLeft: 3,
    expiryKind: TagKind.green,
    category: 'Hortifruti',
    address: 'Praça da Matriz, s/n · Centro',
    window: 'Sábado, das 7h às 11h',
    contents: 'Abóbora, chuchu, beterraba e batata-doce.',
    donorSince: 2025,
    donorCount: 12,
    rating: '4,8',
  ),
  Donation(
    title: 'Salgados assados',
    place: 'Lanchonete Bom Sabor',
    distance: '4,3 km',
    km: 4.3,
    kg: 3,
    expiry: 'Vence hoje',
    daysLeft: 0,
    expiryKind: TagKind.red,
    category: 'Padaria',
    address: 'Rua XV de Novembro, 88 · Centro',
    window: 'Hoje, das 20h às 21h',
    contents: 'Esfirras, enroladinhos e pães de queijo.',
    donorSince: 2025,
    donorCount: 9,
    rating: '4,6',
  ),
  Donation(
    title: 'Frios fatiados',
    place: 'Empório Serra Azul',
    distance: '4,7 km',
    km: 4.7,
    kg: 4,
    expiry: 'Vence em 2 dias',
    daysLeft: 2,
    expiryKind: TagKind.orange,
    category: 'Frios',
    address: 'Av. das Nações, 2.300 · Bela Vista',
    window: 'Amanhã, das 10h às 13h',
    contents: 'Presunto, muçarela e peito de peru fatiados.',
    note: 'Leve bolsa térmica',
    donorSince: 2024,
    donorCount: 26,
    rating: '4,8',
  ),
  Donation(
    title: 'Verduras orgânicas',
    place: 'Sítio Recanto Verde',
    distance: '5,2 km',
    km: 5.2,
    kg: 7,
    expiry: 'Vence em 2 dias',
    daysLeft: 2,
    expiryKind: TagKind.orange,
    category: 'Hortifruti',
    address: 'Estrada Municipal, km 4 · Zona Rural',
    window: 'Amanhã, das 8h às 10h',
    contents: 'Rúcula, agrião, espinafre e couve.',
    donorSince: 2023,
    donorCount: 41,
    rating: '5,0',
  ),
  Donation(
    title: 'Bolos caseiros',
    place: 'Doceria Vó Lurdes',
    distance: '5,6 km',
    km: 5.6,
    kg: 4,
    expiry: 'Vence em 2 dias',
    daysLeft: 2,
    expiryKind: TagKind.orange,
    category: 'Padaria',
    address: 'Rua dos Ipês, 145 · Jardim das Flores',
    window: 'Hoje, das 16h às 18h',
    contents: 'Bolo de cenoura, de laranja e de chocolate.',
    donorSince: 2024,
    donorCount: 19,
    rating: '4,9',
  ),
  Donation(
    title: 'Leite e manteiga',
    place: 'Laticínios Vale Verde',
    distance: '6,0 km',
    km: 6.0,
    kg: 10,
    expiry: 'Vence em 5 dias',
    daysLeft: 5,
    expiryKind: TagKind.green,
    category: 'Frios',
    address: 'Rodovia SP-55, km 12 · Distrito Industrial',
    window: 'Sexta, das 8h às 12h',
    contents: 'Leite integral (caixas) e manteiga.',
    note: 'Leve bolsa térmica',
    donorSince: 2024,
    donorCount: 17,
    rating: '4,7',
  ),
  Donation(
    title: 'Tomates e pimentões',
    place: 'Quitanda do Bairro',
    distance: '6,4 km',
    km: 6.4,
    kg: 9,
    expiry: 'Vence em 3 dias',
    daysLeft: 3,
    expiryKind: TagKind.green,
    category: 'Hortifruti',
    address: 'Rua Goiás, 210 · Vila Operária',
    window: 'Amanhã, das 14h às 18h',
    contents: 'Tomate italiano, pimentão verde e vermelho.',
    donorSince: 2024,
    donorCount: 38,
    rating: '4,9',
  ),
  Donation(
    title: 'Pão de forma',
    place: 'Panificadora Central',
    distance: '6,8 km',
    km: 6.8,
    kg: 6,
    expiry: 'Vence em 2 dias',
    daysLeft: 2,
    expiryKind: TagKind.orange,
    category: 'Padaria',
    address: 'Av. Central, 500 · Centro',
    window: 'Amanhã, das 17h às 19h',
    contents: 'Pão de forma tradicional e integral.',
    donorSince: 2025,
    donorCount: 21,
    rating: '4,8',
  ),
  Donation(
    title: 'Bananas maduras',
    place: 'Atacadão Popular',
    distance: '7,1 km',
    km: 7.1,
    kg: 14,
    expiry: 'Vence hoje',
    daysLeft: 0,
    expiryKind: TagKind.red,
    category: 'Hortifruti',
    address: 'Rod. dos Bandeirantes, km 2 · Distrito',
    window: 'Hoje, das 18h às 20h',
    contents: 'Banana-prata e banana-nanica.',
    donorSince: 2023,
    donorCount: 54,
    rating: '4,9',
  ),
  Donation(
    title: 'Queijo coalho',
    place: 'Empório Serra Azul',
    distance: '4,7 km',
    km: 4.7,
    kg: 3,
    expiry: 'Vence em 4 dias',
    daysLeft: 4,
    expiryKind: TagKind.green,
    category: 'Frios',
    address: 'Av. das Nações, 2.300 · Bela Vista',
    window: 'Sábado, das 10h às 13h',
    contents: 'Queijo coalho em peças de 500 g.',
    note: 'Leve bolsa térmica',
    donorSince: 2024,
    donorCount: 26,
    rating: '4,8',
  ),
  Donation(
    title: 'Cesta de raízes',
    place: 'Feira do Produtor',
    distance: '4,0 km',
    km: 4.0,
    kg: 11,
    expiry: 'Vence em 5 dias',
    daysLeft: 5,
    expiryKind: TagKind.green,
    category: 'Hortifruti',
    address: 'Praça da Matriz, s/n · Centro',
    window: 'Sábado, das 7h às 11h',
    contents: 'Mandioca, inhame, cará e batata.',
    donorSince: 2025,
    donorCount: 12,
    rating: '4,8',
  ),
  Donation(
    title: 'Biscoitos e torradas',
    place: 'Lanchonete Bom Sabor',
    distance: '4,3 km',
    km: 4.3,
    kg: 2,
    expiry: 'Vence em 6 dias',
    daysLeft: 6,
    expiryKind: TagKind.green,
    category: 'Padaria',
    address: 'Rua XV de Novembro, 88 · Centro',
    window: 'Amanhã, das 9h às 11h',
    contents: 'Biscoito de polvilho e torradas.',
    donorSince: 2025,
    donorCount: 9,
    rating: '4,6',
  ),
  Donation(
    title: 'Requeijão e ricota',
    place: 'Queijaria Mineira',
    distance: '7,5 km',
    km: 7.5,
    kg: 4,
    expiry: 'Vence em 2 dias',
    daysLeft: 2,
    expiryKind: TagKind.orange,
    category: 'Frios',
    address: 'Rua Minas Gerais, 33 · Jardim Europa',
    window: 'Amanhã, das 15h às 18h',
    contents: 'Requeijão cremoso e ricota fresca.',
    note: 'Leve bolsa térmica',
    donorSince: 2024,
    donorCount: 17,
    rating: '4,7',
  ),
  Donation(
    title: 'Mix de folhas',
    place: 'Sítio Recanto Verde',
    distance: '5,2 km',
    km: 5.2,
    kg: 5,
    expiry: 'Vence hoje',
    daysLeft: 0,
    expiryKind: TagKind.red,
    category: 'Hortifruti',
    address: 'Estrada Municipal, km 4 · Zona Rural',
    window: 'Hoje, das 16h às 18h',
    contents: 'Alface crespa, americana e roxa.',
    donorSince: 2023,
    donorCount: 41,
    rating: '5,0',
  ),
];

/// Remove acentos e caixa para comparar textos na busca.
String normalize(String s) {
  const from = 'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ';
  const to = 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC';
  final b = StringBuffer();
  for (final r in s.runes) {
    final c = String.fromCharCode(r);
    final i = from.indexOf(c);
    b.write(i >= 0 ? to[i] : c);
  }
  return b.toString().toLowerCase();
}

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
