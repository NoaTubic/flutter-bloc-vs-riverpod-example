import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/network/network_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_cubit_test.mocks.dart';

class MockNetworkInfoCubit extends MockCubit<ConnectivityResult>
    implements NetworkInfoCubit {}

@GenerateMocks([Connectivity])
void main() {
  test('Emits different connection types when connection is changed', () {
    final _connectivityService = MockConnectivity();
    final _cubit = MockNetworkInfoCubit();

    whenListen(
      _cubit,
      Stream.fromIterable([
        ConnectivityResult.mobile,
        ConnectivityResult.none,
        ConnectivityResult.wifi,
      ]),
      initialState: ConnectivityResult.wifi,
    );

    when(_connectivityService.onConnectivityChanged)
        .thenAnswer((realInvocation) {
      return Stream.fromIterable([
        ConnectivityResult.mobile,
        ConnectivityResult.none,
        ConnectivityResult.wifi,
      ]);
    });

    expectLater(
      _cubit.stream,
      emitsInOrder(
        <ConnectivityResult>[
          ConnectivityResult.mobile,
          ConnectivityResult.none,
          ConnectivityResult.wifi
        ],
      ),
    );
  });
}
