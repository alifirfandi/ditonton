part of 'detail_movie_bloc.dart';

@immutable
abstract class DetailMovieState extends Equatable{
  const DetailMovieState();

  @override
  List<Object> get props => [];
}

class DetailMovieInitial extends DetailMovieState {}

class DetailMovieLoading extends DetailMovieState {}

class DetailMovieData extends DetailMovieState {
  final MovieDetail movieDetail;

  const DetailMovieData(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class DetailMovieError extends DetailMovieState {
  final String message;

  const DetailMovieError(this.message);

  @override
  List<Object> get props => [message];
}
