import 'package:equatable/equatable.dart';
import 'package:tvshow/domain/entities/season.dart';

class SeasonModel extends Equatable {
  SeasonModel({
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
  final String? posterPath;
  final int seasonNumber;
  final String? airDate;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json["id"],
        name: json["name"],
        episode: json["episode_count"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        airDate: json["air_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "episode_count": episode,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "air_date": airDate,
      };

  Season toEntity() {
    return Season(
      id: this.id,
      name: this.name,
      episode: this.episode,
      overview: this.overview,
      posterPath: this.posterPath ?? "",
      seasonNumber: this.seasonNumber,
      airDate: this.airDate ?? "-",
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        episode,
        overview,
        posterPath,
        seasonNumber,
        airDate,
      ];
}
