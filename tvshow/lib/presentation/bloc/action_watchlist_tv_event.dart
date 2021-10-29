part of 'action_watchlist_tv_bloc.dart';

@immutable
abstract class ActionWatchlistTvEvent extends Equatable {
  const ActionWatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistTv extends ActionWatchlistTvEvent {
  final TvDetail tvDetail;

  const AddWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class DeleteWatchlistTv extends ActionWatchlistTvEvent {
  final TvDetail tvDetail;

  const DeleteWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
