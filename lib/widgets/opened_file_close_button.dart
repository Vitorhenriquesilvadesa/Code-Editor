import 'package:code_editor/controller/code_editing_controller.dart';
import 'package:code_editor/theme/luna_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OpenedFileCloseButton extends StatefulWidget {
  OpenedFileCloseButton({required this.index, super.key});

  int index;

  @override
  State<OpenedFileCloseButton> createState() => _OpenedFileCloseButtonState();
}

class _OpenedFileCloseButtonState extends State<OpenedFileCloseButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
          onTap: () {
            CodeEditingController controller = Get.find();
            controller.fileExtensions.removeAt(widget.index);
            controller.fileIcons.removeAt(widget.index);
            controller.fileTitles.removeAt(widget.index);
            controller.allFilesContent.removeAt(widget.index);
            controller.currentOpenedFiles.value--;

            if (widget.index <= controller.focusedFileIndex.value) {
              if (controller.currentOpenedFiles.value > 0) {
                controller.focusedFileIndex.value =
                    controller.focusedFileIndex.value - 1;
                controller.activeFileContent.value = controller
                    .allFilesContent[controller.focusedFileIndex.value];
              }
            }
            if (controller.currentOpenedFiles.value == 0) {
              controller.activeFileContent.value = "";
            }
          },
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
                color: _isHovered
                    ? AppTheme.defaultTheme.mainIconColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(32)),
            child: Icon(
              FontAwesomeIcons.xmark,
              size: 12,
              color: _isHovered
                  ? AppTheme.defaultTheme.projectMenuColor
                  : AppTheme.defaultTheme.mainTextColor,
            ),
          )),
    );
  }
}
