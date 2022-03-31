part of 'fact_bloc.dart';

@immutable
abstract class FactEvent extends Equatable {
  const FactEvent();
}

class LoadFactEvent extends FactEvent {
  @override
  List<Object> get props => [];
}

class NoInternetEvent extends FactEvent {
  @override
  List<Object?> get props => [];
}
