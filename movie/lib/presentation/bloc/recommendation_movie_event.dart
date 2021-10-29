part of 'recommendation_movie_bloc.dart';

@immutable
abstract class RecommendationMovieEvent extends Equatable{
  const RecommendationMovieEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendationMovieEvent extends RecommendationMovieEvent {
  final idMovie;

  GetRecommendationMovieEvent(this.idMovie);
}