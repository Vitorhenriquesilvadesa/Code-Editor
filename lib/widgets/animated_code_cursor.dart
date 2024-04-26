import 'dart:async';
import 'package:code_editor/theme/luna_theme.dart';
import 'package:flutter/material.dart';

class AnimatedCodeCursor extends StatefulWidget {
  const AnimatedCodeCursor({Key? key}) : super(key: key);

  @override
  State<AnimatedCodeCursor> createState() => _AnimatedCodeCursorState();
}

class _AnimatedCodeCursorState extends State<AnimatedCodeCursor> {
  bool _isVisible = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer =
        Timer.periodic(const Duration(milliseconds: 500), _toggleVisibility);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        color: AppTheme.defaultTheme.mainIconColor,
      ),
    );
  }

  void _toggleVisibility(Timer timer) {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
}
