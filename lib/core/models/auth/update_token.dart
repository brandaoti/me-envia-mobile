class UpdateToken {
  final String? token;

  const UpdateToken({
    required this.token,
  });

  Map toMap() {
    return {
      'token': token,
    };
  }

  Map toApi() {
    Map data = {};

    if (contaisData(token)) {
      data['token'] = token;
    }

    return data;
  }

  bool contaisData(String? value) {
    return value != null && value.isNotEmpty;
  }

  @override
  String toString() {
    return 'UpdateToken(token: $token)';
  }
}
