class CreateNewUserResponse {
  final String id;
  final String token;

  const CreateNewUserResponse({
    required this.id,
    required this.token,
  });

  factory CreateNewUserResponse.fromJson(Map json) {
    return CreateNewUserResponse(
      id: json['id'],
      token: json['token'],
    );
  }

  Map toMap() {
    return {
      'id': id,
      'token': token,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateNewUserResponse &&
        other.id == id &&
        other.token == token;
  }

  @override
  int get hashCode => id.hashCode ^ token.hashCode;

  @override
  String toString() => 'CreateNewUserResponse(id: $id, token: $token)';
}
