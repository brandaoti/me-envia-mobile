import 'package:rxdart/rxdart.dart';

abstract class TabBarController {
  Stream<int> get currentTabIndex;

  void onChangeCurrentIndex(int page);
  void dispose();
}

class TabBarControllerImpl implements TabBarController {
  final _currentTabIndexSubject = BehaviorSubject<int>.seeded(0);

  @override
  Stream<int> get currentTabIndex => _currentTabIndexSubject.stream.distinct();

  @override
  void onChangeCurrentIndex(int page) {
    if (!_currentTabIndexSubject.isClosed) {
      _currentTabIndexSubject.add(page);
    }
  }

  @override
  void dispose() {
    _currentTabIndexSubject.close();
  }
}
