part of 'check_watchlist_movie_bloc.dart';

@immutable
abstract class CheckWatchlistMovieEvent extends Equatable {
  const CheckWatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class CheckWatchlistMovie extends CheckWatchlistMovieEvent {
  final int idMovie;

  const CheckWatchlistMovie(this.idMovie);

  @override
  List<Object> get props => [idMovie];
}
