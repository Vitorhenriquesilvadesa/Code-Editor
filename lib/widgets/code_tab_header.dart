import 'package:code_editor/controller/code_editing_controller.dart';
import 'package:code_editor/theme/luna_theme.dart';
import 'package:code_editor/widgets/opened_file_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodeTabHeader extends StatefulWidget {
  const CodeTabHeader({super.key});

  @override
  State<CodeTabHeader> createState() => _CodeTabHeaderState();
}

class _CodeTabHeaderState extends State<CodeTabHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: AppTheme.defaultTheme.codeBackgroundColor,
      child: Obx(
        () => ListView.builder(
          itemCount: Get.find<CodeEditingController>().currentOpenedFiles.value,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            CodeEditingController controller = Get.find();
            return Obx(
              () => Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  OpenedFileCard(
                    fileExtension:
                        controller.fileExtensions[index],
                    index: index,
                  ),
                  if (index ==
                      Get.find<CodeEditingController>().focusedFileIndex.value)
                    Container(
                      width: 144,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.defaultTheme.mainIconColor,
                        borderRadius: BorderRadius.circular(32),
                      ),
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
