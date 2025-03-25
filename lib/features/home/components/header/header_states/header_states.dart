import '../../../../../core/models/models.dart';

abstract class HeaderStates {}

class HeaderLoadingState implements HeaderStates {
  const HeaderLoadingState();
}

class HeaderSucessState implements HeaderStates {
  final MariaTipsList tips;

  const HeaderSucessState({
    required this.tips,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HeaderSucessState && other.tips == tips;
  }

  @override
  int get hashCode => tips.hashCode;

  @override
  String toString() => 'HeaderSucessState(tips: $tips)';
}

class HeaderErrorState implements HeaderStates {
  final String message;
  const HeaderErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HeaderErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
