import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/domain/usecase/get_now_playing_tv.dart';
import 'package:tvshow/presentation/bloc/now_playing_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late NowPlayingTvBloc nowPlayingTvBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    nowPlayingTvBloc = NowPlayingTvBloc(mockGetNowPlayingTv);
  });

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingTvEvent()),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());
    },
  );

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right([]));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingTvEvent()),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvEmpty(),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());
    },
  );

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'Should emit [Loading, Error] when get movies is unsuccessful',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingTvEvent()),
    expect: () => [
      NowPlayingTvLoading(),
      const NowPlayingTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());
    },
  );
}
