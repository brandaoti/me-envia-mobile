import 'package:connectivity/connectivity.dart';

abstract class NetworkConnectionService {
  Future<bool> get isConnected;
}

class NetworkConnection implements NetworkConnectionService {
  final Connectivity _connectionChecker;

  const NetworkConnection({
    required Connectivity connectionChecker,
  }) : _connectionChecker = connectionChecker;

  @override
  Future<bool> get isConnected async {
    final connectionStatus = await _connectionChecker.checkConnectivity();
    return connectionStatus != ConnectivityResult.none;
  }
}
