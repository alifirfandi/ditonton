import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tvshow/domain/usecase/get_watchlist_status_tv.dart';

part 'check_watchlist_tv_event.dart';
part 'check_watchlist_tv_state.dart';

class CheckWatchlistTvBloc
    extends Bloc<CheckWatchlistTvEvent, CheckWatchlistTvState> {
  final GetWatchlistStatusTv _getWatchListStatus;

  CheckWatchlistTvBloc(this._getWatchListStatus)
      : super(CheckWatchlistTvInitial()) {
    on<CheckWatchlistTv>((event, emit) async {
      emit(CheckWatchlistTvLoading());

      final result = await _getWatchListStatus.execute(event.idTv);

      emit(CheckWatchlistTvData(result));
    });
  }
}
