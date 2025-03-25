import 'package:rxdart/rxdart.dart';
import '../../../../core/core.dart';

abstract class TermOfUseController {
  Stream<bool> get termOfUseAcceptedStream;

  Future<String> loadPrivacyPolicyApp();

  void acceptTermOfuse(bool value);
  void dispose();
}

class TermOfUseControllerImpl implements TermOfUseController {
  final PutFileService service;

  TermOfUseControllerImpl({
    required this.service,
  });

  final _termOfUseAcceptedSubject = BehaviorSubject<bool>.seeded(false);

  @override
  Stream<bool> get termOfUseAcceptedStream =>
      _termOfUseAcceptedSubject.stream.distinct();
  @override
  void acceptTermOfuse(bool value) {
    if (!_termOfUseAcceptedSubject.isClosed) {
      _termOfUseAcceptedSubject.add(value);
    }
  }

  @override
  Future<String> loadPrivacyPolicyApp() async {
    return await service.getPrivacyPolicyFile();
  }

  @override
  void dispose() {
    _termOfUseAcceptedSubject.close();
  }
}
