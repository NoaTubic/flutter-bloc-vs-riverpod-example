import 'package:bloc_vs_riverpod_example/presentation/state/bloc/fact_bloc.dart';
import '../../../domain/api_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final factsNotifierProvider = StateNotifierProvider<FactsNotifier, FactState>(
  (ref) => FactsNotifier(
    ApiRepository(),
  ),
);

class FactsNotifier extends StateNotifier<FactState> {
  final ApiRepository _apiRepository;

  FactsNotifier(this._apiRepository) : super(FactInitialState());

  void load() async {
    state = FactLoadingState();
    final fact = await _apiRepository.fetchFact();
    if (fact.success) {
      state = FactLoadedState(fact.data!);
    } else {
      state = FactErrorState(fact.error!);
    }
  }
}
