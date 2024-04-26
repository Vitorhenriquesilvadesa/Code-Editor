import 'package:code_editor/controller/project_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodeScreen extends StatelessWidget {
  CodeScreen({Key? key}) : super(key: key);

  var cursorX = 0.0.obs;
  var cursorY = 0.0.obs;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        cursorX.value = event.position.dx;
        cursorY.value = event.position.dy;
        debugPrint("Mouse position: ${cursorX.value}, ${cursorY.value}");
      },
      child: Container(
        color: Colors.red.withAlpha(0),
        width: Get.width -
            Get.find<ProjectMenuController>().projectMenuWidth.value,
        height: Get.height - 48,
        // child: Stack(
        //   children: [
        //     Obx(
        //       () => Positioned(
        //         width: 2,
        //         height: AppTheme.defaultTheme.codeFontSize *
        //                 AppTheme.defaultTheme.codeLineHeight -
        //             8,
        //         left: cursorX.value -
        //             Get.find<ProjectMenuController>().projectMenuWidth.value -
        //             77 -
        //             5,
        //         top: cursorY.value - 96 - 24,
        //         child: const AnimatedCodeCursor(),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
