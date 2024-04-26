import 'package:code_editor/controller/project_menu_controller.dart';
import 'package:code_editor/theme/luna_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProjectRoot extends StatefulWidget {
  ProjectRoot({required this.children, required this.controller, super.key});

  ScrollController controller;
  List<Widget> children;

  @override
  State<ProjectRoot> createState() => _ProjectRootState();
}

class _ProjectRootState extends State<ProjectRoot> {
  bool _isOpened = true;
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MouseRegion(
            onEnter: (event) {
              setState(() {
                _isHover = true;
              });
            },
            onExit: (event) {
              setState(() {
                _isHover = false;
              });
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: Get.find<ProjectMenuController>().projectMenuWidth.value,
                decoration: BoxDecoration(
                  color: _isHover
                      ? Colors.white.withAlpha(20)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                height: 32,
                child: Row(
                  children: [
                    const SizedBox(width: 32),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isOpened = !_isOpened;
                        });
                      },
                      child: Icon(
                          _isOpened
                              ? Icons.keyboard_arrow_down_sharp
                              : Icons.keyboard_arrow_right_sharp,
                          color: AppTheme.defaultTheme.mainIconColor,
                          size: 24),
                    ),
                    Icon(FontAwesomeIcons.folderOpen,
                        color: AppTheme.defaultTheme.mainIconColor, size: 16),
                    const SizedBox(width: 8),
                    Text(
                        Get.find<ProjectMenuController>()
                            .projectContext
                            .value
                            .split("/")
                            .last,
                        style: AppTheme.defaultTheme.fileSystemTextStyle)
                  ],
                ),
              ),
            ),
          ),
          if (_isOpened) ...widget.children
        ],
      ),
    );
  }
}
