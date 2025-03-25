import 'package:rxdart/subjects.dart';

import '../../../../core/repositories/repositories.dart';
import '../../core/services/auth_provider.dart';
import '../../core/client/client.dart';
import 'states/maria_tips_state.dart';

abstract class MariaTipsController {
  Stream<MariaTipsState> get mariaTipsStateStream;

  void init();
  void dispose();
  Future<void> handleMariaTips();
}

class MariaTipsControllerImpl implements MariaTipsController {
  final AuthProvider authProvider;
  final GeneralInformationRepository repository;

  MariaTipsControllerImpl({
    required this.repository,
    required this.authProvider,
  });

  final _mariaTipsStateSubject = BehaviorSubject<MariaTipsState>.seeded(
    MariaTipsLoadingState(),
  );

  @override
  Stream<MariaTipsState> get mariaTipsStateStream =>
      _mariaTipsStateSubject.stream.distinct();

  @override
  void init() async {
    await handleMariaTips();
  }

  void onChangeMariaTipsState(MariaTipsState newState) {
    if (!_mariaTipsStateSubject.isClosed) {
      _mariaTipsStateSubject.add(newState);
    }
  }

  @override
  Future<void> handleMariaTips() async {
    onChangeMariaTipsState(MariaTipsLoadingState());

    try {
      final result = await repository.getMariaTips();
      onChangeMariaTipsState(MariaTipsSucessState(
        tips: result,
      ));
    } on ApiClientError catch (e) {
      onChangeMariaTipsState(MariaTipsErrorState(message: e.message ?? ''));
    }
  }

  @override
  void dispose() {
    _mariaTipsStateSubject.close();
  }
}
