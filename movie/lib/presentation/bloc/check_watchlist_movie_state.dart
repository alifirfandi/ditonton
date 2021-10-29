part of 'check_watchlist_movie_bloc.dart';

@immutable
abstract class CheckWatchlistMovieState extends Equatable {
  const CheckWatchlistMovieState();

  @override
  List<Object> get props => [];
}

class CheckWatchlistMovieInitial extends CheckWatchlistMovieState {}

class CheckWatchlistMovieLoading extends CheckWatchlistMovieState {}

class CheckWatchlistMovieData extends CheckWatchlistMovieState {
  final bool isAddedWatchlist;

  const CheckWatchlistMovieData(this.isAddedWatchlist);

  @override
  List<Object> get props => [isAddedWatchlist];
}

class CheckWatchlistMovieError extends CheckWatchlistMovieState {
  final String message;

  const CheckWatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}
