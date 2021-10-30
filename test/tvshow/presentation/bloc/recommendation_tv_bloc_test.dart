import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/domain/usecase/get_tv_recommendations.dart';
import 'package:tvshow/presentation/bloc/recommendation_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recommendation_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late RecommendationTvBloc recommendationTvBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    recommendationTvBloc =
        RecommendationTvBloc(mockGetTvRecommendations);
  });

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvRecommendations.execute(testTv.id))
          .thenAnswer((_) async => Right(testTvList));
      return recommendationTvBloc;
    },
    act: (bloc) => bloc.add(GetRecommendationTvEvent(testTv.id)),
    expect: () => [
      RecommendationTvLoading(),
      RecommendationTvData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(testTv.id));
    },
  );

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetTvRecommendations.execute(testTv.id))
          .thenAnswer((_) async => Right([]));
      return recommendationTvBloc;
    },
    act: (bloc) => bloc.add(GetRecommendationTvEvent(testTv.id)),
    expect: () => [
      RecommendationTvLoading(),
      RecommendationTvEmpty(),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(testTv.id));
    },
  );

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'Should emit [Loading, Error] when get tv is unsuccessful',
    build: () {
      when(mockGetTvRecommendations.execute(testTv.id))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendationTvBloc;
    },
    act: (bloc) => bloc.add(GetRecommendationTvEvent(testTv.id)),
    expect: () => [
      RecommendationTvLoading(),
      const RecommendationTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(testTv.id));
    },
  );
}
