import '../../../core/models/models.dart';

abstract class FaqState {}

class FaqStateLoadingState implements FaqState {}

class FaqStateSucessState implements FaqState {
  final List<Faq> list;

  const FaqStateSucessState({
    required this.list,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FaqStateSucessState && other.list == list;
  }

  @override
  int get hashCode => list.hashCode;
}

class FaqStateErrorState implements FaqState {
  final String message;

  const FaqStateErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FaqStateErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
