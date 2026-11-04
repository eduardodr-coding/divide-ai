import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'theme.dart';

/// Altura reservada para a barra de status (frame de 390x844 do Figma).
double statusInset(BuildContext context) =>
    math.max(MediaQuery.of(context).padding.top, 47.0);

/// Ícones do Figma que não existem no Material: desenhados à mão.
const IconData kCubeIcon = Icons.view_in_ar_outlined;
const IconData kTrendIcon = Icons.insights;

Widget appIcon(IconData icon, {required double size, required Color color}) {
  if (icon == kCubeIcon || icon == kTrendIcon) {
    // Align impede que um pai com restrição "tight" estique o desenho.
    return Align(
      widthFactor: 1,
      heightFactor: 1,
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(painter: _GlyphPainter(icon == kCubeIcon, color)),
      ),
    );
  }
  return Icon(icon, size: size, color: color);
}

class _GlyphPainter extends CustomPainter {
  final bool cube;
  final Color color;
  _GlyphPainter(this.cube, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24;
    canvas.scale(s);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = cube ? 2.0 : 1.9
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    if (cube) {
      final hex = Path()
        ..moveTo(12, 2.5)
        ..lineTo(20.5, 7.3)
        ..lineTo(20.5, 16.7)
        ..lineTo(12, 21.5)
        ..lineTo(3.5, 16.7)
        ..lineTo(3.5, 7.3)
        ..close();
      canvas.drawPath(hex, paint);
      canvas.drawPath(
          Path()
            ..moveTo(3.5, 7.3)
            ..lineTo(12, 12)
            ..lineTo(20.5, 7.3)
            ..moveTo(12, 12)
            ..lineTo(12, 21.5),
          paint);
    } else {
      // barras crescentes + seta
      canvas.drawLine(const Offset(3.5, 21), const Offset(20.5, 21), paint);
      for (final b in const [
        [6.0, 15.5],
        [11.0, 12.5],
        [16.0, 15.5],
      ]) {
        canvas.drawLine(Offset(b[0], 21), Offset(b[0], b[1]), paint);
      }
      canvas.drawPath(
          Path()
            ..moveTo(4, 11)
            ..lineTo(10, 6.5)
            ..lineTo(13.5, 9)
            ..lineTo(20, 3.5)
            ..moveTo(15.5, 3.5)
            ..lineTo(20, 3.5)
            ..lineTo(20, 8),
          paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GlyphPainter old) =>
      old.cube != cube || old.color != color;
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
          child: Icon(icon, color: fg, size: iconSize),
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
                iconSize: 26,
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

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.height = 56,
    this.shift = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary,
          disabledForegroundColor: Colors.white,
          padding: EdgeInsets.only(left: shift * 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Row(
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
  });

  @override
  State<AppField> createState() => _AppFieldState();
}

class _AppFieldState extends State<AppField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    final hasIcon = widget.icon != null;
    final textLeft = widget.textLeft ?? (hasIcon ? 46.0 : 18.0);
    Widget? suffix = widget.suffix;
    if (widget.password) {
      suffix = GestureDetector(
        onTap: () => setState(() => _hidden = !_hidden),
        child: Icon(
            _hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            size: 20,
            color: AppColors.muted),
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
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.light),
          ),
          child: Row(
            children: [
              SizedBox(width: widget.iconLeft),
              if (hasIcon) ...[
                appIcon(widget.icon!,
                    size: widget.iconSize, color: AppColors.green),
                SizedBox(
                    width: textLeft - widget.iconLeft - widget.iconSize - 1),
              ] else
                SizedBox(width: textLeft - widget.iconLeft - 1),
              Expanded(
                child: TextFormField(
                  initialValue: widget.initial,
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
      ],
    );
  }
}

/// Campo de busca branco (sem rótulo).
class SearchBox extends StatelessWidget {
  final String hint;
  final double height;
  const SearchBox({super.key, required this.hint, this.height = 50});

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
          const Icon(Icons.search, size: 22, color: AppColors.muted),
          const SizedBox(width: 14),
          Expanded(
            child: TextField(
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
    return Expanded(
      child: InkWell(
        onTap: () => onSelect(i),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(label,
                  style: TextStyle(
                      fontSize: 10.5,
                      height: 1.3,
                      color: color,
                      fontWeight: active ? FontWeight.w800 : FontWeight.w500)),
            ],
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
            top: -12.75,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: onAdd,
                child: Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.cream,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: AppColors.green, shape: BoxShape.circle),
                    child: const Icon(Icons.add, color: Colors.white, size: 30),
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
