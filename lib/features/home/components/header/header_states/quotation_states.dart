import '../../../../../core/models/models.dart';

abstract class QuotationState {}

class QuotationLoadingState implements QuotationState {}

class QuotationSucessState implements QuotationState {
  final Quotation quotation;

  QuotationSucessState({
    required this.quotation,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuotationSucessState && other.quotation == quotation;
  }

  @override
  int get hashCode => quotation.hashCode;
}

class QuotationErrorState implements QuotationState {
  final String message;

  const QuotationErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuotationErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
