import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/movie_repository.dart';
import '../entities/movie.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
