import 'package:maria_me_envia/core/models/models.dart';

abstract class RequestedBoxState {}

class RequestedBoxLoadingState implements RequestedBoxState {}

class RequestedBoxSucessState implements RequestedBoxState {
  final PackageList pack;

  const RequestedBoxSucessState({
    required this.pack,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestedBoxSucessState && other.pack == pack;
  }

  @override
  int get hashCode => pack.hashCode;

  @override
  String toString() => 'RequestedBoxSucessState(pack: $pack)';
}

class RequestedBoxErrorState implements RequestedBoxState {
  final String message;

  const RequestedBoxErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestedBoxErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
