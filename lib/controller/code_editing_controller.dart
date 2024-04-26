import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CodeEditingController {
  final activeFileContent = "".obs;
  final fileTitles = <String>[].obs;
  final fileExtensions = <String>[].obs;
  final allFilesContent = <String>[].obs;
  final fileIcons = <IconData>[].obs;
  final currentCursorLine = 4.obs;
  final currentCursorColumn = 8.obs;
  final currentCharacter = "".obs;
  var currentOpenedFiles = 0.obs;
  var focusedFileIndex = 0.obs;

  CodeEditingController();
}
