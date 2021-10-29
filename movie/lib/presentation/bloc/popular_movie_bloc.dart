import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecase/get_popular_movies.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _getPopularMovies;

  PopularMovieBloc(this._getPopularMovies) : super(PopularMovieInitial()) {
    on<PopularMovieEvent>((event, emit) async {
      emit(PopularMovieLoading());

      final popularMovies = await _getPopularMovies.execute();

      popularMovies.fold(
        (failure) {
          emit(PopularMovieError(failure.message));
        },
        (moviesData) {
          if (moviesData.isEmpty) {
            emit(PopularMovieEmpty());
          } else {
            emit(PopularMovieHasData(moviesData));
          }
        },
      );
    });
  }
}
