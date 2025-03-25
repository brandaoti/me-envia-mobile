import '../../../core/models/models.dart';

abstract class RecipientUserState {}

class RecipientUserLoadingState implements RecipientUserState {}

class RecipientUserSucessState implements RecipientUserState {
  final User? user;

  RecipientUserSucessState({
    required this.user,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecipientUserSucessState && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class RecipientUserErrorState implements RecipientUserState {
  final String message;

  const RecipientUserErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecipientUserErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
