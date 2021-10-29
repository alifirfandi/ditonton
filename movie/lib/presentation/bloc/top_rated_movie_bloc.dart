import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecase/get_top_rated_movies.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovieBloc(this._getTopRatedMovies) : super(TopRatedMovieInitial()) {
    on<TopRatedMovieEvent>((event, emit) async {
      emit(TopRatedMovieLoading());

      final popularMovies = await _getTopRatedMovies.execute();

      popularMovies.fold(
        (failure) {
          emit(TopRatedMovieError(failure.message));
        },
        (moviesData) {
          if (moviesData.isEmpty) {
            emit(TopRatedMovieEmpty());
          } else {
            emit(TopRatedMovieHasData(moviesData));
          }
        },
      );
    });
  }
}
