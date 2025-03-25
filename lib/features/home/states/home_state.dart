import 'package:flutter/foundation.dart';

import '../../../core/core.dart';

abstract class HomeState {}

class HomeEmptyState implements HomeState {
  const HomeEmptyState();
}

class HomeLoadingState implements HomeState {
  const HomeLoadingState();
}

class HomeSucessState implements HomeState {
  final PackageList packages;

  const HomeSucessState({
    required this.packages,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeSucessState && listEquals(other.packages, packages);
  }

  @override
  int get hashCode => packages.hashCode;
}

class HomeErrorState implements HomeState {
  final String message;

  const HomeErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
