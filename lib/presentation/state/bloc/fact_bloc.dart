import 'package:bloc/bloc.dart';
import '../../../data/models/fact.dart';
import '../../../domain/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'fact_event.dart';
part '../fact_state.dart';

class FactBloc extends Bloc<FactEvent, FactState> {
  final ApiRepository _apiRepository;

  FactBloc(
    this._apiRepository,
  ) : super(FactInitialState()) {
    on<LoadFactEvent>(
      (event, emit) async {
        emit(FactLoadingState());
        final fact = await _apiRepository.fetchFact();
        if (fact.success) {
          emit(
            FactLoadedState(fact.data!),
          );
        } else {
          emit(
            FactErrorState(fact.error!),
          );
        }
      },
    );
  }
}
