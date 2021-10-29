part of 'check_watchlist_tv_bloc.dart';

@immutable
abstract class CheckWatchlistTvEvent extends Equatable {
  const CheckWatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class CheckWatchlistTv extends CheckWatchlistTvEvent {
  final int idTv;

  const CheckWatchlistTv(this.idTv);

  @override
  List<Object> get props => [idTv];
}
