import 'package:code_editor/theme/luna_theme.dart';
import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatefulWidget {
  final double height;
  final double? marginLeft;
  final double? marginRight;

  const CustomVerticalDivider({
    required this.height,
    this.marginLeft,
    this.marginRight,
    super.key,
  });

  @override
  State<CustomVerticalDivider> createState() => _CustomVerticalDividerState();
}

class _CustomVerticalDividerState extends State<CustomVerticalDivider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: widget.marginLeft ?? 0.0, right: widget.marginRight ?? 0.0),
      color: Colors.transparent,
      child:
          Container(height: widget.height, color: AppTheme.defaultTheme.dividerColor),
    );
  }
}

class CustomHorizontalDivider extends StatelessWidget {
  final double width;

  final double? marginTop;
  final double? marginBottom;

  const CustomHorizontalDivider({
    required this.width,
    this.marginTop,
    this.marginBottom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding:
          EdgeInsets.only(top: marginTop ?? 0.0, bottom: marginBottom ?? 0.0),
      child: Container(width: width, color: AppTheme.defaultTheme.dividerColor),
    );
  }
}
