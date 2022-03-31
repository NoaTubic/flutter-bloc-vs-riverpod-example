import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfoCubit extends Cubit<ConnectivityResult> {
  NetworkInfoCubit(Connectivity _connectivityService)
      : super(ConnectivityResult.wifi) {
    _connectivityService.onConnectivityChanged.listen((event) {
      connectionChanged(event);
    });
  }
  connectionChanged(ConnectivityResult result) {
    emit(result);
  }
}

bool isConnected(ConnectivityResult connection) =>
    connection == ConnectivityResult.none;
