class UpdateUser {
  final String? name;
  final String? phoneNumber;
  final String? password;

  const UpdateUser({
    required this.name,
    required this.phoneNumber,
    required this.password,
  });

  Map toMap() {
    return {
      'name': name,
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }

  Map toApi() {
    Map data = {};

    if (contaisData(name)) {
      data['name'] = name;
    }

    if (contaisData(phoneNumber)) {
      data['phoneNumber'] = phoneNumber;
    }

    if (contaisData(password)) {
      data['password'] = password;
    }

    return data;
  }

  bool contaisData(String? value) {
    return value != null && value.isNotEmpty;
  }

  @override
  String toString() {
    return 'UpdateUser(name: $name, phoneNumber: $phoneNumber, password: $password)';
  }
}
