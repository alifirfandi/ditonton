import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'check_watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistStatusMovie])
void main() {
  late CheckWatchlistMovieBloc checkWatchlistMovieBloc;
  late MockGetWatchlistStatusMovie mockGetWatchlistStatusMovie;

  setUp(() {
    mockGetWatchlistStatusMovie = MockGetWatchlistStatusMovie();
    checkWatchlistMovieBloc =
        CheckWatchlistMovieBloc(mockGetWatchlistStatusMovie);
  });

  blocTest<CheckWatchlistMovieBloc, CheckWatchlistMovieState>(
    'Should emit [Loading, Data] when get status watchlist movie',
    build: () {
      when(mockGetWatchlistStatusMovie.execute(testMovie.id))
          .thenAnswer((_) async => true);
      return checkWatchlistMovieBloc;
    },
    act: (bloc) => bloc.add(CheckWatchlistMovie(testMovie.id)),
    expect: () => [
      CheckWatchlistMovieLoading(),
      const CheckWatchlistMovieData(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistStatusMovie.execute(testMovie.id));
    },
  );
}
