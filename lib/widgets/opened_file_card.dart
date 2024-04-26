import 'package:code_editor/controller/code_editing_controller.dart';
import 'package:code_editor/theme/luna_theme.dart';
import 'package:code_editor/widgets/opened_file_close_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpenedFileCard extends StatefulWidget {
  OpenedFileCard({
    required this.fileExtension,
    required this.index,
    super.key,
  });

  String fileExtension;
  int index;

  @override
  State<OpenedFileCard> createState() => _OpenedFileCardState();
}

class _OpenedFileCardState extends State<OpenedFileCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CodeEditingController controller = Get.find();
        controller.activeFileContent.value =
            controller.allFilesContent[widget.index];
        controller.focusedFileIndex.value = widget.index;
      },
      child: Container(
        alignment: Alignment.center,
        width: 144,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: widget.index ==
                Get.find<CodeEditingController>().focusedFileIndex.value
            ? AppTheme.defaultTheme.codeForegroundColor
            : AppTheme.defaultTheme.codeHeaderColor,
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Obx(
                () {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Get.find<CodeEditingController>()
                            .fileIcons[widget.index],
                        size: 20,
                        color: AppTheme.iconsColors[widget.fileExtension],
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          Get.find<CodeEditingController>()
                              .fileTitles[widget.index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: "Noto Sans",
                            fontSize: 12,
                            color: AppTheme.defaultTheme.mainTextColor,
                          ),
                        ),
                      ),
                      OpenedFileCloseButton(index: widget.index)
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
