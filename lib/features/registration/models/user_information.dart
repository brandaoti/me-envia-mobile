import 'package:cubos_extensions/cubos_extensions.dart';

class UserInformation {
  String? name;
  String? email;
  String? cpf;
  String? phone;
  String? password;

  UserInformation({
    this.name,
    this.email,
    this.cpf,
    this.phone,
    this.password,
  });

  bool get notContaisInformation {
    return (name ?? '').isEmpty &&
        (email ?? '').isEmpty &&
        (cpf ?? '').isEmpty &&
        (phone ?? '').isEmpty &&
        (password ?? '').isEmpty;
  }

  UserInformation copyWith({
    String? name,
    String? email,
    String? cpf,
    String? phone,
    String? password,
  }) {
    return UserInformation(
      name: name ?? this.name,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  UserInformation cleanMaskValues() {
    return UserInformation(
      name: name,
      email: email,
      password: password,
      cpf: cpf?.cleanCpf ?? '',
      phone: phone?.cleanPhone ?? '',
    );
  }

  @override
  String toString() {
    return 'UserInformation(name: $name, email: $email, cpf: $cpf, phone: $phone, password: $password)';
  }
}
