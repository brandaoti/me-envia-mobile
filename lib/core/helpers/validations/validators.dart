// ignore_for_file: constant_identifier_names

import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:cubos_extensions/cubos_extensions.dart';
import 'package:maria_me_envia/core/values/regexs.dart';

import '../../values/strings.dart';

abstract class Validators {
  static const int MAX_PHONENUMBER_LENGTH = 11;
  static const int MAX_ZIPCODENUMBER_LENGTH = 9;
  static const int MAX_PHONENUMBER_LENGTH_WITH_MASK = 15;

  /// Returns null if [value] is not null or blank.
  ///
  /// Returns an error String otherwise.
  static String? required(String? value) {
    if (value.isNullOrBlank) {
      return Strings.errorEmptyField;
    } else {
      return null;
    }
  }

  /// Returns if [email] follows the example@example.example pattern.
  ///
  /// Returns an error String if the pattern is invalid or the [email] is null or blank.
  static String? email(String? email) {
    if (email.isNullOrBlank) {
      return Strings.errorEmailEmpty;
    } else {
      final isValid = RegExps.email.hasMatch(email!);
      return isValid ? null : Strings.errorEmailInvalid;
    }
  }

  /// Returns null if [password] is not null or blank.
  ///
  /// Returns an error String otherwise.
  static String? password(String? password) {
    if (password.isNullOrBlank) {
      return Strings.errorPasswordEmpty;
    } else {
      final bool isValid = password!.length >= 6;
      return isValid ? null : Strings.errorPasswordTooShort;
    }
  }

  /// Returns null if [confirmPassword] is not null or blank or not equals.
  ///
  /// Returns an error String otherwise.
  static String? confirmPassword(String? newPassword, String? retryPassword) {
    final errorPassword = password(newPassword);
    final errorConfirmPassword = password(retryPassword);

    if (errorPassword != null) {
      return errorPassword;
    } else if (errorConfirmPassword != null) {
      return errorConfirmPassword;
    } else {
      final isEquals = newPassword!.compareTo(retryPassword!) == 0;
      return isEquals ? null : Strings.errorConfirmPassword;
    }
  }

  /// Returns null if [name] is not null or blank.
  ///
  /// Returns an error String otherwise.
  static String? name(String? name) {
    if (name.isNullOrBlank) {
      return Strings.errorEmptyField;
    }
    return null;
  }

  /// Returns null if [cpf] follows the example 999.999.999-99 pattern.
  ///
  /// Returns an error String if the pattern is invalid or the [cpf] is null or blank.
  static String? cpf(String? cpf) {
    if (cpf.isNullOrBlank) {
      return Strings.errorEmptyField;
    } else {
      return CPF.isValid(cpf) ? null : Strings.errorCpfInvalid;
    }
  }

  /// Returns null if [phone] follows the example (99) 9999-999 pattern.
  ///
  /// Returns an error String if the pattern is invalid or the [cpf] is null or blank.
  static String? phone(String? phone) {
    if (phone.isNullOrBlank) {
      return Strings.errorEmptyField;
    } else if (phone!.length < MAX_PHONENUMBER_LENGTH_WITH_MASK) {
      return Strings.errorPhoneInvalid;
    } else {
      final areaCodeNumber = int.parse(phone.cleanPhone.substring(0, 2));
      return areaCodeNumber < MAX_PHONENUMBER_LENGTH
          ? Strings.errorDDDInvalid
          : null;
    }
  }

  /// Returns if [currentPhone] is newPhone.length is greater than 11.
  /// Phone validation without mask
  /// Returns an currentPhone otherwise.
  static String? isValidPhone(
    String newPhone,
    String? currentPhone,
  ) {
    final String phone = newPhone.cleanPhone;
    if (phone.length <= MAX_PHONENUMBER_LENGTH) return newPhone;

    return currentPhone;
  }

  /// Returns if [cep] follows the example 99999-999 pattern.
  ///
  /// Returns an error String if the pattern is invalid or the [cep] is null or blank.
  static String? cep(String? cep) {
    if (cep.isNullOrBlank) {
      return Strings.errorEmptyField;
    } else if (cep!.length < MAX_ZIPCODENUMBER_LENGTH) {
      return Strings.errorCepInvalid;
    } else {
      return null;
    }
  }

  /// Returns if [money] for a valid value.
  ///
  /// Returns an error String if the pattern is invalid or the [money] is null or blank.
  static String? money(double? money) {
    if (money == null) {
      return Strings.errorEmptyField;
    } else {
      return money > 0 ? null : Strings.errorMoneyInvalid;
    }
  }

  /// Returns if [money] for a valid value.
  ///
  /// Returns an error String if the pattern is invalid or the [money] is null or blank.
  static String? quantity(String? quant) {
    if (quant.isNullOrBlank) {
      return Strings.errorEmptyField;
    } else {
      final numberValue = int.parse(quant!);
      return numberValue > 0 ? null : Strings.errorMoneyInvalid;
    }
  }
}
