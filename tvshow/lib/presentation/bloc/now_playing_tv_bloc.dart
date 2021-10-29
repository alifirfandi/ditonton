import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tvshow/domain/entities/tv.dart';
import 'package:tvshow/domain/usecase/get_now_playing_tv.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTv _getNowPlayingTv;

  NowPlayingTvBloc(this._getNowPlayingTv) : super(NowPlayingTvInitial()) {
    on<NowPlayingTvEvent>((event, emit) async {
      emit(NowPlayingTvLoading());

      final nowPlayingTv = await _getNowPlayingTv.execute();

      nowPlayingTv.fold(
        (failure) {
          emit(NowPlayingTvError(failure.message));
        },
        (tvData) {
          if (tvData.isEmpty) {
            emit(NowPlayingTvEmpty());
          } else {
            emit(NowPlayingTvHasData(tvData));
          }
        },
      );
    });
  }
}
