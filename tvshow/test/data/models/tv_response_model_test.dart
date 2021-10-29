import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tvshow/data/models/tv_model.dart';
import 'package:tvshow/data/models/tv_response.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
    genreIds: [10765, 35, 80],
    id: 90462,
    originalName: "Chucky",
    overview:
        "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the towns hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chuckys past threatens to expose the truth behind the killings, as well as the demon dolls untold origins.",
    popularity: 5323.848,
    posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
    firstAirDate: "2021-10-12",
    name: "Chucky",
    voteAverage: 8.1,
    voteCount: 808,
  );
  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
            "genre_ids": [10765, 35, 80],
            "id": 90462,
            "original_name": "Chucky",
            "overview":
                "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the towns hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chuckys past threatens to expose the truth behind the killings, as well as the demon dolls untold origins.",
            "popularity": 5323.848,
            "poster_path": "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
            "first_air_date": "2021-10-12",
            "name": "Chucky",
            "vote_average": 8.1,
            "vote_count": 808,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
