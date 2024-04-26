import 'dart:io';
import 'package:code_editor/controller/project_menu_controller.dart';
import 'package:code_editor/theme/theme_controller.dart';
import 'package:code_editor/widgets/hot_menu_button.dart';
import 'package:code_editor/widgets/restart_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as path;

import 'package:code_editor/controller/code_editing_controller.dart';
import 'package:code_editor/controller/hot_menu_controller.dart';
import 'package:code_editor/theme/luna_theme.dart';
import 'package:code_editor/widgets/custom_dividers.dart';
import 'package:code_editor/widgets/hot_menu_options.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HotMenu extends StatefulWidget {
  const HotMenu({super.key});

  @override
  State<HotMenu> createState() => _HotMenuState();
}

class _HotMenuState extends State<HotMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48,
          color: AppTheme.defaultTheme.codeHeaderColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HotMenuButton(
                  icon: Icons.more_vert,
                  callback: () {
                    Get.find<HotMenuController>().isHotMenuOptionsOpened.value =
                        true;
                  }),
              Obx(
                () => Material(
                  color: Colors.transparent,
                  child: Text(
                      Get.find<ProjectMenuController>()
                          .projectContext
                          .value
                          .split("/")
                          .last,
                      style: AppTheme.defaultTheme.hotMenuMainTextStyle),
                ),
              ),
              Row(
                children: [
                  HotMenuButton(
                      icon: Icons.play_arrow_sharp,
                      iconSize: 32,
                      callback: () {}),
                  HotMenuButton(icon: FontAwesomeIcons.bug, callback: () {}),
                ],
              )
            ],
          ),
        ),
        Obx(
          () {
            if (Get.find<HotMenuController>().isHotMenuOptionsOpened.value) {
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.find<HotMenuController>().closeAllPrimaryMenus();
                    },
                    child: Container(
                        width: Get.width,
                        height: Get.height - 48,
                        color: Colors.black.withAlpha(200)),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        if (Get.find<HotMenuController>()
                            .isHotMenuOptionsOpened
                            .isTrue) {
                          return Material(
                            color: Colors.transparent,
                            textStyle:
                                AppTheme.defaultTheme.hotMenuMainTextStyle,
                            child: Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.all(8),
                              width: 320,
                              height: 344,
                              color: AppTheme.defaultTheme.projectMenuColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const CustomVerticalDivider(height: 1),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          height: 24,
                                          width: 1,
                                          color: AppTheme
                                              .defaultTheme.dividerColor),
                                      GestureDetector(
                                        onTap: () {
                                          Get.find<HotMenuController>()
                                              .closeAllPrimaryMenus();
                                        },
                                        child: Container(
                                          width: 16,
                                          height: 16,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.only(
                                              top: 8, right: 8),
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: const Icon(
                                              FontAwesomeIcons.xmark,
                                              color: Colors.white,
                                              size: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 1,
                                          height: 318,
                                          color: AppTheme
                                              .defaultTheme.dividerColor),
                                      Expanded(
                                        flex: 18,
                                        child: Column(
                                          children: [
                                            HotMenuOption(
                                                icon: FontAwesomeIcons.file,
                                                text: "New",
                                                withIcon: true,
                                                callback: () {}),
                                            HotMenuOption(
                                                text: "Open",
                                                withIcon: true,
                                                icon:
                                                    FontAwesomeIcons.folderOpen,
                                                callback: () {
                                                  HotMenuController controller =
                                                      Get.find();
                                                  controller
                                                      .closeAllSecondaryMenus();
                                                  controller.isHotMenuOpenOpened
                                                          .value =
                                                      !controller
                                                          .isHotMenuOpenOpened
                                                          .value;
                                                }),
                                            HotMenuOption(
                                                icon: FontAwesomeIcons
                                                    .folderClosed,
                                                text: "Close",
                                                withIcon: true,
                                                callback: () {}),
                                            HotMenuOption(
                                              icon:
                                                  FontAwesomeIcons.penToSquare,
                                              text: "Edit",
                                              withIcon: true,
                                              callback: () async {
                                                HotMenuController controller =
                                                    Get.find();
                                                controller
                                                    .closeAllSecondaryMenus();
                                                controller.isHotMenuEditOpened
                                                        .value =
                                                    !controller
                                                        .isHotMenuEditOpened
                                                        .value;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          width: 1,
                                          height: 318,
                                          color: AppTheme
                                              .defaultTheme.dividerColor),
                                    ],
                                  ),
                                  const CustomVerticalDivider(height: 1),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                      // Open Option Implementation
                      Obx(
                        () {
                          if (Get.find<HotMenuController>()
                              .isHotMenuOpenOpened
                              .isTrue) {
                            return Container(
                              width: 120,
                              height: 240,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.defaultTheme.projectMenuColor,
                                border: Border(
                                  left: BorderSide(
                                      color: AppTheme.defaultTheme.dividerColor,
                                      width: 1),
                                  right: BorderSide(
                                      color: AppTheme.defaultTheme.dividerColor,
                                      width: 1),
                                  top: BorderSide(
                                      color: AppTheme.defaultTheme.dividerColor,
                                      width: 1),
                                  bottom: BorderSide(
                                      color: AppTheme.defaultTheme.dividerColor,
                                      width: 1),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                textStyle:
                                    AppTheme.defaultTheme.hotMenuMainTextStyle,
                                child: Column(
                                  children: [
                                    HotMenuOption(
                                        text: "File",
                                        withIcon: false,
                                        callback: () async {
                                          final result = await FilePicker
                                              .platform
                                              .pickFiles();
                                          CodeEditingController controller =
                                              Get.find();

                                          if (result != null) {
                                            final file =
                                                File(result.files.single.path!);

                                            if (file.existsSync()) {
                                              final content =
                                                  await file.readAsString();
                                              controller.activeFileContent
                                                  .value = content;
                                              controller.allFilesContent
                                                  .add(content);
                                              controller.fileTitles.add(
                                                  result.files.single.name);

                                              String extension = path.extension(
                                                  result.files.single.path!);

                                              controller.fileIcons.add(
                                                  AppTheme.fileExtensionIcons[
                                                          extension] ??
                                                      Icons.file_copy_outlined);
                                              controller.fileExtensions
                                                  .add(extension);

                                              HotMenuController
                                                  hotMenuController =
                                                  Get.find<HotMenuController>();

                                              hotMenuController
                                                  .closeAllPrimaryMenus();
                                              controller.currentOpenedFiles++;
                                            } else {}
                                          } else {}
                                        }),
                                    HotMenuOption(
                                        text: "Folder",
                                        withIcon: false,
                                        callback: () async {
                                          Get.find<ProjectMenuController>()
                                              .onFolderOpenCallback();
                                          HotMenuController hotMenuController =
                                              Get.find<HotMenuController>();

                                          hotMenuController
                                              .closeAllPrimaryMenus();
                                        })
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      Obx(
                        () {
                          if (Get.find<HotMenuController>()
                              .isHotMenuEditOpened
                              .isTrue) {
                            return Container(
                              width: 120,
                              height: 240,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.defaultTheme.projectMenuColor,
                                border: Border(
                                  left: BorderSide(
                                      color: AppTheme.defaultTheme.dividerColor,
                                      width: 1),
                                  right: BorderSide(
                                      color: AppTheme.defaultTheme.dividerColor,
                                      width: 1),
                                  top: BorderSide(
                                      color: AppTheme.defaultTheme.dividerColor,
                                      width: 1),
                                  bottom: BorderSide(
                                      color: AppTheme.defaultTheme.dividerColor,
                                      width: 1),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                textStyle:
                                    AppTheme.defaultTheme.hotMenuMainTextStyle,
                                child: Column(
                                  children: [
                                    HotMenuOption(
                                      text: "Theme",
                                      withIcon: false,
                                      callback: () async {
                                        final result = await FilePicker.platform
                                            .pickFiles();

                                        if (result != null) {
                                          final file =
                                              File(result.files.single.path!);

                                          if (file.existsSync()) {
                                            final content =
                                                await file.readAsString();
                                            AppTheme.setTheme(content);
                                            Get.find<ThemeController>()
                                                .onChangeThemeCallback(() {});
                                            final defaultThemeFile = File(
                                                'lib/assets/settings/themes/default_theme.json');
                                            await defaultThemeFile
                                                .writeAsString(content);

                                            HotMenuController
                                                hotMenuController = Get.find();
                                            hotMenuController
                                                .closeAllPrimaryMenus();
                                            RestartWidget.restartApp(context);
                                          } else {}
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  )
                ],
              );
            } else {
              return Container();
            }
          },
        )
      ],
    );
  }
}
