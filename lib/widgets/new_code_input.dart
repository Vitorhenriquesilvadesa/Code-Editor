import 'package:code_editor/controller/code_editing_controller.dart';
import 'package:code_editor/parsing/code_lexer.dart';
import 'package:code_editor/theme/luna_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCodeInput extends StatelessWidget {
  NewCodeInput({super.key});

  String source = Get.find<CodeEditingController>().activeFileContent.value;

  final Lexer lexer = Lexer();

  late List<Token> tokens;

  @override
  Widget build(BuildContext context) {

    tokens = lexer.scanTokens(source);

    return ListView.builder(
      itemCount: lines.length,
      itemBuilder: (context, index) {
        String line = lines[index];
        tokens = lexer.scanTokens(line);
        return Row(
          children: [
            SizedBox(
              height: AppTheme.defaultTheme.codeFontSize *
                  AppTheme.defaultTheme.codeLineHeight,
              child: RichText(
                selectionColor: Colors.white.withAlpha(20),
                text: TextSpan(children: convertTokensToTextSpan()),
              ),
            ),
          ],
        );
      },
    );
  }

  List<TextSpan> convertTokensToTextSpan() {
    List<TextSpan> spans = [];

    AppTheme theme = AppTheme.defaultTheme;

    for (int i = 0; i < tokens.length; i++) {
      if (tokens[i].type == TokenType.newLine) {
        spans.add(TextSpan(text: '\n', style: theme.codeCommentTextStyle));
      } else {
        switch (tokens[i].type) {
          case TokenType.comment:
            {
              spans.add(TextSpan(
                  mouseCursor: SystemMouseCursors.text,
                  text: tokens[i].literal.toString(),
                  style: theme.codeCommentTextStyle));
              break;
            }
          case TokenType.quote:
            {
              spans.add(TextSpan(
                  mouseCursor: SystemMouseCursors.text,
                  text: "'",
                  style: theme.codeStringTextStyle));
              break;
            }
          case TokenType.doubleQuote:
            {
              spans.add(TextSpan(
                  mouseCursor: SystemMouseCursors.text,
                  text: '"',
                  style: theme.codeStringTextStyle));
              break;
            }
          case TokenType.string:
            {
              spans.add(TextSpan(
                  mouseCursor: SystemMouseCursors.text,
                  text: tokens[i].literal.toString(),
                  style: theme.codeStringTextStyle));
              break;
            }

          case TokenType.identifier:
            {
              if (tokens[i].literal == "#") {
                spans.add(TextSpan(
                    mouseCursor: SystemMouseCursors.text,
                    text: tokens[i].lexeme,
                    style: AppTheme.defaultTheme.codeVariableTextStyle));
                break;
              }
              if (nextCodeToken(tokens, i).type == TokenType.leftParen) {
                spans.add(TextSpan(
                    mouseCursor: SystemMouseCursors.text,
                    text: tokens[i].lexeme,
                    style: AppTheme.defaultTheme.codeFunctionTextStyle));
                break;
              } else if (startsWithUpperCase(tokens[i].lexeme)) {
                spans.add(TextSpan(
                  mouseCursor: SystemMouseCursors.text,
                  text: tokens[i].lexeme,
                  style: AppTheme.defaultTheme.codeIdentifierTextStyle,
                ));
                break;
              } else {
                spans.add(TextSpan(
                    mouseCursor: SystemMouseCursors.text,
                    text: tokens[i].lexeme,
                    style: AppTheme.defaultTheme.codeVariableTextStyle));
                break;
              }
            }

          case TokenType.keyWord:
            {
              spans.add(TextSpan(
                  mouseCursor: SystemMouseCursors.text,
                  text: tokens[i].lexeme,
                  style: AppTheme.defaultTheme.codeKeywordTextStyle));
              break;
            }

          default:
            spans.add(TextSpan(
                mouseCursor: SystemMouseCursors.text,
                text: tokens[i].lexeme,
                style: AppTheme.defaultTheme.codeCommonWordTextStyle));
            break;
        }
      }
    }

    return spans;
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

  bool startsWithUpperCase(String str) {
    if (str.isEmpty) return false;
    return str[0] == str[0].toUpperCase();
  }
}
