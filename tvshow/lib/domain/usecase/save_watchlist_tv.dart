import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tvshow/domain/entities/tv_detail.dart';
import 'package:tvshow/domain/repositories/tv_repository.dart';

class SaveWatchlistTv {
  final TvRepository repository;

  SaveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlist(tv);
  }
}
