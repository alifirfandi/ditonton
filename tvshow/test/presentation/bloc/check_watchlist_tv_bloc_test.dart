import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/domain/usecase/get_watchlist_status_tv.dart';
import 'package:tvshow/presentation/bloc/check_watchlist_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'check_watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistStatusTv])
void main() {
  late CheckWatchlistTvBloc checkWatchlistTvBloc;
  late MockGetWatchlistStatusTv mockGetWatchlistStatusTv;

  setUp(() {
    mockGetWatchlistStatusTv = MockGetWatchlistStatusTv();
    checkWatchlistTvBloc = CheckWatchlistTvBloc(mockGetWatchlistStatusTv);
  });

  blocTest<CheckWatchlistTvBloc, CheckWatchlistTvState>(
    'Should emit [Loading, Data] when get status watchlist tv',
    build: () {
      when(mockGetWatchlistStatusTv.execute(testTv.id))
          .thenAnswer((_) async => true);
      return checkWatchlistTvBloc;
    },
    act: (bloc) => bloc.add(CheckWatchlistTv(testTv.id)),
    expect: () => [
      CheckWatchlistTvLoading(),
      const CheckWatchlistTvData(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistStatusTv.execute(testTv.id));
    },
  );
}
