import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tvshow/domain/entities/tv_detail.dart';
import 'package:tvshow/domain/usecase/remove_watchlist_tv.dart';
import 'package:tvshow/domain/usecase/save_watchlist_tv.dart';

part 'action_watchlist_tv_event.dart';
part 'action_watchlist_tv_state.dart';

class ActionWatchlistTvBloc
    extends Bloc<ActionWatchlistTvEvent, ActionWatchlistTvState> {
  final SaveWatchlistTv _saveWatchlist;
  final RemoveWatchlistTv _removeWatchlist;

  ActionWatchlistTvBloc(
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(ActionWatchlistTvInitial()) {
    on<AddWatchlistTv>((event, emit) async {
      emit(AddWatchlistTvLoading());
      final result = await _saveWatchlist.execute(event.tvDetail);

      result.fold(
        (failure) {
          emit(AddWatchlistTvError(failure.message));
        },
        (tvData) {
          emit(AddWatchlistTvSuccess(tvData));
        },
      );
    });

    on<DeleteWatchlistTv>((event, emit) async {
      emit(DeleteWatchlistTvLoading());
      final result = await _removeWatchlist.execute(event.tvDetail);

      result.fold(
        (failure) {
          emit(DeleteWatchlistTvError(failure.message));
        },
        (tvData) {
          emit(DeleteWatchlistTvSuccess(tvData));
        },
      );
    });
  }
}
