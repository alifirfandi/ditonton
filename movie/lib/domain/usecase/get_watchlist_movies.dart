import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/movie_repository.dart';
import '../entities/movie.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
