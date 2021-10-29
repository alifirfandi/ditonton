part of 'recommendation_tv_bloc.dart';

@immutable
abstract class RecommendationTvEvent extends Equatable{
  const RecommendationTvEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendationTvEvent extends RecommendationTvEvent {
  final idTv;

  GetRecommendationTvEvent(this.idTv);
}