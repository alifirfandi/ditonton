import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tvshow/domain/entities/tv.dart';
import 'package:tvshow/domain/usecase/get_watchlist_tv.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc
    extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTv _getWatchlistTv;

  WatchlistTvBloc(this._getWatchlistTv)
      : super(WatchlistTvInitial()) {
    on<GetWatchlistTvEvent>((event, emit) async {
      emit(GetWatchlistTvLoading());

      final watchlistTv = await _getWatchlistTv.execute();

      watchlistTv.fold(
        (failure) {
          emit(GetWatchlistTvError(failure.message));
        },
        (moviesData) {
          if (moviesData.isEmpty) {
            emit(GetWatchlistTvEmpty());
          } else {
            emit(GetWatchlistTvHasData(moviesData));
          }
        },
      );
    });
  }
}
