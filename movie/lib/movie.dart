library movie;

export 'domain/entities/genre.dart';
export 'domain/entities/movie.dart';
export 'domain/entities/movie_detail.dart';

export 'domain/repositories/movie_repository.dart';

export 'domain/usecase/get_movie_detail.dart';
export 'domain/usecase/get_movie_recommendations.dart';
export 'domain/usecase/get_now_playing_movies.dart';
export 'domain/usecase/get_popular_movies.dart';
export 'domain/usecase/get_top_rated_movies.dart';
export 'domain/usecase/get_watchlist_movies.dart';
export 'domain/usecase/get_watchlist_status_movie.dart';
export 'domain/usecase/save_watchlist_movie.dart';
export 'domain/usecase/remove_watchlist_movie.dart';
export 'domain/usecase/search_movies.dart';

export 'presentation/bloc/popular_movie_bloc.dart';
export 'presentation/bloc/now_playing_movie_bloc.dart';
export 'presentation/bloc/top_rated_movie_bloc.dart';
export 'presentation/bloc/recommendation_movie_bloc.dart';
export 'presentation/bloc/watchlist_movie_bloc.dart';
export 'presentation/bloc/action_watchlist_movie_bloc.dart';
export 'presentation/bloc/check_watchlist_movie_bloc.dart';
export 'presentation/bloc/search_movie_bloc.dart';
export 'presentation/bloc/detail_movie_bloc.dart';

export 'presentation/pages/movie_detail_page.dart';
export 'presentation/pages/movie_page.dart';
export 'presentation/pages/popular_movies_page.dart';
export 'presentation/pages/search_movie_page.dart';
export 'presentation/pages/top_rated_movies_page.dart';
export 'presentation/pages/watchlist_movies_page.dart';

