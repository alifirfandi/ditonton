part of 'action_watchlist_movie_bloc.dart';

@immutable
abstract class ActionWatchlistMovieState extends Equatable {
  const ActionWatchlistMovieState();

  @override
  List<Object> get props => [];
}

class ActionWatchlistMovieInitial extends ActionWatchlistMovieState {}

class AddWatchlistMovieLoading extends ActionWatchlistMovieState {}

class AddWatchlistMovieSuccess extends ActionWatchlistMovieState {
  final String movieData;

  const AddWatchlistMovieSuccess(this.movieData);

  @override
  List<Object> get props => [movieData];
}

class AddWatchlistMovieError extends ActionWatchlistMovieState {
  final String message;

  const AddWatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteWatchlistMovieLoading extends ActionWatchlistMovieState {}

class DeleteWatchlistMovieSuccess extends ActionWatchlistMovieState {
  final String movieData;

  const DeleteWatchlistMovieSuccess(this.movieData);

  @override
  List<Object> get props => [movieData];
}

class DeleteWatchlistMovieError extends ActionWatchlistMovieState {
  final String message;

  const DeleteWatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}
