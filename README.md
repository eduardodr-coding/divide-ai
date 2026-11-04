# divide aí

Protótipo mobile (12 telas) convertido para Flutter.

## Como rodar

```bash
cd divide_ai
flutter create . --platforms=android,ios   # gera as pastas de plataforma (só na 1ª vez)
flutter pub get
flutter run
```

## Estrutura

- `lib/theme.dart` – paleta (#006631, #38A334, #A0D29E, #FF902A, #FFF6EB) e tema
- `lib/widgets.dart` – componentes reutilizáveis (header, card, botões, campo, tag…)
- `lib/data.dart` – dados de exemplo
- `lib/screens/auth_screens.dart` – Login, Criar conta
- `lib/screens/shell.dart` – barra inferior + botão "+"
- `lib/screens/home_screen.dart` – Home
- `lib/screens/donation_screens.dart` – Quero doar, Doação publicada, Quero receber, Detalhe, Acompanhar, Minhas doações
- `lib/screens/other_screens.dart` – Relatórios, Mensagens, Perfil
