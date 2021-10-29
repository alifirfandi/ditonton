import 'package:equatable/equatable.dart';

class Season extends Equatable {
  Season({
    required this.id,
    required this.name,
    required this.episode,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.airDate,
  });

  final int id;
  final String name;
  final int episode;
  final String overview;
  final String posterPath;
  final int seasonNumber;
  final String airDate;

  @override
  List<Object> get props => [
        id,
        name,
        episode,
        overview,
        posterPath,
        seasonNumber,
        airDate,
      ];
}
