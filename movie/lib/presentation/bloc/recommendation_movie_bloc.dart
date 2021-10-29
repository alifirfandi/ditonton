import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecase/get_movie_recommendations.dart';

part 'recommendation_movie_event.dart';
part 'recommendation_movie_state.dart';

class RecommendationMovieBloc
    extends Bloc<RecommendationMovieEvent, RecommendationMovieState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendationMovieBloc(this._getMovieRecommendations)
      : super(RecommendationMovieInitial()) {
    on<GetRecommendationMovieEvent>((event, emit) async {
      emit(RecommendationMoviesLoading());
      final recommendationResult =
          await _getMovieRecommendations.execute(event.idMovie);
      recommendationResult.fold(
        (failure) {
          emit(RecommendationMoviesError(failure.message));
        },
        (movies) {
          if (movies.isEmpty) {
            emit(RecommendationMoviesEmpty());
          } else {
            emit(RecommendationMoviesData(movies));
          }
        },
      );
    });
  }
}
