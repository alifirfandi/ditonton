import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/domain/usecase/remove_watchlist_tv.dart';
import 'package:tvshow/domain/usecase/save_watchlist_tv.dart';
import 'package:tvshow/presentation/bloc/action_watchlist_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'action_watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlistTv, RemoveWatchlistTv])
void main() {
  late ActionWatchlistTvBloc actionBloc;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    actionBloc = ActionWatchlistTvBloc(
      mockSaveWatchlistTv,
      mockRemoveWatchlistTv,
    );
  });

  blocTest<ActionWatchlistTvBloc, ActionWatchlistTvState>(
    'Should emit [Success] when save watchlist function is success',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return actionBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistTv(testTvDetail)),
    expect: () => [
      AddWatchlistTvLoading(),
      const AddWatchlistTvSuccess('Added to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    },
  );

  blocTest<ActionWatchlistTvBloc, ActionWatchlistTvState>(
    'Should emit [Error] when save watchlist function is failed',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return actionBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistTv(testTvDetail)),
    expect: () => [
      AddWatchlistTvLoading(),
      const AddWatchlistTvError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    },
  );

  blocTest<ActionWatchlistTvBloc, ActionWatchlistTvState>(
    'Should emit [Success] when remove watchlist function is success',
    build: () {
      when(mockRemoveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      return actionBloc;
    },
    act: (bloc) => bloc.add(DeleteWatchlistTv(testTvDetail)),
    expect: () => [
      DeleteWatchlistTvLoading(),
      const DeleteWatchlistTvSuccess('Removed from Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
    },
  );

  blocTest<ActionWatchlistTvBloc, ActionWatchlistTvState>(
    'Should emit [Error] when remove watchlist function is failed',
    build: () {
      when(mockRemoveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return actionBloc;
    },
    act: (bloc) => bloc.add(DeleteWatchlistTv(testTvDetail)),
    expect: () => [
      DeleteWatchlistTvLoading(),
      const DeleteWatchlistTvError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
    },
  );
}