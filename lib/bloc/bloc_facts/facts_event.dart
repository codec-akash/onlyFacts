part of 'facts_bloc.dart';

abstract class FactsEvent extends Equatable {
  const FactsEvent();

  @override
  List<Object> get props => [];
}

class LoadFactsList extends FactsEvent {}
