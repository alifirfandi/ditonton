import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tvshow/domain/entities/tv.dart';
import 'package:tvshow/domain/usecase/get_tv_recommendations.dart';


part 'recommendation_tv_event.dart';
part 'recommendation_tv_state.dart';

class RecommendationTvBloc
    extends Bloc<RecommendationTvEvent, RecommendationTvState> {
  final GetTvRecommendations _getTvRecommendations;

  RecommendationTvBloc(this._getTvRecommendations)
      : super(RecommendationTvInitial()) {
    on<GetRecommendationTvEvent>((event, emit) async {
      emit(RecommendationTvLoading());
      final recommendationResult =
          await _getTvRecommendations.execute(event.idTv);
      recommendationResult.fold(
        (failure) {
          emit(RecommendationTvError(failure.message));
        },
        (tv) {
          if (tv.isEmpty) {
            emit(RecommendationTvEmpty());
          } else {
            emit(RecommendationTvData(tv));
          }
        },
      );
    });
  }
}
