import '../../../core.dart';

abstract class LoadStatusState {}

class LoadStatusLoadingState implements LoadStatusState {}

class LoadStatusSucessState implements LoadStatusState {
  final PackageStatusHistory statusHistory;

  const LoadStatusSucessState({
    required this.statusHistory,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadStatusSucessState &&
        other.statusHistory == statusHistory;
  }

  @override
  int get hashCode => statusHistory.hashCode;

  @override
  String toString() => 'LoadStatusSucessState(statusHistory: $statusHistory)';
}

class LoadStatusErrorState implements LoadStatusState {
  final String message;
  const LoadStatusErrorState({
    required this.message,
  });
}
