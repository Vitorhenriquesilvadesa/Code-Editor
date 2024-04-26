import 'dart:core';

import 'package:code_editor/controller/code_editing_controller.dart';
import 'package:code_editor/controller/project_menu_controller.dart';
import 'package:code_editor/theme/luna_theme.dart';
import 'package:code_editor/parsing/code_lexer.dart';
import 'package:code_editor/widgets/code_line.dart';
import 'package:code_editor/widgets/editable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodeInput extends StatelessWidget {
  CodeInput({required this.source, super.key});

  final String source;
  final Lexer lexer = Lexer();
  late final List<Token> tokens;
  int column = 1;

  @override
  Widget build(BuildContext context) {
    tokens = lexer.scanTokens(source);

    return Expanded(
      child: transformTokensToFlutterWidgets(tokens),
    );
  }

  Widget transformTokensToFlutterWidgets(List<Token> tokens) {
    int lineIndex = 1;

    List<Widget> lines = [];
    List<Widget> currentRowChildren = [];

    CodeEditingController controller = Get.find();
    for (int i = 0; i < tokens.length; i++) {
      if (tokens[i].type != TokenType.newLine) {
        currentRowChildren
            .addAll(getColoredText(tokens[i], i, controller, lineIndex));
      } else {
        lines.add(
          CodeLine(
            line: lineIndex,
            child: Row(children: currentRowChildren),
          ),
        );
        currentRowChildren = [];
        lineIndex++;
        column = 1;
      }
    }

    if (lines.isNotEmpty) {
      lines.add(
        CodeLine(
          line: lineIndex,
          child: Row(children: currentRowChildren),
        ),
      );
    }

    return Obx(
      () {
        return SizedBox(
          width: Get.width -
              5 -
              Get.find<ProjectMenuController>().projectMenuWidth.value,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: lines,
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> getColoredText(Token token, int currentIndex,
      CodeEditingController controller, int line) {
    AppTheme theme = AppTheme.defaultTheme;

    List<Widget> characters = [];
    switch (token.type) {
      case TokenType.comment:
        {
          characters.addAll(getColoredCharacters(token.literal.toString(),
              theme.codeCommentTextStyle, controller, line));
          break;
        }
      case TokenType.quote:
        {
          characters.addAll(getColoredCharacters(
              "'", theme.codeStringTextStyle, controller, line));
          break;
        }
      case TokenType.doubleQuote:
        {
          characters.addAll(getColoredCharacters(
              '"', theme.codeStringTextStyle, controller, line));
          break;
        }
      case TokenType.string:
        {
          characters.addAll(getColoredCharacters(token.literal.toString(),
              AppTheme.defaultTheme.codeStringTextStyle, controller, line));
        }

      case TokenType.identifier:
        {
          if (token.literal == "#") {
            characters.addAll(getColoredCharacters(token.lexeme,
                AppTheme.defaultTheme.codeVariableTextStyle, controller, line));
            break;
          }
          if (currentIndex > 0) {
            if (detectGenericType(tokens, currentIndex)) {
              characters.addAll(
                getColoredCharacters(
                    token.lexeme,
                    AppTheme.defaultTheme.codeGenericTypeTextStyle,
                    controller,
                    line),
              );
              break;
            }
          }
          if (nextCodeToken(tokens, currentIndex).type == TokenType.leftParen) {
            characters.addAll(getColoredCharacters(token.lexeme,
                AppTheme.defaultTheme.codeFunctionTextStyle, controller, line));
            break;
          } else if (startsWithUpperCase(token.lexeme)) {
            characters.addAll(getColoredCharacters(
                token.lexeme,
                AppTheme.defaultTheme.codeIdentifierTextStyle,
                controller,
                line));
            break;
          } else {
            characters.addAll(getColoredCharacters(token.lexeme,
                AppTheme.defaultTheme.codeVariableTextStyle, controller, line));
            break;
          }
        }

      case TokenType.keyWord:
        {
          characters.addAll(getColoredCharacters(token.lexeme,
              AppTheme.defaultTheme.codeKeywordTextStyle, controller, line));
          break;
        }

      default:
        characters.addAll(getColoredCharacters(token.lexeme,
            AppTheme.defaultTheme.codeCommonWordTextStyle, controller, line));
        break;
    }

    return characters;
  }

  List<Widget> getColoredCharacters(String text, TextStyle style,
      CodeEditingController controller, int line) {
    List<Widget> characters = [];

    for (int i = 0; i < text.length; i++) {
      characters.add(EditableHighlightField(
          controller: controller,
          text: text[i],
          line: line,
          column: column - 1,
          child: Text(text[i], style: style)));
      column++;
    }

    return characters;
  }

  bool startsWithUpperCase(String str) {
    if (str.isEmpty) return false;
    return str[0] == str[0].toUpperCase();
  }

  Token nextCodeToken(List<Token> tokens, int currentIndex) {
    int nextIndex = currentIndex + 1;
    while (nextIndex < tokens.length &&
        tokens[nextIndex].type == TokenType.whiteSpace) {
      nextIndex++;
    }

    if (nextIndex < tokens.length) {
      return tokens[nextIndex];
    } else {
      return Token(TokenType.unknown, '', null, 0);
    }
  }

  Token previousCodeToken(List<Token> tokens, int currentIndex) {
    int nextIndex = currentIndex - 1;
    while (nextIndex < tokens.length &&
        tokens[nextIndex].type == TokenType.whiteSpace) {
      nextIndex--;
    }

    if (nextIndex < tokens.length) {
      return tokens[nextIndex];
    } else {
      return Token(TokenType.unknown, '', null, 0);
    }
  }

  bool detectGenericType(List<Token> tokens, int tokenIndex) {
    return previousCodeToken(tokens, tokenIndex).type == TokenType.less &&
        nextCodeToken(tokens, tokenIndex).type == TokenType.greater;
  }
}
