import 'package:code_editor/controller/code_editing_controller.dart';
import 'package:code_editor/widgets/animated_code_cursor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditableHighlightField extends StatelessWidget {
  EditableHighlightField({
    required this.child,
    required this.controller,
    required this.line,
    required this.column,
    required this.text,
    super.key,
  });

  Text child;
  String text;
  int line;
  int column;
  CodeEditingController controller;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: Obx(
        () {
          if (controller.currentCursorLine.value == line &&
              controller.currentCursorColumn.value == column) {

          controller.currentCharacter.value = text;
            return Stack(children: [
              GestureDetector(
                  onTapDown: (details) {
                    CodeEditingController controller = Get.find();
                    controller.currentCursorLine.value = line;
                    controller.currentCursorColumn.value = column + 1;
                  },
                  child: child),
              const AnimatedCodeCursor(),
            ]);
          } else {
            return GestureDetector(
                onTap: () {
                  CodeEditingController controller = Get.find();
                  controller.currentCursorLine.value = line;
                  controller.currentCursorColumn.value = column + 1;
                },
                child: child);
          }
        },
      ),
    );
  }
}
