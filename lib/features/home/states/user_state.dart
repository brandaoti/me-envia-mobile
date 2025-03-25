abstract class UserState {}

class UserLoadingState implements UserState {}

class UserSucessState implements UserState {
  final String name;

  const UserSucessState({
    required this.name,
  });

  String get getAbbreviationName {
    final names = name.split(' ');

    if (names.length >= 2) {
      return '${names.first} ${names[1]}';
    }

    return name;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserSucessState && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class UserErrorState implements UserState {
  final String message;

  const UserErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
