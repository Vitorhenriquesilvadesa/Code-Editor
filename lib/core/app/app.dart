import 'package:code_editor/controller/main_page.dart';
import 'package:code_editor/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LunaEditorApp extends StatefulWidget {
  const LunaEditorApp({super.key});

  @override
  State<LunaEditorApp> createState() => _LunaEditorAppState();
}

class _LunaEditorAppState extends State<LunaEditorApp> {
  @override
  Widget build(BuildContext context) {
    Get.find<ThemeController>().onChangeThemeCallback = setState;

    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
