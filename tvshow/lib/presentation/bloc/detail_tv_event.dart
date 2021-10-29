part of 'detail_tv_bloc.dart';

@immutable
abstract class DetailTvEvent extends Equatable {
  const DetailTvEvent();

  @override
  List<Object> get props => [];
}

class GetDetailTvEvent extends DetailTvEvent {
  final idTv;

  GetDetailTvEvent(this.idTv);
}
