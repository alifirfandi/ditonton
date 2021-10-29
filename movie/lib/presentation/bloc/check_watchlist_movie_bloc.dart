import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/usecase/get_watchlist_status_movie.dart';

part 'check_watchlist_movie_event.dart';
part 'check_watchlist_movie_state.dart';

class CheckWatchlistMovieBloc
    extends Bloc<CheckWatchlistMovieEvent, CheckWatchlistMovieState> {
  final GetWatchlistStatusMovie _getWatchListStatus;

  CheckWatchlistMovieBloc(this._getWatchListStatus) : super(CheckWatchlistMovieInitial()) {
    on<CheckWatchlistMovie>((event, emit) async {
      emit(CheckWatchlistMovieLoading());

      final result = await _getWatchListStatus.execute(event.idMovie);

      emit(CheckWatchlistMovieData(result));
    });
  }
}
