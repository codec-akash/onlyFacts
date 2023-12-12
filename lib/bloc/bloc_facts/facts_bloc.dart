import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:only_facts/model/facts_model.dart';
import 'package:only_facts/repository/facts_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'facts_event.dart';
part 'facts_state.dart';

class FactsBloc extends Bloc<FactsEvent, FactsState> {
  FactsBloc() : super(FactsUninitialized());

  FactsRepo factsRepo = FactsRepo();

  @override
  Stream<Transition<FactsEvent, FactsState>> transformEvents(
      Stream<FactsEvent> events,
      TransitionFunction<FactsEvent, FactsState> transitionFn) {
    return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<FactsState> mapEventToState(FactsEvent event) async* {
    print("Event is  $event");
    if (event is LoadFactsList) {
      yield await _mapPostFetchedToState(state);
    }
  }

  Future<FactsState> _mapPostFetchedToState(FactsState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.factStatus == FactStatus.initial) {
        final quotes = await _fetchPosts();
        return state.copyWith(
          quoteStatus: FactStatus.success,
          animeQuotes: quotes,
          hasReachedMax: false,
        );
      }
      final quotes = await _fetchPosts(state.factsList.length);
      return quotes.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              quoteStatus: FactStatus.success,
              animeQuotes: List.of(state.factsList)..addAll(quotes),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(quoteStatus: FactStatus.failure);
    }
  }

  Future<List<Facts>> _fetchPosts([int startIndex = 0]) async {
    try {
      final List<Facts> animeQuotes = await factsRepo.getFacts();
      return animeQuotes;
    } catch (e) {
      throw Exception('error fetching quotes');
    }
  }
}
