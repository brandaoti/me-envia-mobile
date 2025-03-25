import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../core/core.dart';
import 'customs_declaration.dart';

abstract class CustomsDeclarationController {
  Stream<double> get totalDeclaredStream;
  Stream<String?> get currentCateryStream;
  Stream<String?> get declarationErrorStream;
  Stream<CreateBoxState> get createBoxStateStream;
  Stream<DeclarationSection> get declarationSectionStream;
  Stream<ItemDeclarationList> get declarationsItemsStream;

  void addItem();
  void updateItem(ItemDeclaration newItem);

  void onChangedCurrentCategory(String? value);
  void onChangedDeclarationSection(DeclarationSection value);
  void onChangedForm(DeclarationFormType form, String? value);

  bool hasDesclarationsItems();
  String? getCurrentCategory();
  List<String> getCategoriesList();

  double calculatedTotalValue();

  void setNewItemDeclaration(ItemDeclaration value);
  void setNumberValue(num value, {bool isQuantity = false});

  void handleFishinCreateDeclarations({
    required Address address,
    required BoxList boxList,
    required bool dropShipping,
  });

  void navigateToHome();

  void dispose();
}

class CustomsDeclarationControllerImpl implements CustomsDeclarationController {
  final CardController cardController;
  final GeneralInformationRepository repository;

  CustomsDeclarationControllerImpl({
    required this.repository,
    required this.cardController,
  });

  final _uuid = const Uuid();
  ItemDeclaration _item = ItemDeclaration();

  final _declarationsSubject = BehaviorSubject<ItemDeclarationList>.seeded(
    [],
  );

  final _declarationErrorSubject = BehaviorSubject<String?>.seeded(null);

  final _currentCategorySubject = BehaviorSubject<String?>.seeded(null);

  final _declarationSectionSubject = BehaviorSubject<DeclarationSection>.seeded(
    DeclarationSection.create,
  );

  final _createBoxStateSubject = BehaviorSubject<CreateBoxState>();

  @override
  Stream<CreateBoxState> get createBoxStateStream =>
      _createBoxStateSubject.stream.distinct();

  @override
  Stream<ItemDeclarationList> get declarationsItemsStream =>
      _declarationsSubject.stream.distinct();

  @override
  Stream<String?> get currentCateryStream =>
      _currentCategorySubject.stream.distinct();

  @override
  Stream<String?> get declarationErrorStream =>
      _declarationErrorSubject.stream.distinct();

  @override
  Stream<DeclarationSection> get declarationSectionStream =>
      _declarationSectionSubject.stream.distinct();

  @override
  Stream<double> get totalDeclaredStream =>
      _declarationsSubject.map<double>(mappingToDeclarations);

  double mappingToDeclarations(ItemDeclarationList list) {
    return list.fold<double>(0.0, ((a, b) => a + (b.totalValue ?? 0)));
  }

  @override
  void addItem() {
    final newItem = ItemDeclaration(
      id: _uuid.v4(),
      category: _item.category,
      quantity: _item.quantity,
      totalValue: _item.totalValue,
      description: _item.description,
      unitaryValue: _item.unitaryValue,
    );

    final list = _declarationsSubject.value;
    onChangeDeclarations([...list, newItem]);

    _item.clean();
  }

  @override
  void onChangedCurrentCategory(String? value) {
    if (!_currentCategorySubject.isClosed) {
      _currentCategorySubject.add(value);
    }
  }

  void onChangeDeclarations(ItemDeclarationList newList) {
    if (!_declarationsSubject.isClosed) {
      _declarationsSubject.add(newList);
    }
  }

  @override
  void updateItem(ItemDeclaration newItem) {
    final list = _declarationsSubject.valueOrNull ?? [];

    final index = list.indexWhere(
      (it) => it.id?.compareTo(newItem.id ?? '') == 0,
    );
    list[index] = newItem.copyWith(
      category: _item.category,
      quantity: _item.quantity,
      totalValue: _item.totalValue,
      description: _item.description,
      unitaryValue: _item.unitaryValue,
    );

    onChangeDeclarations(<ItemDeclaration>[...list]);
  }

  @override
  void onChangedForm(DeclarationFormType form, String? value) {
    switch (form) {
      case DeclarationFormType.category:
        _item.category = value;
        break;
      case DeclarationFormType.description:
        _item.description = value;
        break;
    }
  }

  @override
  void setNewItemDeclaration(ItemDeclaration value) {
    _item = _item.copyWith(
      category: value.category,
      quantity: value.quantity,
      totalValue: value.totalValue,
      description: value.description,
      unitaryValue: value.unitaryValue,
    );
  }

  @override
  void setNumberValue(num value, {bool isQuantity = false}) {
    if (isQuantity) {
      _item.quantity = value as int;
    } else {
      _item.unitaryValue = value as double;
    }
  }

  @override
  void onChangedDeclarationSection(DeclarationSection value) {
    if (!_declarationSectionSubject.isClosed) {
      _declarationSectionSubject.add(value);
    }
  }

  void onChangedDeclarationError(String? newValue) {
    if (!_declarationErrorSubject.isClosed) {
      _declarationErrorSubject.add(newValue);
    }
  }

  @override
  bool hasDesclarationsItems() {
    final list = _declarationsSubject.valueOrNull ?? [];
    final bool hasDesclarationsItems = list.isNotEmpty;

    onChangedDeclarationError(
      hasDesclarationsItems ? null : Strings.errorDeclarationsListEmpty,
    );

    return hasDesclarationsItems;
  }

  @override
  String? getCurrentCategory() {
    return _item.category;
  }

  @override
  List<String> getCategoriesList() {
    return Strings.categoryList;
  }

  @override
  double calculatedTotalValue() {
    if (_item.quantity == null || _item.unitaryValue == null) {
      return 0.0;
    }

    _item.totalValue = _item.unitaryValue! * _item.quantity!;
    return _item.totalValue!;
  }

  void onChangeCreateBoxState(CreateBoxState newState) {
    if (!_createBoxStateSubject.isClosed) {
      _createBoxStateSubject.add(newState);
    }
  }

  @override
  void handleFishinCreateDeclarations({
    required Address address,
    required BoxList boxList,
    required bool dropShipping,
  }) async {
    onChangeCreateBoxState(CreateBoxLoadingState());

    final list = _declarationsSubject.valueOrNull ?? [];
    final items = boxList.map<String>((it) => it.id).toList();
    final declarations = list.map((it) => it.toDeclaration()).toList();

    try {
      await repository.createPackages(
        newPackage: NewPackage(
          items: items,
          address: address,
          dropShipping: dropShipping,
          declarations: declarations,
        ),
      );

      onChangeCreateBoxState(CreateBoxSucessState());
    } on ApiClientError catch (e) {
      onChangeCreateBoxState(CreateBoxErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void navigateToHome() async {
    cardController.resetToInitialState();

    await Future.delayed(Durations.splashAnimation);
    Modular.to.pushNamed(RoutesName.tabs.name);
  }

  @override
  void dispose() {
    _declarationsSubject.close();
    _declarationSectionSubject.close();
    _createBoxStateSubject.close();
    _currentCategorySubject.close();
  }
}
