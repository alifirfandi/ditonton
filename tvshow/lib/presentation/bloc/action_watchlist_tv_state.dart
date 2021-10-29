part of 'action_watchlist_tv_bloc.dart';

@immutable
abstract class ActionWatchlistTvState extends Equatable {
  const ActionWatchlistTvState();

  @override
  List<Object> get props => [];
}

class ActionWatchlistTvInitial extends ActionWatchlistTvState {}

class AddWatchlistTvLoading extends ActionWatchlistTvState {}

class AddWatchlistTvSuccess extends ActionWatchlistTvState {
  final String tvData;

  const AddWatchlistTvSuccess(this.tvData);

  @override
  List<Object> get props => [tvData];
}

class AddWatchlistTvError extends ActionWatchlistTvState {
  final String message;

  const AddWatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteWatchlistTvLoading extends ActionWatchlistTvState {}

class DeleteWatchlistTvSuccess extends ActionWatchlistTvState {
  final String tvData;

  const DeleteWatchlistTvSuccess(this.tvData);

  @override
  List<Object> get props => [tvData];
}

class DeleteWatchlistTvError extends ActionWatchlistTvState {
  final String message;

  const DeleteWatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}
