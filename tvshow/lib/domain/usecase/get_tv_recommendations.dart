import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tvshow/domain/entities/tv.dart';
import 'package:tvshow/domain/repositories/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
