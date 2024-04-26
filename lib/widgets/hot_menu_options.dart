import 'package:code_editor/theme/luna_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HotMenuOption extends StatefulWidget {
  HotMenuOption({
    this.icon,
    required this.text,
    required this.callback,
    required this.withIcon,
    super.key,
  });

  String text;
  bool withIcon;
  IconData? icon;
  void Function() callback;

  @override
  State<HotMenuOption> createState() => _HotMenuOptionState();
}

class _HotMenuOptionState extends State<HotMenuOption> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.callback,
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            _isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            _isHover = false;
          });
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: _isHover ? Colors.white.withAlpha(10) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (widget.withIcon)
                    Icon(
                      widget.icon ?? Icons.file_copy_outlined,
                      color: AppTheme.defaultTheme.mainIconColor,
                      size: AppTheme.defaultTheme.hotMenuFontSize * 1.5,
                    ),
                  if (widget.withIcon) Container(width: 16),
                  SizedBox(
                      height: AppTheme.defaultTheme.hotMenuFontSize * 2,
                      child: Text(widget.text)),
                ],
              ),
              if (widget.withIcon)
                Icon(
                  Icons.keyboard_arrow_right_sharp,
                  color: AppTheme.defaultTheme.mainIconColor,
                  size: AppTheme.defaultTheme.hotMenuFontSize * 1.5,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
