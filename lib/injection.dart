import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:core/core.dart';
import 'package:movie/movie.dart';
import 'package:tvshow/tvshow.dart';

import 'package:movie/data/datasource/db/database_helper_movie.dart';
import 'package:tvshow/data/datasource/db/database_helper_tv.dart';

import 'package:movie/data/datasource/movie_local_data_source.dart';
import 'package:movie/data/datasource/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

import 'package:tvshow/data/datasource/tv_local_data_source.dart';
import 'package:tvshow/data/datasource/tv_remote_data_source.dart';
import 'package:tvshow/data/repositories/tv_repository_impl.dart';
import 'package:tvshow/domain/repositories/tv_repository.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => PopularMovieBloc(locator()),
  );
  locator.registerFactory(
    () => NowPlayingMovieBloc(locator()),
  );
  locator.registerFactory(
    () => TopRatedMovieBloc(locator()),
  );
  locator.registerFactory(
    () => RecommendationMovieBloc(locator()),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(locator()),
  );
  locator.registerFactory(
    () => ActionWatchlistMovieBloc(locator(), locator()),
  );
  locator.registerFactory(
    () => CheckWatchlistMovieBloc(locator()),
  );
  locator.registerFactory(
    () => SearchMovieBloc(locator()),
  );

  locator.registerFactory(
    () => PopularTvBloc(locator()),
  );
  locator.registerFactory(
    () => NowPlayingTvBloc(locator()),
  );
  locator.registerFactory(
    () => TopRatedTvBloc(locator()),
  );
  locator.registerFactory(
    () => RecommendationTvBloc(locator()),
  );
  locator.registerFactory(
    () => WatchlistTvBloc(locator()),
  );
  locator.registerFactory(
    () => ActionWatchlistTvBloc(locator(), locator()),
  );
  locator.registerFactory(
    () => CheckWatchlistTvBloc(locator()),
  );
  locator.registerFactory(
    () => SearchTvBloc(locator()),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatusMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatusTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator
      .registerLazySingleton<DatabaseHelperMovie>(() => DatabaseHelperMovie());
  locator.registerLazySingleton<DatabaseHelperTv>(() => DatabaseHelperTv());

  // external
  locator.registerLazySingleton(() => http.Client());
}
