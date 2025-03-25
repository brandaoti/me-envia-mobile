// ignore_for_file: prefer_adjacent_string_concatenation,
// ignore_for_file: unnecessary_string_escapes

abstract class RegExps {
  static RegExp get email => RegExp(
        '[a-zA-Z0-9\+\.\_\%\-\+]{1,256}' +
            '\\@' +
            '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}' +
            '(' +
            '\\.' +
            '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}' +
            ')+',
      );
}
