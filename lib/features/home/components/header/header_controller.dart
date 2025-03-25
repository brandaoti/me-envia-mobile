import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import 'package:maria_me_envia/core/core.dart';

import 'header_states/header_states.dart';
import 'header_states/quotation_states.dart';

abstract class HeaderController {
  Stream<int> get currentIndexPage;
  Stream<HeaderStates> get headerStatesChanged;
  Stream<QuotationState> get quotationStateStream;

  void navigateToMariaTipsScreen();
  void onChangeStepsIndex(int index);

  void init();
  void dispose();
}

class HeaderControllerImpl implements HeaderController {
  final GeneralInformationRepository repository;

  HeaderControllerImpl({
    required this.repository,
  });

  final _stepsIndexSubject = BehaviorSubject<int>.seeded(0);

  final _hearderStatesSubject = BehaviorSubject<HeaderStates>.seeded(
    const HeaderLoadingState(),
  );

  final _quotationStateSubject = BehaviorSubject<QuotationState>.seeded(
    QuotationLoadingState(),
  );

  @override
  Stream<int> get currentIndexPage => _stepsIndexSubject.stream.distinct();

  @override
  Stream<HeaderStates> get headerStatesChanged =>
      _hearderStatesSubject.stream.distinct();

  @override
  Stream<QuotationState> get quotationStateStream =>
      _quotationStateSubject.stream.distinct();

  @override
  Future<void> init() async {
    await loadMariaTipList();
    await loadDollarQuotation();
  }

  @override
  void onChangeStepsIndex(int index) {
    if (!_stepsIndexSubject.isClosed) {
      _stepsIndexSubject.add(index);
    }
  }

  void onChangeHeaderState(HeaderStates newState) {
    if (!_hearderStatesSubject.isClosed) {
      _hearderStatesSubject.add(newState);
    }
  }

  void onChangeQuotationState(QuotationState newState) {
    if (!_quotationStateSubject.isClosed) {
      _quotationStateSubject.add(newState);
    }
  }

  Future<void> loadDollarQuotation() async {
    onChangeQuotationState(QuotationLoadingState());

    try {
      final quotation = await repository.getQuotation();
      onChangeQuotationState(QuotationSucessState(
        quotation: quotation,
      ));
    } on ApiClientError catch (e) {
      onChangeQuotationState(QuotationErrorState(
        message: e.message ?? '',
      ));
    }
  }

  Future<void> loadMariaTipList() async {
    onChangeHeaderState(const HeaderLoadingState());

    try {
      final tips = await repository.getMariaTips();
      onChangeHeaderState(HeaderSucessState(
        tips: tips,
      ));
    } on ApiClientError catch (e) {
      onChangeHeaderState(HeaderErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void dispose() {
    _stepsIndexSubject.close();
    _hearderStatesSubject.close();
    _quotationStateSubject.close();
  }

  @override
  void navigateToMariaTipsScreen() {
    Modular.to.pushNamed(RoutesName.mariaTips.linkNavigate);
  }
}
