import '../../../features/registration/models/models.dart';
import '../address/address.dart';

class CreateNewUser {
  final String name;
  final String email;
  final String cpf;
  final String phone;
  final String password;
  final Address address;

  const CreateNewUser({
    required this.name,
    required this.email,
    required this.cpf,
    required this.phone,
    required this.password,
    required this.address,
  });

  factory CreateNewUser.fromApi(
    UserInformation userInformation,
    AddressInformation addressInformation,
  ) {
    return CreateNewUser(
      cpf: userInformation.cpf ?? '',
      name: userInformation.name ?? '',
      email: userInformation.email ?? '',
      phone: userInformation.phone ?? '',
      password: userInformation.password ?? '',
      address: Address(
        city: addressInformation.city ?? '',
        state: addressInformation.state ?? '',
        street: addressInformation.street ?? '',
        country: addressInformation.country ?? '',
        zipcode: addressInformation.zipcode ?? '',
        district: addressInformation.district ?? '',
        houseNumber: addressInformation.houseNumber ?? '',
        complement: addressInformation.complement ?? '',
      ),
    );
  }

  Map toMap() {
    return {
      'cpf': cpf,
      'name': name,
      'email': email,
      'phoneNumber': phone,
      'password': password,
      'city': address.city,
      'cep': address.zipcode,
      'state': address.state,
      'street': address.street,
      'country': address.country,
      'neighborhood': address.district,
      'houseNumber': address.houseNumber,
      'additionalAddress': address.complement,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateNewUser &&
        other.name == name &&
        other.email == email &&
        other.cpf == cpf &&
        other.phone == phone &&
        other.password == password &&
        other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        cpf.hashCode ^
        phone.hashCode ^
        password.hashCode ^
        address.hashCode;
  }

  @override
  String toString() {
    return 'CreateNewUser(name: $name, email: $email, cpf: $cpf, phone: $phone, password: $password, address: ${address.toString()})';
  }
}
