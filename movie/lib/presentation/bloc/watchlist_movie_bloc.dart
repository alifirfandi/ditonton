import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecase/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMovieBloc(this._getWatchlistMovies)
      : super(WatchlistMovieInitial()) {
    on<GetWatchlistMovie>((event, emit) async {
      emit(GetWatchlistMovieLoading());

      final watchlistMovie = await _getWatchlistMovies.execute();

      watchlistMovie.fold(
        (failure) {
          emit(GetWatchlistMovieError(failure.message));
        },
        (moviesData) {
          if (moviesData.isEmpty) {
            emit(GetWatchlistMovieEmpty());
          } else {
            emit(GetWatchlistMovieHasData(moviesData));
          }
        },
      );
    });
  }
}
