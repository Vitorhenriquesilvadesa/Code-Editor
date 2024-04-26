import 'package:code_editor/controller/project_menu_controller.dart';
import 'package:code_editor/theme/luna_theme.dart';
import 'package:code_editor/widgets/code_space.dart';
import 'package:code_editor/widgets/code_tab_header.dart';
import 'package:code_editor/widgets/custom_dividers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodeTab extends StatefulWidget {
  const CodeTab({super.key});

  @override
  State<CodeTab> createState() => _CodeTabState();
}

class _CodeTabState extends State<CodeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width -
          5 -
          Get.find<ProjectMenuController>().projectMenuWidth.value,
      color: AppTheme.defaultTheme.codeForegroundColor,
      child: const Column(
        children: [
          CustomVerticalDivider(height: 1),
          CodeTabHeader(),
          CustomVerticalDivider(height: 1),
          CodeSpace(),
        ],
      ),
    );
  }
}
