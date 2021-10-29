import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecase/search_movies.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies _searchMovies;

  @override
  Stream<Transition<SearchMovieEvent, SearchMovieState>> transformEvents(
    Stream<SearchMovieEvent> events,
    TransitionFunction<SearchMovieEvent, SearchMovieState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  SearchMovieBloc(this._searchMovies) : super(SearchMovieInitial()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchMovieLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(SearchMovieError(failure.message));
        },
        (movieSearch) {
          if (movieSearch.isEmpty) {
            emit(SearchMovieEmpty());
          } else {
            emit(SearchMovieHasData(movieSearch));
          }
        },
      );
    });
  }
}
