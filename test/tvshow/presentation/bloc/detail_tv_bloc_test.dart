import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/domain/usecase/get_tv_detail.dart';
import 'package:tvshow/presentation/bloc/detail_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late DetailTvBloc detailTvBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    detailTvBloc = DetailTvBloc(mockGetTvDetail);
  });

  blocTest<DetailTvBloc, DetailTvState>(
    'Should emit [Loading, Data] when get detail tv is success',
    build: () {
      when(mockGetTvDetail.execute(testTv.id))
          .thenAnswer((_) async => Right(testTvDetail));
      return detailTvBloc;
    },
    act: (bloc) => bloc.add(GetDetailTvEvent(testTv.id)),
    expect: () => [
      DetailTvLoading(),
      DetailTvData(testTvDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(testTv.id));
    },
  );

  blocTest<DetailTvBloc, DetailTvState>(
    'Should emit [Loading, Error] when get detail tv is failed',
    build: () {
      when(mockGetTvDetail.execute(testTv.id))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailTvBloc;
    },
    act: (bloc) => bloc.add(GetDetailTvEvent(testTv.id)),
    expect: () => [
      DetailTvLoading(),
      const DetailTvError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(testTv.id));
    },
  );
}
