import 'dart:convert';
import 'dart:io';

import 'package:code_editor/theme/theme_controller.dart';
import 'package:flutter/material.dart';

import 'package:code_editor/util/util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_icons/simple_icons.dart';

class AppTheme {
  static final Map<String, IconData> fileExtensionIcons = {
    'dart': SimpleIcons.dart,
    'python': SimpleIcons.python,
    'a': SimpleIcons.assemblyscript,
    'so': SimpleIcons.assemblyscript,
    'yaml': SimpleIcons.yaml,
    'c': SimpleIcons.c,
    'cc': SimpleIcons.c,
    'h': SimpleIcons.c,
    'hpp': SimpleIcons.c,
    'cpp': SimpleIcons.cplusplus,
    'java': FontAwesomeIcons.java,
    'py': FontAwesomeIcons.python,
    'javascript': SimpleIcons.javascript,
    'json': SimpleIcons.json,
    'typescript': SimpleIcons.typescript,
    'swift': FontAwesomeIcons.swift,
    'kotlin': SimpleIcons.kotlin,
    'go': SimpleIcons.go,
    'rust': SimpleIcons.rust,
    'ruby': SimpleIcons.ruby,
    'php': SimpleIcons.php,
    'html': SimpleIcons.html5,
    'css': SimpleIcons.css3,
    'scss': SimpleIcons.sass,
    'less': SimpleIcons.less,
    'sass': SimpleIcons.sass,
    'lua': SimpleIcons.lua,
    'perl': SimpleIcons.perl,
    'r': SimpleIcons.r,
    'shell': FontAwesomeIcons.code,
    'powershell': FontAwesomeIcons.code,
    'sql': FontAwesomeIcons.database,
    'pdf': FontAwesomeIcons.filePdf,
    'jpg': FontAwesomeIcons.fileImage,
    'jpeg': FontAwesomeIcons.fileImage,
    'png': FontAwesomeIcons.fileImage,
    'txt': FontAwesomeIcons.fileLines,
    'doc': FontAwesomeIcons.fileWord,
    'docx': FontAwesomeIcons.fileWord,
    'xls': FontAwesomeIcons.fileExcel,
    'xlsx': FontAwesomeIcons.fileExcel,
    'ppt': FontAwesomeIcons.filePowerpoint,
    'pptx': FontAwesomeIcons.filePowerpoint,
    'zip': FontAwesomeIcons.fileZipper,
    'rar': FontAwesomeIcons.fileZipper,
    'tar': FontAwesomeIcons.fileZipper,
    'gz': FontAwesomeIcons.fileZipper,
    '7z': FontAwesomeIcons.fileZipper,
    'mp3': FontAwesomeIcons.fileAudio,
    'wav': FontAwesomeIcons.fileAudio,
    'mp4': FontAwesomeIcons.fileVideo,
    'avi': FontAwesomeIcons.fileVideo,
    'mkv': FontAwesomeIcons.fileVideo,
  };

  static final Map<String, Color> iconsColors = {
    'dart': Colors.blueAccent,
    'c': const Color.fromRGBO(0, 255, 0, 1),
    'h': const Color.fromRGBO(7, 188, 255, 1.0),
    'hpp': const Color.fromRGBO(7, 188, 255, 1.0),
    'py': const Color.fromRGBO(255, 197, 7, 1.0),
    // Verde para C
    'cpp': const Color.fromRGBO(255, 0, 0, 1),
    // Vermelho para C++
    'java': const Color.fromRGBO(255, 140, 0, 1),
    // Laranja para Java
    'python': const Color.fromRGBO(255, 255, 0, 1),
    // Amarelo para Python
    'javascript': const Color.fromRGBO(255, 215, 0, 1),
    // Ouro para JavaScript
    'json': const Color.fromRGBO(255, 140, 0, 1.0),
    // Ouro para JavaScript
    'typescript': const Color.fromRGBO(0, 0, 255, 1),
    // Azul para TypeScript
    'swift': const Color.fromRGBO(255, 165, 0, 1),
    // Laranja-claro para Swift
    'kotlin': const Color.fromRGBO(100, 0, 255, 1),
    // Azul-violeta para Kotlin
    'go': const Color.fromRGBO(0, 128, 0, 1),
    // Verde-escuro para Go
    'rust': const Color.fromRGBO(204, 85, 0, 1),
    // Laranja-avermelhado para Rust
    'ruby': const Color.fromRGBO(204, 0, 0, 1),
    // Vermelho-escuro para Ruby
    'php': const Color.fromRGBO(0, 0, 153, 1),
    // Azul-escuro para PHP
    'html': const Color.fromRGBO(255, 127, 80, 1),
    // Coral para HTML
    'css': const Color.fromRGBO(0, 191, 255, 1),
    // Azul-claro para CSS
    'scss': const Color.fromRGBO(0, 191, 255, 1),
    // Azul-claro para SCSS
    'less': const Color.fromRGBO(0, 191, 255, 1),
    // Azul-claro para LESS
    'sass': const Color.fromRGBO(0, 191, 255, 1),
    // Azul-claro para SASS
    'lua': const Color.fromRGBO(255, 165, 0, 1),
    // Laranja-claro para Lua
    'perl': const Color.fromRGBO(255, 102, 102, 1),
    // Rosa para Perl
    'r': const Color.fromRGBO(25, 25, 112, 1),
    // Azul-escuro para R
    'shell': const Color.fromRGBO(128, 128, 128, 1),
    // Cinza para Shell
    'powershell': const Color.fromRGBO(0, 0, 128, 1),
    // Azul-escuro para PowerShell
    'sql': const Color.fromRGBO(102, 204, 255, 1),
    // Azul-claro para SQL
    'pdf': const Color.fromRGBO(0, 204, 204, 1),
    // Azul-ciano para PDF
    'jpg': const Color.fromRGBO(255, 204, 204, 1),
    // Rosa-claro para JPG
    'jpeg': const Color.fromRGBO(255, 204, 204, 1),
    // Rosa-claro para JPEG
    'png': const Color.fromRGBO(255, 204, 204, 1),
    // Rosa-claro para PNG
    'txt': const Color.fromRGBO(255, 204, 153, 1),
    // Laranja-claro para TXT
    'doc': const Color.fromRGBO(0, 102, 204, 1),
    // Azul-escuro para DOC
    'docx': const Color.fromRGBO(0, 102, 204, 1),
    // Azul-escuro para DOCX
    'xls': const Color.fromRGBO(0, 204, 102, 1),
    // Verde-escuro para XLS
    'xlsx': const Color.fromRGBO(0, 204, 102, 1),
    // Verde-escuro para XLSX
    'ppt': const Color.fromRGBO(204, 0, 204, 1),
    // Roxo para PPT
    'pptx': const Color.fromRGBO(204, 0, 204, 1),
    // Roxo para PPTX
    'zip': const Color.fromRGBO(255, 153, 51, 1),
    // Laranja-escuro para ZIP
    'rar': const Color.fromRGBO(255, 153, 51, 1),
    // Laranja-escuro para RAR
    'tar': const Color.fromRGBO(255, 153, 51, 1),
    // Laranja-escuro para TAR
    'gz': const Color.fromRGBO(255, 153, 51, 1),
    // Laranja-escuro para GZ
    '7z': const Color.fromRGBO(255, 153, 51, 1),
    // Laranja-escuro para 7Z
    'mp3': const Color.fromRGBO(153, 0, 204, 1),
    // Roxo-escuro para MP3
    'wav': const Color.fromRGBO(153, 0, 204, 1),
    // Roxo-escuro para WAV
    'mp4': const Color.fromRGBO(255, 0, 102, 1),
    // Rosa-escuro para MP4
    'avi': const Color.fromRGBO(255, 0, 102, 1),
    // Rosa-escuro para AVI
    'mkv': const Color.fromRGBO(255, 0, 102, 1),
    // Rosa-escuro para MKV
  };

  late Color codeBackgroundColor;
  late Color projectMenuColor;
  late Color dividerColor;
  late Color mainTextColor;
  late Color mainIconColor;
  late Color codeForegroundColor;
  late Color codeHeaderColor;
  late Color codeIdentifierColor;
  late Color codeCommonWordColor;
  late Color codeKeywordColor;
  late Color codeVariableColor;
  late Color codeFunctionColor;
  late Color codeCommentColor;
  late Color codeStringColor;
  late Color codeGenericTypeColor;
  late Color codeForegroundTextColor;

  late double codeFontSize;
  late double codeLineHeight;
  late double hotMenuFontSize;

  late TextStyle codeIdentifierTextStyle;
  late TextStyle codeCommonWordTextStyle;
  late TextStyle codeKeywordTextStyle;
  late TextStyle codeVariableTextStyle;
  late TextStyle codeFunctionTextStyle;
  late TextStyle codeStringTextStyle;
  late TextStyle codeCommentTextStyle;
  late TextStyle codeGenericTypeTextStyle;
  late TextStyle codeForegroundTextStyle;
  late TextStyle hotMenuMainTextStyle;
  late TextStyle fileSystemTextStyle;

  AppTheme();

  AppTheme._({
    required this.codeBackgroundColor,
    required this.codeForegroundColor,
    required this.dividerColor,
    required this.mainIconColor,
    required this.mainTextColor,
    required this.projectMenuColor,
    required this.codeHeaderColor,
    required this.codeIdentifierColor,
    required this.codeCommonWordColor,
    required this.codeKeywordColor,
    required this.codeVariableColor,
    required this.codeFunctionColor,
    required this.codeStringColor,
    required this.codeGenericTypeColor,
    required this.codeForegroundTextColor,
    required this.codeFontSize,
    required this.codeLineHeight,
    required this.hotMenuFontSize,
    required this.codeCommentColor,
  }) {
    codeIdentifierTextStyle = TextStyle(
      color: codeIdentifierColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
    );
    codeCommonWordTextStyle = TextStyle(
      color: codeCommonWordColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
    );
    codeKeywordTextStyle = TextStyle(
      color: codeKeywordColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
    );
    codeVariableTextStyle = TextStyle(
      color: codeVariableColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
    );
    codeFunctionTextStyle = TextStyle(
      color: codeFunctionColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
    );
    codeStringTextStyle = TextStyle(
      color: codeStringColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
    );
    codeGenericTypeTextStyle = TextStyle(
      color: codeGenericTypeColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
    );
    codeForegroundTextStyle = TextStyle(
      color: codeForegroundTextColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
    );
    hotMenuMainTextStyle = TextStyle(
      color: mainTextColor,
      fontFamily: "Noto Sans",
      fontSize: codeFontSize,
    );
    codeCommentTextStyle = TextStyle(
      color: codeCommentColor,
      fontStyle: FontStyle.italic,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
    );
    fileSystemTextStyle = TextStyle(
      color: mainTextColor,
      fontFamily: "Jetbrains Mono",
      fontSize: 14,
    );
  }

  factory AppTheme.fromMap(Map<String, dynamic> json) {
    AppTheme theme = AppTheme();
    theme.codeBackgroundColor = stringToColor(json['backgroundColor']);
    theme.codeForegroundColor = stringToColor(json['foregroundColor']);
    theme.codeHeaderColor = stringToColor(json['headerColor']);
    theme.dividerColor = stringToColor(json['dividerColor']);
    theme.mainIconColor = stringToColor(json['iconColor']);
    theme.mainTextColor = stringToColor(json['textColor']);
    theme.projectMenuColor = stringToColor(json['projectMenuColor']);
    theme.codeIdentifierColor = stringToColor(json['identifierColor']);
    theme.codeCommonWordColor = stringToColor(json['commonWordColor']);
    theme.codeKeywordColor = stringToColor(json['keywordColor']);
    theme.codeVariableColor = stringToColor(json['variableColor']);
    theme.codeFunctionColor = stringToColor(json['functionColor']);
    theme.codeStringColor = stringToColor(json['stringColor']);
    theme.codeGenericTypeColor = stringToColor(json['genericTypeColor']);
    theme.codeForegroundTextColor = stringToColor(json['foregroundTextColor']);
    theme.codeCommentColor = stringToColor(json['commentColor']);
    theme.codeFontSize = double.parse(json['fontSize']);
    theme.codeLineHeight = double.parse(json['lineHeight']);
    theme.hotMenuFontSize = double.parse(json['menuFontSize']);

    return theme;
  }

  // Comment
  static late AppTheme _defaultTheme;

  static Future<void> initTheme() async {
    File themeFile = File("lib/assets/settings/themes/default_theme.json");
    final content = await themeFile.readAsString();
    AppTheme.startTheme(content);
    AppTheme.fromMap(jsonDecode(content));
  }

  static AppTheme __defaultTheme = AppTheme._(
    codeBackgroundColor: const Color(0xFF282A36),
    codeForegroundColor: const Color(0xFF252931),
    codeHeaderColor: const Color(0xFF1D2025),
    dividerColor: const Color(0xFF332C48),
    mainIconColor: const Color(0xFF37A9FF),
    mainTextColor: const Color(0xFFC4C4C4),
    projectMenuColor: const Color(0xFF1D2025),
    codeIdentifierColor: const Color(0xFFE5C07B),
    codeCommonWordColor: const Color(0xFFABB2BF),
    codeKeywordColor: const Color(0xFFC678DD),
    codeVariableColor: const Color(0xFFE06C75),
    codeFunctionColor: const Color(0xFF61AFEF),
    codeStringColor: const Color(0xFFF1FA8C),
    codeGenericTypeColor: const Color(0xFF56B6C2),
    codeForegroundTextColor: const Color(0xFF525B6A),
    codeCommentColor: const Color(0xFF6272A4),
    codeFontSize: 20,
    codeLineHeight: 1.8,
    hotMenuFontSize: 14,
  );

  void applyTheme() {
    codeIdentifierTextStyle = TextStyle(
      color: codeIdentifierColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
      height: codeLineHeight,
    );
    codeCommonWordTextStyle = TextStyle(
      color: codeCommonWordColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
      height: codeLineHeight,
    );
    codeKeywordTextStyle = TextStyle(
      color: codeKeywordColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
      height: codeLineHeight,
    );
    codeVariableTextStyle = TextStyle(
      color: codeVariableColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
      height: codeLineHeight,
    );
    codeFunctionTextStyle = TextStyle(
      color: codeFunctionColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
      height: codeLineHeight,
    );
    codeStringTextStyle = TextStyle(
      color: codeStringColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
    );
    codeGenericTypeTextStyle = TextStyle(
      color: codeGenericTypeColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
      height: codeLineHeight,
    );
    codeForegroundTextStyle = TextStyle(
      color: codeForegroundTextColor,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
      height: codeLineHeight,
    );
    hotMenuMainTextStyle = TextStyle(
      color: mainTextColor,
      fontFamily: "Noto Sans",
      fontSize: codeFontSize,
      height: codeLineHeight,
    );
    codeCommentTextStyle = TextStyle(
      color: codeCommentColor,
      fontStyle: FontStyle.italic,
      fontFamily: "Jetbrains Mono",
      fontSize: codeFontSize,
      height: codeLineHeight,
    );
    fileSystemTextStyle = TextStyle(
      color: mainTextColor,
      fontFamily: "Jetbrains Mono",
      fontSize: 14,
    );
  }

  static AppTheme get defaultTheme => _defaultTheme;

  static void setTheme(String json) {
    _defaultTheme = AppTheme.fromMap(jsonDecode(json));
    _defaultTheme.applyTheme();
    Get.find<ThemeController>().onChangeThemeCallback(() {});
  }

  static void startTheme(String json) {
    _defaultTheme = AppTheme.fromMap(jsonDecode(json));
    _defaultTheme.applyTheme();
  }
}
