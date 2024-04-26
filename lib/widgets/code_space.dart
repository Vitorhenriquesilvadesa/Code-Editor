import 'package:code_editor/controller/code_editing_controller.dart';
import 'package:code_editor/controller/project_menu_controller.dart';
import 'package:code_editor/theme/luna_theme.dart';
import 'package:code_editor/widgets/code_screen.dart';
import 'package:code_editor/widgets/new_code_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:get/get.dart';

class CodeSpace extends StatefulWidget {
  const CodeSpace({super.key});

  @override
  State<CodeSpace> createState() => _CodeSpaceState();
}

class _CodeSpaceState extends State<CodeSpace> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: AppTheme.defaultTheme.codeForegroundColor,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (Get.find<CodeEditingController>().currentOpenedFiles.value >
                  0) {
                return SizedBox(
                  width: Get.width -
                      5 -
                      Get.find<ProjectMenuController>().projectMenuWidth.value,
                  height: Get.height - 48 - 77 - 7,
                  child: Obx(
                    () {
                      return Row(
                        children: [
                          Expanded(child: NewCodeInput()),
                        ],
                      );
                    },
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  width: Get.width -
                      5 -
                      Get.find<ProjectMenuController>().projectMenuWidth.value,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      alignment: Alignment.center,
                      height: Get.size.height - 48 - 77,
                      child: Text("No files opened.",
                          style: AppTheme.defaultTheme.fileSystemTextStyle),
                    ),
                  ),
                );
              }
            }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildFormattedText() {
    String enteredText = _controller.text;
    List<Widget> textWidgets = [];

    List<String> words = enteredText.split(' ');
    for (var word in words) {
      Color color = Colors.white;
      if (word == 'class') {
        color = Colors.blue;
      }

      textWidgets.add(
        Text(
          '$word ',
          style: TextStyle(
            color: color,
            fontFamily: "Jetbrains Mono",
            fontWeight: FontWeight.w100,
          ),
        ),
      );
    }

    return Row(
      children: textWidgets,
    );
  }
}
