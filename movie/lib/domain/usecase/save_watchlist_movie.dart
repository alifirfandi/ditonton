import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/movie_repository.dart';
import '../entities/movie_detail.dart';

class SaveWatchlistMovie {
  final MovieRepository repository;

  SaveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
