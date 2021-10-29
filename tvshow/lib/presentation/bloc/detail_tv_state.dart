part of 'detail_tv_bloc.dart';

@immutable
abstract class DetailTvState extends Equatable{
  const DetailTvState();

  @override
  List<Object> get props => [];
}

class DetailTvInitial extends DetailTvState {}

class DetailTvLoading extends DetailTvState {}

class DetailTvData extends DetailTvState {
  final TvDetail tvDetail;

  const DetailTvData(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class DetailTvError extends DetailTvState {
  final String message;

  const DetailTvError(this.message);

  @override
  List<Object> get props => [message];
}
