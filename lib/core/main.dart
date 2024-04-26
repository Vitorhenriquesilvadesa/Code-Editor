import 'package:code_editor/core/app/app.dart';
import 'package:code_editor/controller/code_analyzing_controller.dart';
import 'package:code_editor/controller/code_editing_controller.dart';
import 'package:code_editor/controller/hot_menu_controller.dart';
import 'package:code_editor/controller/project_menu_controller.dart';
import 'package:code_editor/theme/luna_theme.dart';
import 'package:code_editor/theme/theme_controller.dart';
import 'package:code_editor/widgets/restart_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  Get.put(CodeEditingController());
  Get.put(HotMenuController());
  Get.put(ThemeController());
  Get.put(CodeAnalyzingController());
  Get.put(ProjectMenuController());
  Get.find<CodeAnalyzingController>().initLanguages(
    <String>["dart"],
  );
  await AppTheme.initTheme();
  runApp(const RestartWidget(child: LunaEditorApp()));
}
