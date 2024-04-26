import 'package:code_editor/theme/luna_theme.dart';
import 'package:flutter/material.dart';

class HotMenuButton extends StatefulWidget {
  const HotMenuButton({this.iconSize, required this.icon, required this.callback, super.key});

  final void Function() callback;
  final IconData icon;
  final double? iconSize;

  @override
  State<HotMenuButton> createState() => _HotMenuButtonState();
}

class _HotMenuButtonState extends State<HotMenuButton> {

  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.callback,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withAlpha(10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            widget.icon,
            size: widget.iconSize == null ? 24 : widget.iconSize,
            color: AppTheme.defaultTheme.mainIconColor,
          ),
        ),
      ),
      onEnter: (isHovered) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (isHovered) {
        setState(() {
          _isHovered = false;
        });
      },
    );
  }
}
