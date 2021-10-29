import 'package:tvshow/data/models/tv_table.dart';
import 'package:tvshow/domain/entities/genre.dart';
import 'package:tvshow/domain/entities/season.dart';
import 'package:tvshow/domain/entities/tv.dart';
import 'package:tvshow/domain/entities/tv_detail.dart';

final testTv = Tv(
  backdropPath: '/75HgaphatW0PDI3XIHQWZUpbhn6.jpg',
  genreIds: [10765, 18, 9648, 80],
  id: 70523,
  originalName: 'Dark',
  overview:
      'A missing child causes four families to help each other for answers. What they could not imagine is that this mystery would be connected to innumerable other secrets of the small town.',
  popularity: 172.664,
  posterPath: '/nlTUgbZY1E4Dr5B25zLLkudIaV.jpg',
  firstAirDate: '2017-12-01',
  name: 'Dark',
  voteAverage: 8.4,
  voteCount: 4588,
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: '/75HgaphatW0PDI3XIHQWZUpbhn6.jpg',
  genres: [
    Genre(id: 10765, name: 'Sci-Fi & Fantasy'),
    Genre(id: 18, name: 'Drama'),
    Genre(id: 9648, name: 'Mystery'),
    Genre(id: 80, name: 'Crime'),
  ],
  id: 1,
  originalName: 'Dark',
  overview:
      'A missing child causes four families to help each other for answers. What they could not imagine is that this mystery would be connected to innumerable other secrets of the small town.',
  posterPath: '/nlTUgbZY1E4Dr5B25zLLkudIaV.jpg',
  firstAirDate: '2017-12-01',
  name: 'Dark',
  voteAverage: 8.4,
  voteCount: 4588,
  popularity: 172.664,
  seasons: [
    Season(
      id: 1,
      name: 'Season 1',
      episode: 10,
      overview: 'Overview',
      posterPath: '/spN6icwSwuAuOcuZLC9bKjK6N2i.jpg',
      seasonNumber: 1,
      airDate: '2017-12-01',
    )
  ],
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
