import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../core.dart';
import 'states/load_status_history_state.dart';

abstract class CardSendBoxController {
  Stream<bool> get isExpanded;
  Stream<LoadStatusState> get loadStatusState;

  void onExpansionChanged();
  Future<void> loadStatusHistory();

  void navigateToPicturesScreen(BoxList boxList);

  void init(Package package);
  void dispose();
}

class CardSendBoxControllerImpl implements CardSendBoxController {
  final GeneralInformationRepository repository;

  CardSendBoxControllerImpl({
    required this.repository,
  });

  late final String packageId;

  final _isExpandedSubject = BehaviorSubject<bool>.seeded(false);

  final _loadStatusSubject = BehaviorSubject<LoadStatusState>.seeded(
    LoadStatusLoadingState(),
  );

  @override
  Stream<bool> get isExpanded => _isExpandedSubject.stream.distinct();

  @override
  Stream<LoadStatusState> get loadStatusState =>
      _loadStatusSubject.stream.distinct();

  @override
  void init(Package package) {
    packageId = package.id;
  }

  @override
  void onExpansionChanged() {
    if (!_isExpandedSubject.isClosed) {
      final currentValue = _isExpandedSubject.valueOrNull ?? false;
      _isExpandedSubject.add(!currentValue);
    }
  }

  void onChangedLoadStatus(LoadStatusState newState) {
    if (!_loadStatusSubject.isClosed) {
      _loadStatusSubject.add(newState);
    }
  }

  @override
  Future<void> loadStatusHistory() async {
    onChangedLoadStatus(LoadStatusLoadingState());

    try {
      final statusHistory = await repository.getPackageHistory(
        packageId: packageId,
      );
      onChangedLoadStatus(LoadStatusSucessState(
        statusHistory: statusHistory,
      ));
    } on ApiClientError catch (e) {
      onChangedLoadStatus(LoadStatusErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void navigateToPicturesScreen(BoxList boxList) {
    Modular.to.pushNamed(
      RoutesName.pictures.name,
      arguments: boxList.map((it) => it.media).toList(),
    );
  }

  @override
  void dispose() {
    _isExpandedSubject.close();
    _loadStatusSubject.close();
  }
}
