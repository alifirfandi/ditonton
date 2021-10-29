import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecase/get_movie_detail.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail _getMovieDetail;

  DetailMovieBloc(this._getMovieDetail) : super(DetailMovieInitial()) {
    on<GetDetailMovieEvent>((event, emit) async {
      emit(DetailMovieLoading());

      final detailResult = await _getMovieDetail.execute(event.idMovie);

      detailResult.fold(
        (failure) {
          emit(DetailMovieError(failure.message));
        },
        (movie) {
          emit(DetailMovieData(movie));
        },
      );
    });
  }
}
