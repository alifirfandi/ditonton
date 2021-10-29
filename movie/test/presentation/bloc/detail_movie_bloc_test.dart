import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/detail_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(mockGetMovieDetail);
  });

  blocTest<DetailMovieBloc, DetailMovieState>(
    'Should emit [Loading, Data] when get detail movie is success',
    build: () {
      when(mockGetMovieDetail.execute(testMovie.id))
          .thenAnswer((_) async => Right(testMovieDetail));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(GetDetailMovieEvent(testMovie.id)),
    expect: () => [
      DetailMovieLoading(),
      DetailMovieData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(testMovie.id));
    },
  );

  blocTest<DetailMovieBloc, DetailMovieState>(
    'Should emit [Loading, Error] when get detail movie is failed',
    build: () {
      when(mockGetMovieDetail.execute(testMovie.id))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(GetDetailMovieEvent(testMovie.id)),
    expect: () => [
      DetailMovieLoading(),
      const DetailMovieError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(testMovie.id));
    },
  );
}
