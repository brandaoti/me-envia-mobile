import 'package:rxdart/rxdart.dart';

import '../models/models.dart';
import 'models/feedback_message.dart';

abstract class CardController {
  bool get hasItemSelected;
  Stream<BoxList> get cardList;
  Stream<bool> get isSelectedBox;
  Stream<FeedbackMessage> get showFeedbackMessageStream;

  void add(Box box);
  void remove(String id);

  void clearList();
  void addAll(BoxList boxList);

  void toggleCreatingBox(bool value);
  void toggleToDefaultFeedbackMessage();
  void onChangeFeedbackMessage(FeedbackMessage value);

  void showFeedbackMessageToListEmpty();
  void showFeedbackMessageToAddItem(bool visible);

  BoxList getCurrentBoxList();

  void resetToInitialState();
  void dispose();
}

class CardControllerImpl implements CardController {
  BoxList _cachedBoxList = [];

  final _boxListSubject = BehaviorSubject<BoxList>.seeded(
    [],
  );

  final _isSelectedSubject = BehaviorSubject<bool>.seeded(
    false,
  );

  final _feedbackMessageSubject = BehaviorSubject<FeedbackMessage>.seeded(
    const FeedbackMessage(),
  );

  @override
  Stream<BoxList> get cardList => _boxListSubject.stream.distinct();

  @override
  Stream<bool> get isSelectedBox => _isSelectedSubject.stream.distinct();

  @override
  Stream<FeedbackMessage> get showFeedbackMessageStream =>
      _feedbackMessageSubject.stream.distinct();

  @override
  bool get hasItemSelected => _cachedBoxList.isNotEmpty;

  @override
  void showFeedbackMessageToAddItem(bool visible) async {
    onChangeFeedbackMessage(FeedbackMessage.fromCreatePackage(
      visible,
    ));
  }

  @override
  void showFeedbackMessageToListEmpty() async {
    onChangeFeedbackMessage(FeedbackMessage.fromEmpty(true));
  }

  @override
  void resetToInitialState() {
    _cachedBoxList = [];
    onChangedCardList([]);
    toggleCreatingBox(false);
    toggleToDefaultFeedbackMessage();
  }

  void onChangedCardList(BoxList newState) {
    if (!_boxListSubject.isClosed) {
      _boxListSubject.add(newState);
    }
  }

  @override
  void toggleCreatingBox(bool value) {
    if (!_isSelectedSubject.isClosed) {
      _isSelectedSubject.add(value);
    }
  }

  @override
  void toggleToDefaultFeedbackMessage() {
    onChangeFeedbackMessage(const FeedbackMessage());
  }

  @override
  void onChangeFeedbackMessage(FeedbackMessage value) {
    if (!_feedbackMessageSubject.isClosed) {
      _feedbackMessageSubject.add(value);
    }
  }

  @override
  void add(Box box) {
    if (_cachedBoxList.contains(box)) {
      remove(box.id);
    } else {
      _cachedBoxList.add(box);
      onChangedCardList(_cachedBoxList.toList());
      showFeedbackMessageToAddItem(true);
    }
  }

  @override
  void addAll(BoxList boxList) {
    if (_cachedBoxList.length == boxList.length) {
      clearList();
      showFeedbackMessageToListEmpty();
      return;
    }

    _cachedBoxList.clear();
    _cachedBoxList.addAll(boxList);

    onChangedCardList(_cachedBoxList.toList());
    showFeedbackMessageToAddItem(true);
  }

  @override
  void remove(String id) {
    _cachedBoxList.removeWhere((box) => box.id.compareTo(id) == 0);
    onChangedCardList(_cachedBoxList.toList());

    if (_boxListSubject.valueOrNull?.isEmpty ?? false) {
      showFeedbackMessageToListEmpty();
    }
  }

  @override
  void clearList() {
    _cachedBoxList = [];
    onChangedCardList([]);
    toggleToDefaultFeedbackMessage();
  }

  @override
  BoxList getCurrentBoxList() {
    return _cachedBoxList;
  }

  @override
  void dispose() {
    _boxListSubject.close();
    _isSelectedSubject.close();
    _feedbackMessageSubject.close();
  }
}
