part of 'recommendation_movie_bloc.dart';

@immutable
abstract class RecommendationMovieState extends Equatable {
  const RecommendationMovieState();

  @override
  List<Object> get props => [];
}

class RecommendationMovieInitial extends RecommendationMovieState {}

class RecommendationMoviesLoading extends RecommendationMovieState {}

class RecommendationMoviesEmpty extends RecommendationMovieState {}

class RecommendationMoviesData extends RecommendationMovieState {
  final List<Movie> recommendationMovies;

  const RecommendationMoviesData(this.recommendationMovies);

  @override
  List<Object> get props => [recommendationMovies];
}

class RecommendationMoviesError extends RecommendationMovieState {
  final String message;

  const RecommendationMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
