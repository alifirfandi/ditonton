import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tvshow/domain/entities/tv.dart';
import 'package:tvshow/domain/usecase/get_popular_tv.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv _getPopularTv;

  PopularTvBloc(this._getPopularTv) : super(PopularTvInitial()) {
    on<PopularTvEvent>((event, emit) async {
      emit(PopularTvLoading());

      final popularTv = await _getPopularTv.execute();

      popularTv.fold(
        (failure) {
          emit(PopularTvError(failure.message));
        },
        (tvData) {
          if (tvData.isEmpty) {
            emit(PopularTvEmpty());
          } else {
            emit(PopularTvHasData(tvData));
          }
        },
      );
    });
  }
}
