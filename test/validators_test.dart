import 'package:maria_me_envia/core/helpers/helpers.dart';
import 'package:maria_me_envia/core/values/strings.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Validators.email', () {
    test('example@example.com should return success', () {
      const email = 'example@example.com';
      final actual = Validators.email(email);
      const matcher = null;

      expect(actual, matcher);
    });

    test('example@example.com.br should return success', () {
      const email = 'example@example.com.br';
      final actual = Validators.email(email);
      const matcher = null;

      expect(actual, matcher);
    });

    test('example-any_other.name@gmail.io should return success', () {
      const email = 'example-any_other.name@gmail.com';
      final actual = Validators.email(email);
      const matcher = null;

      expect(actual, matcher);
    });

    test('example@example should return Invalid Email', () {
      const email = 'example@example';
      final actual = Validators.email(email);
      const matcher = Strings.errorEmailInvalid;

      expect(actual, matcher);
    });

    test('Empty string should return Empty Email', () {
      const email = '';
      final actual = Validators.email(email);
      const matcher = Strings.errorEmailEmpty;

      expect(actual, matcher);
    });
  });

  group('Validators.password', () {
    test('Empty string should return Empty Password', () {
      const password = ' ';
      final actual = Validators.password(password);
      const matcher = Strings.errorPasswordEmpty;

      expect(actual, matcher);
    });

    test('Non empty String should return success', () {
      const password = 'abc123';
      final actual = Validators.password(password);
      const matcher = null;

      expect(actual, matcher);
    });
  });
}
