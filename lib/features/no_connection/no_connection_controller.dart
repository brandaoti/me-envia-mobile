import 'package:maria_me_envia/features/features.dart';
import 'package:rxdart/rxdart.dart';

abstract class NoConnectionController {
  Stream<bool> get isLoading;

  void handleCheckConnection();
  void dispose();
}

class NoConnectionControllerImpl implements NoConnectionController {
  final SplashController splashController;

  NoConnectionControllerImpl({
    required this.splashController,
  });

  final _isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  @override
  Stream<bool> get isLoading => _isLoadingSubject.stream.distinct();

  void onChangeIsLoading(bool value) {
    if (!_isLoadingSubject.isClosed) {
      _isLoadingSubject.add(value);
    }
  }

  @override
  void handleCheckConnection() async {
    onChangeIsLoading(true);

    if (await splashController.isConnected) {
      await splashController.loadFirstTimeBoardingTheApp();
    }

    onChangeIsLoading(false);
  }

  @override
  void dispose() {
    _isLoadingSubject.close();
  }
}
