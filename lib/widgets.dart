import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'theme.dart';

/// Altura reservada para a barra de status (frame de 390x844 do Figma).
double statusInset(BuildContext context) =>
    math.max(MediaQuery.of(context).padding.top, 47.0);

/// Ícones do Figma que não existem no Material: desenhados à mão.
const IconData kCubeIcon = Icons.view_in_ar_outlined;
const IconData kTrendIcon = Icons.insights;

/// SVG exportado do Figma (assets/icons). [stroke] é a espessura do traço
/// no arquivo: os ícones foram desenhados numa grade de 24 e exportados no
/// tamanho nominal `12 * stroke`, o que permite escalá-los como um [Icon].
class _FigmaIcon {
  final String name;
  final double width, height, stroke;
  const _FigmaIcon(this.name, this.width, this.height, this.stroke);
}

/// Ícones do app que têm o desenho original exportado do Figma.
/// Os demais continuam no Material até serem exportados (ver README).
final Map<IconData, _FigmaIcon> _figmaIcons = {
  Icons.person_outline: const _FigmaIcon('user', 15.1259, 16.1341, 1.55839),
  Icons.visibility_outlined: const _FigmaIcon('eye', 19.159, 12.1921, 1.55839),
  Icons.notifications_none: const _FigmaIcon('bell', 14.3922, 17.3256, 1.55839),
  Icons.card_giftcard_outlined: const _FigmaIcon('gift', 17.1423, 17.0191, 1.55839),
  kCubeIcon: const _FigmaIcon('box', 16.9593, 17.6923, 1.55839),
  Icons.shopping_bag_outlined: const _FigmaIcon('bag-heart', 17.1084, 19.7, 1.7),
  Icons.assignment_outlined: const _FigmaIcon('clipboard', 14.7, 19.9, 1.7),
  Icons.add: const _FigmaIcon('plus', 22.6, 22.6, 2.6),
  Icons.chevron_left: const _FigmaIcon('chevron-left', 7.70028, 13.5672, 1.8334),
  Icons.chevron_right: const _FigmaIcon('chevron-right', 7.8, 13.8, 1.8),
  Icons.people_outline: const _FigmaIcon('users', 18.6094, 15.3091, 1.55839),
  Icons.workspace_premium_outlined: const _FigmaIcon('award', 12.9, 19.3, 1.7),
  kTrendIcon: const _FigmaIcon('trend', 17.7, 14.7, 1.7),
  Icons.home_outlined: const _FigmaIcon('home', 16.9589, 15.8589, 1.55839),
  Icons.favorite_border: const _FigmaIcon('heart', 17.3256, 17.0506, 1.55839),
  Icons.chat_bubble_outline: const _FigmaIcon('message', 16.2256, 15.3089, 1.55839),
};

/// Desenha um ícone do app: o SVG do Figma quando existe, senão o Material.
/// [size] segue a convenção do [Icon] (caixa da grade de 24).
Widget appIcon(IconData icon, {required double size, required Color color}) {
  final svg = _figmaIcons[icon];
  if (svg != null) {
    final k = size / (12 * svg.stroke);
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/${svg.name}.svg',
          width: svg.width * k,
          height: svg.height * k,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    );
  }
  return Icon(icon, size: size, color: color);
}

/// Atalho para usar [appIcon] onde antes havia um [Icon].
class AppIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  const AppIcon(this.icon,
      {super.key, this.size = 24, this.color = AppColors.primary});

  @override
  Widget build(BuildContext context) =>
      appIcon(icon, size: size, color: color);
}

/// Botão circular usado nos cabeçalhos verdes.
class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color bg;
  final Color fg;
  final double size;
  final double iconSize;

  const RoundIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.bg = AppColors.green,
    this.fg = Colors.white,
    this.size = 38,
    this.iconSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bg,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(child: appIcon(icon, color: fg, size: iconSize)),
        ),
      ),
    );
  }
}

/// Cabeçalho verde com cantos inferiores arredondados.
///
/// [height] é medida abaixo da barra de status e [rowCenter] é a posição
/// vertical do botão/título dentro dela.
class AppHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool showBack;
  final double height;
  final double rowCenter;

  const AppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.showBack = true,
    this.height = 85,
    this.rowCenter = 45,
  });

  @override
  Widget build(BuildContext context) {
    final top = statusInset(context);
    final center = top + rowCenter;
    return Container(
      width: double.infinity,
      height: top + height,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
      ),
      child: Stack(
        children: [
          if (showBack)
            Positioned(
              left: 21,
              top: center - 19,
              child: RoundIconButton(
                icon: Icons.chevron_left,
                iconSize: 22, // chevron-left.svg: traço 1.83 -> nominal 22
                onTap: () => Navigator.maybePop(context),
              ),
            ),
          if (trailing != null)
            Positioned(right: 21, top: center - 19, child: trailing!),
          Positioned(
            left: 70,
            right: 70,
            top: center - 10.2,
            child: Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    height: 1.2,
                    fontWeight: FontWeight.w700)),
          ),
          if (subtitle != null)
            Positioned(
              left: 40,
              right: 40,
              top: center + 12.4,
              child: Text(subtitle!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColors.light, fontSize: 11, height: 1.3)),
            ),
        ],
      ),
    );
  }
}

/// Barrinha de "home indicator" desenhada no Figma em todas as telas.
class HomeIndicator extends StatelessWidget {
  const HomeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 5,
      decoration: BoxDecoration(
          color: const Color(0xFFA6C9B7),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}

/// Coloca o home indicator na base da tela (quando o sistema não tem um).
class ScreenFrame extends StatelessWidget {
  final Widget child;
  const ScreenFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final system = MediaQuery.of(context).viewPadding.bottom >= 10;
    return Stack(
      children: [
        Positioned.fill(child: child),
        if (!system)
          const Positioned(
            left: 0,
            right: 0,
            bottom: 9,
            child: IgnorePointer(child: Center(child: HomeIndicator())),
          ),
      ],
    );
  }
}

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color color;
  final double radius;
  final bool bordered;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.color = Colors.white,
    this.radius = 18,
    this.bordered = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: bordered ? Border.all(color: AppColors.border) : null,
          ),
          child: child,
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double height;

  /// Desloca o conteúdo para a direita (o Figma tem um botão descentralizado).
  final double shift;

  /// Mostra um indicador no lugar do texto e ignora toques.
  final bool loading;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.height = 56,
    this.shift = 0,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: FilledButton(
        onPressed: loading ? () {} : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary,
          disabledForegroundColor: Colors.white,
          padding: EdgeInsets.only(left: shift * 2),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.button)),
        ),
        child: loading
            ? const AppLoading(color: Colors.white)
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              appIcon(icon!, size: 20, color: Colors.white),
              const SizedBox(width: 13),
            ],
            Text(label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class OutlineAppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double height;

  const OutlineAppButton(
      {super.key, required this.label, this.onPressed, this.height = 56});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      ),
    );
  }
}

/// Campo de texto com rótulo, ícone e alternância de visibilidade da senha.
class AppField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData? icon;
  final bool password;
  final String? initial;
  final TextInputType? keyboard;
  final Widget? suffix;
  final bool readOnly;
  final VoidCallback? onTap;
  final double height;
  final double iconLeft;
  final double iconSize;
  final double? textLeft;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputAction? action;

  /// Mensagem de erro de validação (mostrada abaixo do campo).
  final String? errorText;

  const AppField({
    super.key,
    required this.label,
    this.hint = '',
    this.icon,
    this.password = false,
    this.initial,
    this.keyboard,
    this.suffix,
    this.readOnly = false,
    this.onTap,
    this.height = 50,
    this.iconLeft = 18,
    this.iconSize = 18,
    this.textLeft,
    this.controller,
    this.onChanged,
    this.action,
    this.errorText,
  }) : assert(initial == null || controller == null,
            'use initial ou controller, não os dois');

  @override
  State<AppField> createState() => _AppFieldState();
}

class _AppFieldState extends State<AppField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    final hasIcon = widget.icon != null;
    final hasError = widget.errorText != null;
    final textLeft = widget.textLeft ?? (hasIcon ? 46.0 : 18.0);
    Widget? suffix = widget.suffix;
    if (widget.password) {
      suffix = Semantics(
        button: true,
        label: _hidden ? 'Mostrar senha' : 'Ocultar senha',
        child: GestureDetector(
          onTap: () => setState(() => _hidden = !_hidden),
          child: appIcon(
              _hidden
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 18.7,
              color: AppColors.muted),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
          child: Text(widget.label,
              style: const TextStyle(
                  fontSize: 12,
                  height: 1.33,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary)),
        ),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.field),
            border: Border.all(
                color: hasError ? AppColors.red : AppColors.light,
                width: hasError ? 1.5 : 1),
          ),
          child: Row(
            children: [
              // O texto começa em [textLeft] (medido no Figma); o ícone fica
              // em [iconLeft]. Sem ícone, o recuo é o próprio textLeft.
              if (hasIcon) ...[
                SizedBox(width: widget.iconLeft),
                appIcon(widget.icon!,
                    size: widget.iconSize, color: AppColors.green),
                SizedBox(
                    width: math.max(
                        0, textLeft - widget.iconLeft - widget.iconSize - 1)),
              ] else
                SizedBox(width: math.max(0, textLeft - 1)),
              Expanded(
                child: TextFormField(
                  initialValue: widget.initial,
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  textInputAction: widget.action,
                  obscureText: widget.password && _hidden,
                  keyboardType: widget.keyboard,
                  readOnly: widget.readOnly,
                  onTap: widget.onTap,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink),
                  decoration: InputDecoration.collapsed(
                    hintText: widget.hint,
                    hintStyle: const TextStyle(
                        fontSize: 14,
                        color: AppColors.muted,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              if (suffix != null) ...[suffix, const SizedBox(width: 18)],
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(widget.errorText!,
                style: AppTypography.caption.copyWith(color: AppColors.red)),
          ),
      ],
    );
  }
}

/// Campo de busca branco (sem rótulo).
class SearchBox extends StatelessWidget {
  final String hint;
  final double height;
  final ValueChanged<String>? onChanged;
  const SearchBox(
      {super.key, required this.hint, this.height = 50, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const AppIcon(Icons.search, size: 22, color: AppColors.muted),
          const SizedBox(width: 14),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              textInputAction: TextInputAction.search,
              style: const TextStyle(fontSize: 14, color: AppColors.ink),
              decoration: InputDecoration.collapsed(
                hintText: hint,
                hintStyle:
                    const TextStyle(fontSize: 14, color: AppColors.muted),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum TagKind { orange, red, green, gray }

class AppTag extends StatelessWidget {
  final String text;
  final TagKind kind;
  final double height;
  final double? width;
  final double fontSize;
  final double hPad;

  const AppTag(
    this.text, {
    super.key,
    this.kind = TagKind.green,
    this.height = 20,
    this.width,
    this.fontSize = 11,
    this.hPad = 13,
  });

  @override
  Widget build(BuildContext context) {
    late Color bg, fg;
    switch (kind) {
      case TagKind.orange:
        bg = AppColors.orangeTint;
        fg = AppColors.orange;
      case TagKind.red:
        bg = AppColors.redTint;
        fg = AppColors.red;
      case TagKind.green:
        bg = AppColors.pale;
        fg = AppColors.primary;
      case TagKind.gray:
        bg = AppColors.grayTint;
        fg = AppColors.muted;
    }
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: width != null ? 0 : hPad),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(text,
          maxLines: 1,
          softWrap: false,
          style: TextStyle(
              color: fg, fontSize: fontSize, fontWeight: FontWeight.w700)),
    );
  }
}

/// Miniatura quadrada verde-clara com ícone.
class FoodThumb extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? bg;
  final Color? fg;
  final double? iconSize;

  const FoodThumb(
      {super.key,
      this.icon = Icons.view_in_ar_outlined,
      this.size = 68,
      this.bg,
      this.fg,
      this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg ?? AppColors.light,
        borderRadius: BorderRadius.circular(size > 60 ? 17 : 14),
      ),
      child: appIcon(icon,
          color: fg ?? AppColors.primary, size: iconSize ?? size * 0.44),
    );
  }
}

/// Círculo colorido com ícone (usado nos cards e listas).
class IconCircle extends StatelessWidget {
  final IconData icon;
  final double size;
  final double iconSize;
  final Color bg;
  final Color fg;

  const IconCircle({
    super.key,
    required this.icon,
    this.size = 40,
    this.iconSize = 20,
    this.bg = AppColors.cream,
    this.fg = AppColors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: appIcon(icon, color: fg, size: iconSize),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  final String? action;
  final VoidCallback? onAction;

  const SectionTitle(this.text, {super.key, this.action, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: const TextStyle(
                fontSize: 15,
                height: 1.3,
                fontWeight: FontWeight.w800,
                color: AppColors.primary)),
        if (action != null)
          GestureDetector(
            onTap: onAction,
            child: Text(action!,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.orange)),
          ),
      ],
    );
  }
}

/// Caixa com borda tracejada (área de fotos).
class DashedBox extends StatelessWidget {
  final Widget child;
  final double height;
  final Color color;
  final double radius;

  const DashedBox({
    super.key,
    required this.child,
    required this.height,
    this.color = AppColors.light,
    this.radius = 18,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedPainter(color, radius),
      child: SizedBox(width: double.infinity, height: height, child: child),
    );
  }
}

class _DashedPainter extends CustomPainter {
  final Color color;
  final double radius;
  _DashedPainter(this.color, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
        (Offset.zero & size).deflate(0.75), Radius.circular(radius));
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(rrect, Paint()..color = Colors.white);
    final path = Path()..addRRect(rrect);
    for (final m in path.computeMetrics()) {
      var d = 0.0;
      while (d < m.length) {
        canvas.drawPath(m.extractPath(d, d + 8), paint);
        d += 14;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedPainter old) =>
      old.color != color || old.radius != radius;
}

/// Barra de navegação inferior com o botão central "+".
class AppBottomNav extends StatelessWidget {
  final int current;
  final ValueChanged<int> onSelect;
  final VoidCallback onAdd;

  const AppBottomNav({
    super.key,
    required this.current,
    required this.onSelect,
    required this.onAdd,
  });

  Widget _item(int i, IconData icon, String label) {
    final active = current == i;
    final color = active ? AppColors.primary : AppColors.muted;
    // Figma (tab-bar): ícone 18.7 com centro a 34 do topo da barra,
    // rótulo Inter 10 (Bold quando ativo, Regular quando inativo) em y=50.
    return Expanded(
      child: Semantics(
        selected: active,
        button: true,
        child: InkWell(
          onTap: () => onSelect(i),
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              children: [
                appIcon(icon, color: color, size: AppDimensions.iconSm),
                const SizedBox(height: 6.5),
                Text(label,
                    style: AppTypography.navLabel.copyWith(
                        color: color,
                        fontWeight:
                            active ? FontWeight.w700 : FontWeight.w400)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final system = MediaQuery.of(context).viewPadding.bottom >= 10;
    return SizedBox(
      height: 88 + (system ? MediaQuery.of(context).viewPadding.bottom - 20 : 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  _item(0, Icons.home_outlined, 'Início'),
                  _item(1, Icons.favorite_border, 'Doações'),
                  const SizedBox(width: 88),
                  _item(2, Icons.chat_bubble_outline, 'Mensagens'),
                  _item(3, Icons.person_outline, 'Perfil'),
                ],
              ),
            ),
          ),
          Positioned(
            // fab-sombra (58, creme) a 11 acima da barra; fab-bg (50, verde).
            top: -11,
            left: 0,
            right: 0,
            child: Center(
              child: Semantics(
                button: true,
                label: 'Nova doação',
                child: GestureDetector(
                onTap: onAdd,
                child: Container(
                  width: 58,
                  height: 58,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.cream,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: AppColors.green, shape: BoxShape.circle),
                    // plus.svg do Figma: traço 2.6 -> tamanho nominal 31.2
                    child: appIcon(Icons.add, color: Colors.white, size: 31.2),
                  ),
                ),
              ),
              ),
            ),
          ),
          if (!system)
            const Positioned(
              bottom: 9,
              left: 0,
              right: 0,
              child: IgnorePointer(child: Center(child: HomeIndicator())),
            ),
        ],
      ),
    );
  }
}

// ------------------------------------------------- estados e sobreposições

/// Chip de filtro (Figma: "Todos", "Hortifruti"... em Quero receber).
class AppChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final double? width;
  final double height;

  const AppChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.width,
    this.height = 34,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: width,
          height: height,
          padding: width == null
              ? const EdgeInsets.symmetric(horizontal: AppSpacing.lg)
              : null,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(height / 2),
            border: Border.all(
                color: selected ? AppColors.primary : AppColors.light),
          ),
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: selected ? Colors.white : AppColors.primary)),
        ),
      ),
    );
  }
}

/// Indicador de carregamento na cor da marca.
class AppLoading extends StatelessWidget {
  final double size;
  final Color color;
  const AppLoading({super.key, this.size = 22, this.color = AppColors.primary});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(strokeWidth: 2.4, color: color),
      );
}

/// Mensagem centralizada para listas vazias ou erros.
class AppStateMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? action;
  final VoidCallback? onAction;
  final bool error;

  const AppStateMessage({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.action,
    this.onAction,
    this.error = false,
  });

  /// Estado vazio (ex.: busca sem resultados).
  const AppStateMessage.empty({
    super.key,
    required this.title,
    required this.message,
    this.action,
    this.onAction,
  })  : icon = kCubeIcon,
        error = false;

  /// Estado de erro (ex.: falha ao carregar).
  const AppStateMessage.error({
    super.key,
    this.title = 'Algo deu errado',
    this.message = 'Verifique sua conexão e tente de novo.',
    this.action = 'Tentar de novo',
    this.onAction,
  })  : icon = Icons.error_outline,
        error = true;

  @override
  Widget build(BuildContext context) {
    final fg = error ? AppColors.red : AppColors.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconCircle(
              icon: icon,
              size: 64,
              iconSize: 30,
              bg: error ? AppColors.redTint : AppColors.pale,
              fg: fg),
          const SizedBox(height: AppSpacing.lg),
          Text(title,
              textAlign: TextAlign.center,
              style: AppTypography.cardTitle.copyWith(color: fg)),
          const SizedBox(height: AppSpacing.xs),
          Text(message,
              textAlign: TextAlign.center,
              style: AppTypography.caption.copyWith(height: 1.4)),
          if (action != null) ...[
            const SizedBox(height: AppSpacing.lg),
            TextButton(
              onPressed: onAction,
              child: Text(action!, style: AppTypography.link),
            ),
          ],
        ],
      ),
    );
  }
}

/// Aviso rápido no rodapé.
void showAppSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(message,
          style: const TextStyle(fontWeight: FontWeight.w600)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.ink,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.field)),
    ));
}

/// Diálogo de confirmação no estilo do app. Retorna true se confirmado.
Future<bool> showAppDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirm = 'Confirmar',
  String cancel = 'Cancelar',
}) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.cardLarge)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.section),
            const SizedBox(height: AppSpacing.sm),
            Text(message,
                style: AppTypography.caption
                    .copyWith(fontSize: 13, height: 1.4)),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
                label: confirm,
                height: 48,
                onPressed: () => Navigator.pop(context, true)),
            const SizedBox(height: AppSpacing.sm),
            OutlineAppButton(
                label: cancel,
                height: 48,
                onPressed: () => Navigator.pop(context, false)),
          ],
        ),
      ),
    ),
  );
  return ok ?? false;
}

/// Folha inferior com alça e título, no estilo dos cards do app.
Future<T?> showAppSheet<T>(
  BuildContext context, {
  required String title,
  required WidgetBuilder builder,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.cream,
    shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.sheet))),
    builder: (context) => Padding(
      padding: EdgeInsets.fromLTRB(AppSpacing.screen, 12, AppSpacing.screen,
          24 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: AppColors.light,
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(title, style: AppTypography.section),
          const SizedBox(height: AppSpacing.md),
          builder(context),
        ],
      ),
    ),
  );
}

/// Opção selecionável dentro de uma folha inferior.
class AppSheetOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const AppSheetOption(
      {super.key,
      required this.label,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AppCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
                child: Text(label,
                    style: AppTypography.cardTitle.copyWith(
                        color: selected ? AppColors.primary : AppColors.ink))),
            if (selected)
              const AppIcon(Icons.check_circle,
                  size: 20, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
