import 'dart:io';

import 'package:code_editor/controller/project_menu_controller.dart';
import 'package:code_editor/widgets/file_hierarchy.dart';
import 'package:code_editor/widgets/project_root.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/luna_theme.dart';
import 'custom_dividers.dart';

class ProjectMenu extends StatefulWidget {
  const ProjectMenu({Key? key}) : super(key: key);

  @override
  State<ProjectMenu> createState() => _ProjectMenuState();
}

class _ProjectMenuState extends State<ProjectMenu> {
  late Future<List<FileSystemEntity>> _filesAndFoldersFuture;

  @override
  void initState() {
    super.initState();
    Get.find<ProjectMenuController>().onFolderOpenCallback = openFolder;
    _filesAndFoldersFuture = _loadFilesAndFolders('');
  }

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return Material(
      color: AppTheme.defaultTheme.projectMenuColor,
      child: Column(
        children: [
          const CustomVerticalDivider(height: 1),
          Obx(
            () => Container(
              width: Get.find<ProjectMenuController>().projectMenuWidth.value,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16),
              height: 48,
              color: AppTheme.defaultTheme.codeForegroundColor,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      "Project",
                      style: TextStyle(
                          fontFamily: "Noto Sans",
                          fontSize: 16,
                          color: AppTheme.defaultTheme.mainTextColor),
                    ),
                    // Container(
                    //   alignment: Alignment.center,
                    //   margin: const EdgeInsets.only(left: 8),
                    //   child: GestureDetector(
                    //     onTap: openFolder,
                    //     child: Icon(Icons.keyboard_arrow_down_sharp,
                    //         color: AppTheme.defaultTheme.mainIconColor,
                    //         size: 24),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          const CustomVerticalDivider(height: 1),
          Expanded(
            child: Obx(
              () => SingleChildScrollView(
                child: Container(
                  width:
                      Get.find<ProjectMenuController>().projectMenuWidth.value,
                  color: AppTheme.defaultTheme.projectMenuColor,
                  child: FutureBuilder<List<FileSystemEntity>>(
                    future: _filesAndFoldersFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Text("Fetching files...",
                              style: AppTheme.defaultTheme.fileSystemTextStyle),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final filesAndFolders = snapshot.data ?? [];
                        return RawScrollbar(
                          thumbColor: Colors.white.withAlpha(50),
                          trackColor: Colors.black.withAlpha(50),
                          thickness: 14,
                          trackVisibility: true,
                          thumbVisibility: true,
                          controller: controller,
                          child: SingleChildScrollView(
                            child: ProjectRoot(
                              controller: controller,
                              children: filesAndFolders.map((entity) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: _getIndentation(entity)),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 8, bottom: 4),
                                    child: FileHierarchy(
                                      fileExtension:
                                          entity.path.split(".").last,
                                      entity: entity,
                                      filePath: entity.path,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getIndentation(FileSystemEntity entity) {
    String rootPath = Get.find<ProjectMenuController>().projectContext.value;
    int rootDirectoryPathDepth = rootPath.split(Platform.pathSeparator).length;
    int depth = entity.path
        .split(Platform.pathSeparator)
        .sublist(rootDirectoryPathDepth)
        .length;
    return 24.0 * depth;
  }

  void openFolder() async {
    try {
      String? folderPath = await FilePicker.platform.getDirectoryPath();
      if (folderPath != null) {
        setState(() {
          Get.find<ProjectMenuController>().projectContext.value = folderPath;
          _filesAndFoldersFuture = _loadFilesAndFolders(folderPath);
        });
      } else {
        debugPrint('Nenhuma pasta selecionada.');
      }
    } catch (e) {
      debugPrint('Erro ao selecionar pasta: $e');
    }
  }

  Future<List<FileSystemEntity>> _loadFilesAndFolders(
      String directoryPath) async {
    try {
      final directory = Directory(directoryPath);
      List<FileSystemEntity> entities = directory.listSync(recursive: false);
      return entities;
    } catch (e) {
      debugPrint('Erro ao carregar arquivos e pastas: $e');
      rethrow;
    }
  }
}
