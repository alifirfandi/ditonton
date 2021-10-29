import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'action_watchlist_movie_bloc_test.mocks.dart';
import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlistMovie, RemoveWatchlistMovie])
void main() {
  late ActionWatchlistMovieBloc actionBloc;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;

  setUp(() {
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    actionBloc = ActionWatchlistMovieBloc(
      mockSaveWatchlistMovie,
      mockRemoveWatchlistMovie,
    );
  });

  blocTest<ActionWatchlistMovieBloc, ActionWatchlistMovieState>(
    'Should emit [Success] when save watchlist function is success',
    build: () {
      when(mockSaveWatchlistMovie.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return actionBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
    expect: () => [
      AddWatchlistMovieLoading(),
      const AddWatchlistMovieSuccess('Added to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistMovie.execute(testMovieDetail));
    },
  );

  blocTest<ActionWatchlistMovieBloc, ActionWatchlistMovieState>(
    'Should emit [Error] when save watchlist function is failed',
    build: () {
      when(mockSaveWatchlistMovie.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return actionBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
    expect: () => [
      AddWatchlistMovieLoading(),
      const AddWatchlistMovieError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistMovie.execute(testMovieDetail));
    },
  );

  blocTest<ActionWatchlistMovieBloc, ActionWatchlistMovieState>(
    'Should emit [Success] when remove watchlist function is success',
    build: () {
      when(mockRemoveWatchlistMovie.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      return actionBloc;
    },
    act: (bloc) => bloc.add(DeleteWatchlistMovie(testMovieDetail)),
    expect: () => [
      DeleteWatchlistMovieLoading(),
      const DeleteWatchlistMovieSuccess('Removed from Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
    },
  );

  blocTest<ActionWatchlistMovieBloc, ActionWatchlistMovieState>(
    'Should emit [Error] when remove watchlist function is failed',
    build: () {
      when(mockRemoveWatchlistMovie.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return actionBloc;
    },
    act: (bloc) => bloc.add(DeleteWatchlistMovie(testMovieDetail)),
    expect: () => [
      DeleteWatchlistMovieLoading(),
      const DeleteWatchlistMovieError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
    },
  );
}