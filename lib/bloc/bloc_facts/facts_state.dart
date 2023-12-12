part of 'facts_bloc.dart';

enum FactStatus { initial, success, failure }

class FactsState extends Equatable {
  const FactsState({
    this.factStatus = FactStatus.initial,
    this.factsList = const <Facts>[],
    this.hasReachedMax = false,
  });

  final List<Facts> factsList;
  final FactStatus factStatus;
  final bool hasReachedMax;

  FactsState copyWith(
      {FactStatus? quoteStatus,
      List<Facts>? animeQuotes,
      bool? hasReachedMax}) {
    return FactsState(
      factStatus: quoteStatus ?? this.factStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      factsList: animeQuotes ?? this.factsList,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $factStatus, hasReachedMax: $hasReachedMax, posts: ${factsList.length} }''';
  }

  @override
  List<Object> get props => [factStatus, factsList, hasReachedMax];
}

class FactsUninitialized extends FactsState {}

class FactsLoading extends FactsState {}

class FactsListLoaded extends FactsState {
  final List<Facts> factsList;
  FactsListLoaded({required this.factsList});
}

class FactsEventFailed extends FactsState {}
