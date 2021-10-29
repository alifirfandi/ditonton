part of 'watchlist_tv_bloc.dart';

@immutable
abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTvInitial extends WatchlistTvState {}

class GetWatchlistTvLoading extends WatchlistTvState {}

class GetWatchlistTvEmpty extends WatchlistTvState {}

class GetWatchlistTvHasData extends WatchlistTvState {
  final List<Tv> tv;

  const GetWatchlistTvHasData(this.tv);

  @override
  List<Object> get props => [tv];
}

class GetWatchlistTvError extends WatchlistTvState {
  final String message;

  const GetWatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}
