import '../../../core/models/models.dart';

abstract class GeneralInformationState {}

class GeneralInformationLoadingState implements GeneralInformationState {}

class GeneralInformationSucessState implements GeneralInformationState {
  final MariaInformation information;

  const GeneralInformationSucessState({
    required this.information,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeneralInformationSucessState &&
        other.information == information;
  }

  @override
  int get hashCode => information.hashCode;
}

class GeneralInformationErrorState implements GeneralInformationState {
  final String message;

  const GeneralInformationErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeneralInformationErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
