import 'package:flutter_modular/flutter_modular.dart';
import 'package:maria_me_envia/core/core.dart';
import 'package:rxdart/rxdart.dart';

import '../features.dart';
import 'states/recipient_user_state.dart';

abstract class RecipientInformationController extends Disposable {
  Stream<RecipientUserState> get recipientUserState;

  void navigateToCustomDeclaration(BoxList boxList);
  void navigateToNewRecipientScreen(BoxList boxList);

  void init();
}

class RecipientInformationControllerImpl
    implements RecipientInformationController {
  final AuthController authController;

  RecipientInformationControllerImpl({
    required this.authController,
  });

  User? user;

  final _userStateSubject = BehaviorSubject<RecipientUserState>.seeded(
    RecipientUserLoadingState(),
  );

  @override
  Stream<RecipientUserState> get recipientUserState =>
      _userStateSubject.stream.distinct();

  @override
  void init() async {
    user = await authController.getUser();
    onChangeRecipientUserState(RecipientUserSucessState(
      user: user,
    ));
  }

  void onChangeRecipientUserState(RecipientUserState newState) {
    if (!_userStateSubject.isClosed) {
      _userStateSubject.add(newState);
    }
  }

  @override
  void navigateToCustomDeclaration(BoxList boxList) {
    Modular.to.pushNamed(
      RoutesName.customsDeclaration.linkNavigate,
      arguments: ScreenParams(
        boxList: boxList,
        dropShipping: false,
        address: user!.address,
      ),
    );
  }

  @override
  void navigateToNewRecipientScreen(BoxList boxList) {
    Modular.to.pushNamed(
      RoutesName.newRecipient.linkNavigate,
      arguments: ScreenParams(
        boxList: boxList,
        dropShipping: false,
        address: user!.address,
      ),
    );
  }

  @override
  void dispose() {
    _userStateSubject.close();
  }
}
