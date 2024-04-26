import 'package:code_editor/controller/code_editing_controller.dart';
import 'package:code_editor/controller/project_menu_controller.dart';
import 'package:code_editor/theme/luna_theme.dart';
import 'package:code_editor/widgets/code_tab.dart';
import 'package:code_editor/widgets/hot_menu.dart';
import 'package:code_editor/widgets/project_menu.dart';
import 'package:code_editor/widgets/custom_dividers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) {
          CodeEditingController controller = Get.find();

          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.arrowRight) {
            if (controller.currentCharacter.value != "\n") {
              controller.currentCursorColumn.value++;
            } else {
              controller.currentCursorLine.value++;
              controller.currentCursorColumn.value = 0;
            }
          }

          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            Get.find<CodeEditingController>().currentCursorColumn.value--;
          }
        },
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(color: AppTheme.defaultTheme.codeBackgroundColor),
            Column(
              children: [
                const CustomVerticalDivider(height: 1),
                const SizedBox(height: 48),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Obx(() => SizedBox(
                            width: Get.find<ProjectMenuController>()
                                .projectMenuWidth
                                .value,
                            child: const ProjectMenu(),
                          )),
                      MouseRegion(
                        cursor: SystemMouseCursors.resizeColumn,
                        child: GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            ProjectMenuController controller = Get.find();
                            controller.projectMenuWidth.value = details
                                .globalPosition.dx
                                .clamp(1, Get.width - 5);
                          },
                          child: const CustomHorizontalDivider(width: 5),
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                            width: Get.width -
                                5 -
                                Get.find<ProjectMenuController>()
                                    .projectMenuWidth
                                    .value,
                            child: const CodeTab()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const HotMenu(),
          ],
        ),
      ),
    );
  }
}
