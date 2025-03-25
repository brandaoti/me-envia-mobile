import '../../types/types.dart';
import '../models.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String cpf;
  final UserType type;
  final Address address;
  final String phoneNumber;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.cpf,
    required this.type,
    required this.address,
    required this.phoneNumber,
  });

  factory User.fromJson(Map json) {
    return User(
      id: json['id'],
      cpf: json['cpf'],
      name: json['name'],
      email: json['email'],
      address: Address.fromJson(json),
      phoneNumber: json['phoneNumber'],
      type: (json['type'] as String).fromJson,
    );
  }

  factory User.fromInternalData(Map json) {
    return User(
      id: json['id'],
      cpf: json['cpf'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      type: (json['type'] as String).fromJson,
      address: Address.fromJson(json['address']),
    );
  }

  Map toMap() {
    return {
      'id': id,
      'cpf': cpf,
      'name': name,
      'email': email,
      'type': type.value,
      'phoneNumber': phoneNumber,
      'address': address.toMap(),
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? cpf,
    UserType? type,
    Address? address,
    String? phoneNumber,
  }) {
    return User(
      id: id ?? this.id,
      cpf: cpf ?? this.cpf,
      name: name ?? this.name,
      type: type ?? this.type,
      email: email ?? this.email,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  User copyWithByAddress({
    required Address address,
  }) {
    return User(
      id: id,
      cpf: cpf,
      type: type,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      address: Address(
        city: address.city.isEmpty ? this.address.city : address.city,
        state: address.state.isEmpty ? this.address.state : address.state,
        street: address.street.isEmpty ? this.address.street : address.street,
        country:
            address.country.isEmpty ? this.address.country : address.country,
        zipcode:
            address.zipcode.isEmpty ? this.address.zipcode : address.zipcode,
        district:
            address.district.isEmpty ? this.address.district : address.district,
        complement: address.complement.isEmpty
            ? this.address.complement
            : address.complement,
        houseNumber: address.houseNumber.isEmpty
            ? this.address.houseNumber
            : address.houseNumber,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.cpf == cpf &&
        other.type == type &&
        other.address == address &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        cpf.hashCode ^
        type.hashCode ^
        address.hashCode ^
        phoneNumber.hashCode;
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, cpf: $cpf, type: $type, address: $address, phoneNumber: $phoneNumber)';
  }
}
