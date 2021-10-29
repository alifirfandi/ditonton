import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/movie_repository.dart';
import '../entities/movie_detail.dart';

class RemoveWatchlistMovie {
  final MovieRepository repository;

  RemoveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
