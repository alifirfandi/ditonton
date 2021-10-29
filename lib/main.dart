import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:core/core.dart';
import 'package:movie/domain/usecase/remove_watchlist_movie.dart';
import 'package:movie/movie.dart';
import 'package:about/about.dart';
import 'package:movie/presentation/bloc/detail_movie_bloc.dart';
import 'package:tvshow/tvshow.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularMovieBloc>(
          create: (BuildContext context) => PopularMovieBloc(
            di.locator<GetPopularMovies>(),
          ),
        ),
        BlocProvider<NowPlayingMovieBloc>(
          create: (BuildContext context) => NowPlayingMovieBloc(
            di.locator<GetNowPlayingMovies>(),
          ),
        ),
        BlocProvider<TopRatedMovieBloc>(
          create: (BuildContext context) => TopRatedMovieBloc(
            di.locator<GetTopRatedMovies>(),
          ),
        ),
        BlocProvider<DetailMovieBloc>(
          create: (BuildContext context) => DetailMovieBloc(
            di.locator<GetMovieDetail>(),
          ),
        ),
        BlocProvider<RecommendationMovieBloc>(
          create: (BuildContext context) => RecommendationMovieBloc(
            di.locator<GetMovieRecommendations>(),
          ),
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (BuildContext context) => WatchlistMovieBloc(
            di.locator<GetWatchlistMovies>(),
          ),
        ),
        BlocProvider<CheckWatchlistMovieBloc>(
          create: (BuildContext context) => CheckWatchlistMovieBloc(
            di.locator<GetWatchlistStatusMovie>(),
          ),
        ),
        BlocProvider<ActionWatchlistMovieBloc>(
          create: (BuildContext context) => ActionWatchlistMovieBloc(
            di.locator<SaveWatchlistMovie>(),
            di.locator<RemoveWatchlistMovie>(),
          ),
        ),
        BlocProvider<SearchMovieBloc>(
          create: (BuildContext context) => SearchMovieBloc(
            di.locator<SearchMovies>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: _title,
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: const HomePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HOME_PAGE:
              return MaterialPageRoute(builder: (_) => const HomePage());
            // case MOVIE_POPULAR_ROUTE:
            //   return MaterialPageRoute(builder: (_) => PopularMoviesPage());
            // case MOVIE_TOPRATED_ROUTE:
            //   return MaterialPageRoute(builder: (_) => TopRatedMoviesPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case MOVIE_SEARCH_ROUTE:
              return MaterialPageRoute(builder: (_) => SearchMoviePage());
            case MOVIE_WATCHLIST_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());

            // case HomeTvPage.ROUTE_NAME:
            //   return CupertinoPageRoute(builder: (_) => HomeTvPage());
            // case PopularTvPage.ROUTE_NAME:
            //   return CupertinoPageRoute(builder: (_) => PopularTvPage());
            // case TopRatedTvPage.ROUTE_NAME:
            //   return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            // case TvDetailPage.ROUTE_NAME:
            //   final id = settings.arguments as int;
            //   return MaterialPageRoute(
            //     builder: (_) => TvDetailPage(id: id),
            //     settings: settings,
            //   );
            // case SearchTvPage.ROUTE_NAME:
            //   return CupertinoPageRoute(builder: (_) => SearchTvPage());
            // case WatchlistTvPage.ROUTE_NAME:
            //   return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            // case AboutPage.ROUTE_NAME:
            //   return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    MoviePage(),
    TvshowPage(),
    AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ditonton'),
        centerTitle: true,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Tv Show',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
