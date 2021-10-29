import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tvshow/domain/entities/tv.dart';
import 'package:tvshow/domain/usecase/get_top_rated_tv.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv _getTopRatedTv;

  TopRatedTvBloc(this._getTopRatedTv) : super(TopRatedTvInitial()) {
    on<TopRatedTvEvent>((event, emit) async {
      emit(TopRatedTvLoading());

      final popularTv = await _getTopRatedTv.execute();

      popularTv.fold(
        (failure) {
          emit(TopRatedTvError(failure.message));
        },
        (tvData) {
          if (tvData.isEmpty) {
            emit(TopRatedTvEmpty());
          } else {
            emit(TopRatedTvHasData(tvData));
          }
        },
      );
    });
  }
}
