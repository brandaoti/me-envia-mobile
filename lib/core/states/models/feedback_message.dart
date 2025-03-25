import 'package:flutter/widgets.dart';

import '../../core.dart';

class FeedbackMessage {
  final String message;
  final bool showFeedback;
  final Color backgroundColor;

  const FeedbackMessage({
    this.message = '',
    this.showFeedback = false,
    this.backgroundColor = AppColors.alertGreenColor,
  });

  factory FeedbackMessage.fromEmpty(bool visible) {
    return FeedbackMessage(
      showFeedback: visible,
      backgroundColor: AppColors.secondary,
      message: Strings.feedbackButtonBoxListEmpty,
    );
  }

  factory FeedbackMessage.fromCreatePackage(bool visible) {
    return FeedbackMessage(
      showFeedback: visible,
      backgroundColor: AppColors.alertGreenColor,
      message: Strings.feedbackButtonCreatePackage,
    );
  }
}
