part of 'watchlist_movie_bloc.dart';

@immutable
abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieInitial extends WatchlistMovieState {}

class GetWatchlistMovieLoading extends WatchlistMovieState {}

class GetWatchlistMovieEmpty extends WatchlistMovieState {}

class GetWatchlistMovieHasData extends WatchlistMovieState {
  final List<Movie> movies;

  const GetWatchlistMovieHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class GetWatchlistMovieError extends WatchlistMovieState {
  final String message;

  const GetWatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}
