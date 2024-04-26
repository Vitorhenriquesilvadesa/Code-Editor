import 'package:code_editor/controller/code_editing_controller.dart';
import 'package:code_editor/theme/luna_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodeLine extends StatelessWidget {
  CodeLine({
    required this.child,
    required this.line,
    super.key,
  });

  int line;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
            Obx(
              () => Container(
                color:
                    Get.find<CodeEditingController>().currentCursorLine.value ==
                            line
                        ? Colors.white.withAlpha(20)
                        : Colors.transparent,
                width: 64,
                height: AppTheme.defaultTheme.codeFontSize *
                    AppTheme.defaultTheme.codeLineHeight,
                alignment: Alignment.centerLeft,
                child: Text(
                  line.toString(),
                  style: AppTheme.defaultTheme.codeForegroundTextStyle,
                ),
              ),
            ),
          ] +
          [
            Obx(
              () => Container(
                alignment: Alignment.centerLeft,
                height: AppTheme.defaultTheme.codeFontSize *
                    AppTheme.defaultTheme.codeLineHeight,
                color:
                    Get.find<CodeEditingController>().currentCursorLine.value ==
                            line
                        ? Colors.white.withAlpha(20)
                        : Colors.transparent,
                width: Get.width,
                child: child,
              ),
            ),
          ],
    );
  }
}
