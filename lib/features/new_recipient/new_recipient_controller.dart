// ignore_for_file: annotate_overrides

import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/core.dart';
import '../features.dart';
import 'models/new_address.dart';

enum NewRecipientSection {
  firstSection,
  secondSection,
  thirdSection,
  fourthSection,
}

abstract class NewRecipientController {
  AddressFormController get addressController;
  Stream<NewRecipientSection> get sectionStream;
  Stream<CreateBoxState> get createBoxStateStream;

  void onFormSection(int index);
  void onChangeSectionState(int index);

  void handleOpressedBAckButton(NewRecipientSection section);
  NewAddress getNewAddress({required String cpf, required String name});

  void handleChooseDropShipping({
    required String cpf,
    required String name,
    required BoxList boxList,
    required bool isDropShipping,
  });

  void handleCreateBoxSucess();

  void init();
  void dispose();
}

class NewRecipientControllerImpl implements NewRecipientController {
  final CardController cardController;
  final GeneralInformationRepository repository;
  final AddressFormController addressController;

  NewRecipientControllerImpl({
    required this.repository,
    required this.cardController,
    required this.addressController,
  });

  final _sectionStream = BehaviorSubject<NewRecipientSection>.seeded(
    NewRecipientSection.firstSection,
  );

  final _createBoxStateSubject = BehaviorSubject<CreateBoxState>();

  @override
  Stream<NewRecipientSection> get sectionStream =>
      _sectionStream.stream.distinct();

  @override
  Stream<CreateBoxState> get createBoxStateStream =>
      _createBoxStateSubject.stream.distinct();

  @override
  void init() async {
    await addressController.init();
  }

  @override
  void onChangeSectionState(int index) {
    if (!_sectionStream.isClosed) {
      _sectionStream.add(NewRecipientSection.values[index]);
    }
  }

  @override
  void onFormSection(int index) {
    addressController.onFormSection(index);
  }

  @override
  void handleOpressedBAckButton(NewRecipientSection section) {
    switch (section) {
      case NewRecipientSection.firstSection:
        Modular.to.pop();
        break;
      case NewRecipientSection.secondSection:
        onFormSection(0);
        onChangeSectionState(0);
        break;
      case NewRecipientSection.thirdSection:
      case NewRecipientSection.fourthSection:
        break;
    }
  }

  @override
  NewAddress getNewAddress({required String cpf, required String name}) {
    final info = addressController.getAddressInformation();
    return NewAddress.information(cpf, name, info);
  }

  @override
  void handleChooseDropShipping({
    required String cpf,
    required String name,
    required BoxList boxList,
    required bool isDropShipping,
  }) async {
    final newAddress = getNewAddress(cpf: cpf, name: name);

    if (!isDropShipping) {
      Modular.to.pushNamed(
        RoutesName.customsDeclaration.linkNavigate,
        arguments: ScreenParams(
          boxList: boxList,
          dropShipping: false,
          address: newAddress.address,
        ),
      );
      return;
    }

    await _createBoxWithNoDeclaration(newAddress: newAddress, boxList: boxList);
  }

  void onChangeCreateBoxState(CreateBoxState newState) {
    if (!_createBoxStateSubject.isClosed) {
      _createBoxStateSubject.add(newState);
    }
  }

  Future<void> _createBoxWithNoDeclaration({
    required BoxList boxList,
    required NewAddress newAddress,
  }) async {
    onChangeCreateBoxState(CreateBoxLoadingState());

    try {
      final items = boxList.map<String>((it) => it.id).toList();

      await repository.createPackages(
        newPackage: NewPackage(
          items: items,
          declarations: [],
          dropShipping: true,
          receiverCpf: newAddress.cpf,
          address: newAddress.address,
          receiverName: newAddress.name,
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
  void handleCreateBoxSucess() async {
    cardController.resetToInitialState();

    Modular.to.pushReplacementNamed(
      RoutesName.tabs.name,
      arguments: TabScreenParams.createBox(),
    );

    await Helper.enterInContactWithMaria();
  }

  @override
  void dispose() {
    _sectionStream.close();
    addressController.dispose();
    _createBoxStateSubject.close();
  }
}
