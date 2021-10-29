part of 'detail_movie_bloc.dart';

@immutable
abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();

  @override
  List<Object> get props => [];
}

class GetDetailMovieEvent extends DetailMovieEvent {
  final idMovie;

  GetDetailMovieEvent(this.idMovie);
}
