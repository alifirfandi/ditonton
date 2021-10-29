import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecase/remove_watchlist_movie.dart';
import 'package:movie/domain/usecase/save_watchlist_movie.dart';

part 'action_watchlist_movie_event.dart';
part 'action_watchlist_movie_state.dart';

class ActionWatchlistMovieBloc
    extends Bloc<ActionWatchlistMovieEvent, ActionWatchlistMovieState> {
  final SaveWatchlistMovie _saveWatchlist;
  final RemoveWatchlistMovie _removeWatchlist;

  ActionWatchlistMovieBloc(
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(ActionWatchlistMovieInitial()) {
    on<AddWatchlistMovie>((event, emit) async {
      emit(AddWatchlistMovieLoading());
      final result = await _saveWatchlist.execute(event.movieDetail);

      result.fold(
        (failure) {
          emit(AddWatchlistMovieError(failure.message));
        },
        (movieData) {
          emit(AddWatchlistMovieSuccess(movieData));
        },
      );
    });

    on<DeleteWatchlistMovie>((event, emit) async {
      emit(DeleteWatchlistMovieLoading());
      final result = await _removeWatchlist.execute(event.movieDetail);

      result.fold(
        (failure) {
          emit(DeleteWatchlistMovieError(failure.message));
        },
        (movieData) {
          emit(DeleteWatchlistMovieSuccess(movieData));
        },
      );
    });
  }
}
