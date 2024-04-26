class LanguageStructure {
  LanguageStructure({
    required this.keywords,
    required this.singleLineCommentDelimiter,
    required this.statementDelimiter,
    required this.stringDelimiter,
  });

  final List<String> keywords;
  final List<String> stringDelimiter;
  final String statementDelimiter;
  final String singleLineCommentDelimiter;

  factory LanguageStructure.fromMap(Map<String, dynamic> json) {
    return LanguageStructure(
      keywords: List<String>.from(json['keywords'] ?? []),
      singleLineCommentDelimiter: json['singleLineCommentDelimiter'] ?? '',
      statementDelimiter: json['statementDelimiter'] ?? '',
      stringDelimiter: List<String>.from(json['stringDelimiter'] ?? []),
    );
  }
}
