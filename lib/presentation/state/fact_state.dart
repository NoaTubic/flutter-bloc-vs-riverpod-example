part of 'bloc/fact_bloc.dart';

@immutable
abstract class FactState extends Equatable {
  const FactState();

  @override
  List<Object> get props => [];
}

class FactInitialState extends FactState {}

class FactLoadingState extends FactState {}

class FactLoadedState extends FactState {
  final Fact fact;

  const FactLoadedState(this.fact);
}

class FactErrorState extends FactState {
  final String error;

  const FactErrorState(this.error);
}

class FactNoInternetState extends FactState {}


