import 'package:bloc_vs_riverpod_example/common/models/api_response.dart';
import 'package:bloc_vs_riverpod_example/data/models/fact.dart';
import 'package:bloc_vs_riverpod_example/domain/api_repository.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/bloc/fact_bloc.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/state_notifier/facts_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import 'fact_state_notifier_test.mocks.dart';

@GenerateMocks([ApiRepository])
void main() {
  final mockApiRepo = MockApiRepository();
  final fact = Fact(id: '', text: '');

  group(
    'State notifier tests',
    () {
      stateNotifierTest<FactsNotifier, FactState>(
        'Emits [] when no methods are called',
        build: () => FactsNotifier(mockApiRepo),
        actions: (FactsNotifier stateNotifier) {},
        expect: () => [],
      );

      stateNotifierTest<FactsNotifier, FactState>(
        'Emits [FactLoadingState, FactLoadedState] when api is fetched successfully',
        build: () => FactsNotifier(mockApiRepo),
        setUp: () async {
          when(mockApiRepo.fetchFact()).thenAnswer(
            (realInvocation) async {
              return ApiResponse(
                data: fact,
                success: true,
              );
            },
          );
        },
        actions: (FactsNotifier stateNotifier) {
          stateNotifier.load();
        },
        expect: () => [
          FactLoadingState(),
          FactLoadedState(fact),
        ],
      );

      stateNotifierTest<FactsNotifier, FactState>(
        'Emits [FactLoadingState, FactLoadedState] when api is not fetched successfully',
        build: () => FactsNotifier(mockApiRepo),
        setUp: () async {
          when(mockApiRepo.fetchFact()).thenAnswer(
            (realInvocation) async {
              return ApiResponse(
                error: 'Error',
                success: false,
              );
            },
          );
        },
        actions: (FactsNotifier stateNotifier) {
          stateNotifier.load();
        },
        expect: () => [
          FactLoadingState(),
          const FactErrorState('Error'),
        ],
      );
    },
  );
}
