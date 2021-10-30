import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recommendation_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendationMovieBloc recommendationMovieBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMovieBloc =
        RecommendationMovieBloc(mockGetMovieRecommendations);
  });

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(testMovie.id))
          .thenAnswer((_) async => Right(testMovieList));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(GetRecommendationMovieEvent(testMovie.id)),
    expect: () => [
      RecommendationMoviesLoading(),
      RecommendationMoviesData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(testMovie.id));
    },
  );

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetMovieRecommendations.execute(testMovie.id))
          .thenAnswer((_) async => Right([]));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(GetRecommendationMovieEvent(testMovie.id)),
    expect: () => [
      RecommendationMoviesLoading(),
      RecommendationMoviesEmpty(),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(testMovie.id));
    },
  );

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'Should emit [Loading, Error] when get movies is unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(testMovie.id))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(GetRecommendationMovieEvent(testMovie.id)),
    expect: () => [
      RecommendationMoviesLoading(),
      const RecommendationMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(testMovie.id));
    },
  );
}
