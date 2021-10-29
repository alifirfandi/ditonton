part of 'check_watchlist_tv_bloc.dart';

@immutable
abstract class CheckWatchlistTvState extends Equatable {
  const CheckWatchlistTvState();

  @override
  List<Object> get props => [];
}

class CheckWatchlistTvInitial extends CheckWatchlistTvState {}

class CheckWatchlistTvLoading extends CheckWatchlistTvState {}

class CheckWatchlistTvData extends CheckWatchlistTvState {
  final bool isAddedWatchlist;

  const CheckWatchlistTvData(this.isAddedWatchlist);

  @override
  List<Object> get props => [isAddedWatchlist];
}

class CheckWatchlistTvError extends CheckWatchlistTvState {
  final String message;

  const CheckWatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}
