import 'package:maria_me_envia/core/models/models.dart';

abstract class MariaTipsState {}

class MariaTipsLoadingState implements MariaTipsState {}

class MariaTipsSucessState implements MariaTipsState {
  final MariaTipsList tips;
  const MariaTipsSucessState({
    required this.tips,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MariaTipsSucessState && other.tips == tips;
  }

  @override
  int get hashCode => tips.hashCode;

  @override
  String toString() => 'MariaTipsSucessState(tips: $tips)';
}

class MariaTipsErrorState implements MariaTipsState {
  final String message;

  const MariaTipsErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MariaTipsErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
