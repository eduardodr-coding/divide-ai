# divide aí

App de doação e recebimento de alimentos. As 12 telas seguem o protótipo do
Figma (iPhone 390 × 844).

## Como rodar

```bash
flutter pub get
flutter run -d chrome      # ou -d windows / um emulador Android
```

No navegador ou desktop, o app aparece num frame de 390 × 844 centralizado.

## Testes

```bash
flutter test                                   # fluxos + renderização
flutter test test/render_screens_test.dart     # gera build/screens/*.png
```

`render_screens_test.dart` salva cada tela em `build/screens/` com o mesmo
nome dos PNGs de `design/`, o que permite comparar app e Figma lado a lado.

## Estrutura

- `lib/theme.dart`: design system. Contém `AppColors`, `AppTypography`, `AppSpacing`,
  `AppRadius`, `AppShadows`, `AppDimensions` e o tema.
- `lib/widgets.dart`: componentes. Inclui cabeçalho, card, botões (com estado de
  carregamento), campo (com erro), busca, chip, tag, barra inferior, diálogo
  (`showAppDialog`), folha inferior (`showAppSheet`), aviso (`showAppSnack`),
  carregando (`AppLoading`) e vazio/erro (`AppStateMessage`).
- `lib/data.dart`: dados de exemplo (18 doações, conversas).
- `lib/screens/`: Login, Criar conta, Home, Quero doar, Doação publicada,
  Quero receber, Detalhe, Acompanhar, Minhas doações, Relatórios, Mensagens,
  Perfil.
- `assets/icons/`: ícones SVG exportados do Figma.
- `design/`: PNG de cada tela do Figma (referência visual).

## Ícones

`appIcon()` / `AppIcon` desenham o SVG original do Figma quando ele existe em
`assets/icons/` e caem no ícone Material equivalente quando não existe. Para
trocar mais um ícone:

1. Exporte o SVG da camada no Figma (ex.: `ic-busca`).
2. Salve em `assets/icons/<nome>.svg`.
3. Adicione a linha em `_figmaIcons` (`lib/widgets.dart`), com a largura, a
   altura e a espessura do traço do arquivo.

Ainda em Material: envelope, escudo, câmera, calendário, loja, relógio, lápis,
check, folha, lupa, filtro, estrela, pin, caminhão, download, engrenagem, sair.

## Marca

Os originais ficam em `logos-divide-ai/`. A partir deles:

- `assets/brand/logo-completa.png` é a logo com slogan exibida no Login, no
  espaço `logo-divide-ai` do Figma (326 × 137).
- O ícone do app (Android `mipmap-*`, web `icons/` e `favicon.png`, e
  Windows `app_icon.ico`) vem de `icone-fundo-escuro.png`.
