import 'dart:io';

import 'package:code_editor/controller/code_editing_controller.dart';
import 'package:code_editor/controller/project_menu_controller.dart';
import 'package:code_editor/theme/luna_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FileHierarchy extends StatefulWidget {
  FileHierarchy({
    required this.entity,
    required this.fileExtension,
    super.key,
    required this.filePath,
  });

  final FileSystemEntity entity;
  final String fileExtension;
  final String filePath;

  @override
  State<FileHierarchy> createState() => _FileHierarchyState();
}

class _FileHierarchyState extends State<FileHierarchy> {
  bool _isHovered = false;
  bool _isExpanded = false;
  List<FileHierarchy> _children = [];

  @override
  void initState() {
    super.initState();
    if (widget.entity is Directory && _isExpanded) {
      _loadChildren();
    }
  }

  void _loadChildren() {
    Directory directory = widget.entity as Directory;
    List<FileSystemEntity> entities = directory.listSync(recursive: false);
    _children = entities
        .map(
          (entity) => FileHierarchy(
            entity: entity,
            fileExtension: entity.path.split(".").last,
            filePath: entity.path,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    String filename = widget.entity.path.split("/").last;

    return SizedBox(
      width: Get.find<ProjectMenuController>().projectMenuWidth.value,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.entity is Directory) {
                    setState(() {
                      _isExpanded = !_isExpanded;
                      _children.isEmpty ? _loadChildren() : _children.clear();
                    });
                  } else {
                    _openFile();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? Colors.white.withAlpha(20)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SizedBox(
                    width: Get.find<ProjectMenuController>()
                        .projectMenuWidth
                        .value,
                    child: Row(
                      children: [
                        Container(width: 16),
                        if (widget.entity is Directory)
                          Icon(
                              _isExpanded
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_right,
                              size: 24,
                              color: AppTheme.defaultTheme.mainIconColor),
                        Container(width: widget.entity is Directory ? 0 : 16),
                        Icon(
                            size: 16,
                            color: AppTheme.iconsColors[widget.fileExtension] ??
                                AppTheme.defaultTheme.mainIconColor,
                            widget.entity is Directory
                                ? FontAwesomeIcons.folderOpen
                                : AppTheme.fileExtensionIcons[
                                        widget.fileExtension] ??
                                    Icons.file_copy_outlined),
                        Container(width: 8),
                        Text(
                          filename,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: AppTheme.defaultTheme.fileSystemTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_isExpanded)
                ..._children.map((child) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: widget.entity is Directory ? 32 : 64,
                        right: 8,
                        top: 4,
                        bottom: 4),
                    child: child,
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }

  void _openFile() async {
    CodeEditingController controller = Get.find();
    final file = File(widget.filePath);

    if (file.existsSync()) {
      final content = await file.readAsString();

      controller.activeFileContent.value = content;
      if (!controller.allFilesContent.contains(content)) {
        controller.allFilesContent.add(content);
      }

      String filename = widget.entity.path.split("/").last;
      if (!controller.fileTitles.contains(filename)) {
        controller.fileTitles.add(filename);
        controller.fileExtensions.add(widget.fileExtension);
        controller.fileIcons.add(
            AppTheme.fileExtensionIcons[widget.fileExtension] ??
                Icons.file_copy_outlined);
        controller.currentOpenedFiles++;
      }

      controller.focusedFileIndex.value =
          controller.fileTitles.indexOf(filename);
    } else {}
  }
}
