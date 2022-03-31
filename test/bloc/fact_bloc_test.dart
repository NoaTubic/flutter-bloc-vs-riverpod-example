import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_vs_riverpod_example/common/models/api_response.dart';
import 'package:bloc_vs_riverpod_example/data/models/fact.dart';
import 'package:bloc_vs_riverpod_example/domain/api_repository.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/bloc/fact_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'fact_bloc_test.mocks.dart';

@GenerateMocks([ApiRepository])
void main() {
  final mockApiRepo = MockApiRepository();
  final fact = Fact(id: '', text: '');
  group(
    'Bloc tests',
    () {
      blocTest<FactBloc, FactState>(
        'Block emits [] when no events are added.',
        build: () => FactBloc(mockApiRepo),
        expect: () => const <FactState>[],
      );

      blocTest(
        'Bloc emits [FactLoadingState, FactLoadedState] when api is fetched successfully',
        build: () => FactBloc(mockApiRepo),
        setUp: () async {
          when(mockApiRepo.fetchFact()).thenAnswer(
            (realInvocation) async {
              return ApiResponse(
                success: true,
                data: fact,
              );
            },
          );
        },
        act: (FactBloc bloc) {
          bloc.add(LoadFactEvent());
        },
        expect: () => [
          FactLoadingState(),
          FactLoadedState(fact),
        ],
        tearDown: () {
          reset(mockApiRepo);
        },
        verify: (FactBloc bloc) => verify(mockApiRepo.fetchFact()).called(1),
      );

      blocTest(
        'Bloc [FactLoadingState, FactErrorState] when api is not fetched successfully',
        build: () => FactBloc(mockApiRepo),
        setUp: () async {
          when(mockApiRepo.fetchFact()).thenAnswer(
            (realInvocation) async {
              return ApiResponse(
                success: false,
                error: 'Error',
              );
            },
          );
        },
        act: (FactBloc bloc) {
          bloc.add(LoadFactEvent());
        },
        expect: () => [
          FactLoadingState(),
          const FactErrorState('Error'),
        ],
        verify: (FactBloc bloc) => verify(mockApiRepo.fetchFact()).called(1),
      );
    },
  );
}
