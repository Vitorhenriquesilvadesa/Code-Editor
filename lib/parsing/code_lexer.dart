class Lexer {
  late String source;
  int start = 0;
  int current = 0;
  int line = 1;
  final List<Token> tokens = [];

  final Map<String, TokenType> keywords = {
    'abstract': TokenType.keyWord,
    'assert': TokenType.keyWord,
    'boolean': TokenType.keyWord,
    'break': TokenType.keyWord,
    'byte': TokenType.keyWord,
    'case': TokenType.keyWord,
    'catch': TokenType.keyWord,
    'char': TokenType.keyWord,
    'class': TokenType.keyWord,
    'const': TokenType.keyWord,
    'continue': TokenType.keyWord,
    'default': TokenType.keyWord,
    'do': TokenType.keyWord,
    'double': TokenType.keyWord,
    'else': TokenType.keyWord,
    'enum': TokenType.keyWord,
    'extends': TokenType.keyWord,
    'final': TokenType.keyWord,
    'finally': TokenType.keyWord,
    'float': TokenType.keyWord,
    'for': TokenType.keyWord,
    'if': TokenType.keyWord,
    'implements': TokenType.keyWord,
    'import': TokenType.keyWord,
    'instanceof': TokenType.keyWord,
    'int': TokenType.keyWord,
    'interface': TokenType.keyWord,
    'long': TokenType.keyWord,
    'native': TokenType.keyWord,
    'new': TokenType.keyWord,
    'null': TokenType.keyWord,
    'package': TokenType.keyWord,
    'private': TokenType.keyWord,
    'protected': TokenType.keyWord,
    'public': TokenType.keyWord,
    'return': TokenType.keyWord,
    'short': TokenType.keyWord,
    'static': TokenType.keyWord,
    'strictfp': TokenType.keyWord,
    'super': TokenType.keyWord,
    'switch': TokenType.keyWord,
    'synchronized': TokenType.keyWord,
    'this': TokenType.keyWord,
    'throw': TokenType.keyWord,
    'throws': TokenType.keyWord,
    'transient': TokenType.keyWord,
    'true': TokenType.keyWord,
    'try': TokenType.keyWord,
    'void': TokenType.keyWord,
    'volatile': TokenType.keyWord,
    'while': TokenType.keyWord,
  };

  late List<String> stringDelimiter;
  bool isSupported = true;

  Lexer();

  List<Token> scanTokens(String source) {
    this.source = source;
    while (!isAtEnd()) {
      start = current;
      scanToken();
    }

    tokens.add(Token(TokenType.eof, '', null, line));
    return tokens;
  }

  bool isAtEnd() {
    return current >= source.length;
  }

  void scanToken() {
    final c = advance();
    switch (c) {
      case '(':
        addToken(TokenType.leftParen);
        break;
      case ')':
        addToken(TokenType.rightParen);
        break;
      case '{':
        addToken(TokenType.leftBrace);
        break;
      case '}':
        addToken(TokenType.rightBrace);
        break;
      case '[':
        addToken(TokenType.leftBracket);
        break;
      case ']':
        addToken(TokenType.rightBracket);
        break;
      case ',':
        addToken(TokenType.comma);
        break;
      case '.':
        addToken(TokenType.dot);
        break;
      case '-':
        addToken(TokenType.minus);
        break;
      case '+':
        addToken(TokenType.plus);
        break;
      case ';':
        addToken(TokenType.semicolon);
        break;
      case '*':
        addToken(TokenType.star);
        break;
      case ':':
        addToken(TokenType.star);
        break;
      case '!':
        addToken(match('=') ? TokenType.bangEqual : TokenType.bang);
        break;
      case '=':
        addToken(match('=') ? TokenType.equalEqual : TokenType.equal);
        break;
      case '<':
        addToken(match('=') ? TokenType.lessEqual : TokenType.less);
        break;
      case '>':
        addToken(match('=') ? TokenType.greaterEqual : TokenType.greater);
        break;
      case ':':
        addToken(match(':') ? TokenType.doubleColon : TokenType.colon);
        break;
      case '?':
        addToken(match('?') ? TokenType.doubleQuestion : TokenType.question);
        break;
      case '/':
        if (match('/')) {
          // A comment goes until the end of the line.
          comment();
        } else if (match('*')) {
          multilineComment();
        } else {
          addToken(TokenType.slash);
        }
        break;
      case ' ':
        addToken(TokenType.whiteSpace);
        break;
      case '\r':
        break;
      case '\t':
        addToken(TokenType.tab);
        break;
      case '\n':
        addToken(TokenType.newLine);
        line++;
        break;
      case "'":
        quoteString();
        break;
      case '"':
        doubleQuoteString();
        break;
      case '|':
        if (match('|')) {
          addToken(TokenType.or);
        }
        break;
      case '&':
        if (match('&')) {
          addToken(TokenType.and);
        }
        break;
      case '@':
        addToken(TokenType.identifier);
        break;
      case '#':
        addToken(TokenType.identifier, '#');
        break;
      default:
        if (isDigit(c)) {
          number();
        } else if (isAlpha(c)) {
          identifier();
        } else {
          addToken(TokenType.identifier, source.substring(start, current));
        }
        break;
    }
  }

  void identifier() {
    while (isAlphaNumeric(peek())) {
      advance();
    }
    final text = source.substring(start, current);
    final type = keywords[text] ?? TokenType.identifier;
    addToken(type, text);
  }

  bool isAlpha(String c) {
    return RegExp(r'[a-zA-Z_]').hasMatch(c);
  }

  bool isAlphaNumeric(String c) {
    return isAlpha(c) || isDigit(c);
  }

  void comment() {
    while (peek() != '\n' && !isAtEnd()) {
      advance();
    }

    addToken(TokenType.comment, source.substring(start, current));
  }

  void quoteString() {
    addToken(TokenType.quote);

    while (peek() != "'" && !isAtEnd()) {
      if (peek() == '\n') line++;
      advance();
    }

    if (isAtEnd()) {
      throw Exception("Unterminated string.");
    }

    advance();

    final value = source.substring(start + 1, current - 1);
    addToken(TokenType.string, value);
    addToken(TokenType.quote);
  }

  void doubleQuoteString() {
    addToken(TokenType.doubleQuote);

    while (peek() != '"' && !isAtEnd()) {
      if (peek() == '\n') line++;
      advance();
    }

    if (isAtEnd()) {
      throw Exception("Unterminated string.");
    }

    advance();

    final value = source.substring(start + 1, current - 1);
    addToken(TokenType.string, value);
    addToken(TokenType.doubleQuote);
  }

  String advance() {
    return source[current++];
  }

  void addToken(TokenType type, [Object? literal]) {
    final text = source.substring(start, current);
    tokens.add(Token(type, text, literal, line));
  }

  bool match(String expected) {
    if (isAtEnd()) return false;
    if (source[current] != expected) return false;

    current++;
    return true;
  }

  String peek() {
    if (isAtEnd()) return '0';
    return source[current];
  }

  bool isDigit(String c) {
    return RegExp(r'[0-9]').hasMatch(c);
  }

  void number() {
    if (peek() == '0' && (peekNext() == 'x' || peekNext() == 'X')) {
      advance(); // Avança para '0'
      advance(); // Avança para 'x' ou 'X'

      // Continua avançando enquanto for um dígito hexadecimal ou '_'
      while (isHexDigit(peek()) || peek() == '_') {
        advance();
      }
    } else {
      while (isDigit(peek()) || peek() == '_') {
        advance();
      }
      if (peek() == '.' && isDigit(peekNext())) {
        advance();
        while (isDigit(peek())) {
          advance();
        }
      }
    }

    final numberString = source.substring(start, current).replaceAll('_', '');
    final value = num.tryParse(numberString);

    addToken(TokenType.number, value);
  }

  bool isHexDigit(String c) {
    return RegExp(r'[0-9a-fA-F]').hasMatch(c);
  }

  String peekNext() {
    if (current + 1 >= source.length) return '0';
    return source[current + 1];
  }

  void multilineComment() {
    while (!(peek() == '*' && peekNext() == '/')) {
      advance();
      if (peek() == '\n') {
        addToken(TokenType.comment, source.substring(start, current));
        addToken(TokenType.newLine);
        start = current;
      }
    }
    advance();
    advance();

    addToken(TokenType.comment, "*/");
  }
}

enum TokenType {
  // Single-character tokens.
  leftParen,
  rightParen,
  leftBrace,
  rightBrace,
  leftBracket,
  rightBracket,
  question,
  doubleQuestion,
  comma,
  dot,
  minus,
  plus,
  colon,
  doubleColon,
  semicolon,
  slash,
  star,

  // One or two character tokens.
  bang,
  bangEqual,
  equal,
  equalEqual,
  greater,
  greaterEqual,
  less,
  lessEqual,

  // Literals.
  identifier,
  string,
  number,

  // Keywords.
  and,
  classToken,
  elseToken,
  falseToken,
  def,
  forToken,
  ifToken,
  nullToken,
  or,
  breakToken,
  continueToken,
  printToken,
  returnToken,
  superToken,
  thisToken,
  trueToken,
  varToken,
  whileToken,
  namespace,
  whiteSpace,
  tab,
  newLine,
  keyWord,
  eof,
  unknown,
  quote,
  doubleQuote,
  comment
}

class Token {
  final TokenType type;
  final String lexeme;
  final Object? literal;
  final int line;

  Token(this.type, this.lexeme, this.literal, this.line);

  @override
  String toString() {
    return '$type $lexeme $literal';
  }
}
