import 'dart:convert';
import 'dart:io';

import 'package:code_editor/parsing/language_structure.dart';

class CodeAnalyzingController {
  final Map<String, LanguageStructure> _languagesMap = {};

  void initLanguages(List<String> languages) async {
    for(String language in languages) {
      File languageFile = File("lib/assets/settings/languages/$language.json");
      String fileContent = languageFile.readAsStringSync();
      _languagesMap[language] = LanguageStructure.fromMap(jsonDecode(fileContent));
    }
  }

  LanguageStructure? getLanguage(String language) => _languagesMap[language];
}