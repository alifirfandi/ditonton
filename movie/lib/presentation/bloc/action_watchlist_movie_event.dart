part of 'action_watchlist_movie_bloc.dart';

@immutable
abstract class ActionWatchlistMovieEvent extends Equatable {
  const ActionWatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistMovie extends ActionWatchlistMovieEvent {
  final MovieDetail movieDetail;

  const AddWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class DeleteWatchlistMovie extends ActionWatchlistMovieEvent {
  final MovieDetail movieDetail;

  const DeleteWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
