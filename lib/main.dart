import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:core/core.dart';
import 'package:movie/domain/usecase/remove_watchlist_movie.dart';
import 'package:movie/movie.dart';
import 'package:about/about.dart';
import 'package:tvshow/tvshow.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
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
        BlocProvider<PopularTvBloc>(
          create: (BuildContext context) => PopularTvBloc(
            di.locator<GetPopularTv>(),
          ),
        ),
        BlocProvider<NowPlayingTvBloc>(
          create: (BuildContext context) => NowPlayingTvBloc(
            di.locator<GetNowPlayingTv>(),
          ),
        ),
        BlocProvider<TopRatedTvBloc>(
          create: (BuildContext context) => TopRatedTvBloc(
            di.locator<GetTopRatedTv>(),
          ),
        ),
        BlocProvider<DetailTvBloc>(
          create: (BuildContext context) => DetailTvBloc(
            di.locator<GetTvDetail>(),
          ),
        ),
        BlocProvider<RecommendationTvBloc>(
          create: (BuildContext context) => RecommendationTvBloc(
            di.locator<GetTvRecommendations>(),
          ),
        ),
        BlocProvider<WatchlistTvBloc>(
          create: (BuildContext context) => WatchlistTvBloc(
            di.locator<GetWatchlistTv>(),
          ),
        ),
        BlocProvider<CheckWatchlistTvBloc>(
          create: (BuildContext context) => CheckWatchlistTvBloc(
            di.locator<GetWatchlistStatusTv>(),
          ),
        ),
        BlocProvider<ActionWatchlistTvBloc>(
          create: (BuildContext context) => ActionWatchlistTvBloc(
            di.locator<SaveWatchlistTv>(),
            di.locator<RemoveWatchlistTv>(),
          ),
        ),
        BlocProvider<SearchTvBloc>(
          create: (BuildContext context) => SearchTvBloc(
            di.locator<SearchTv>(),
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
        navigatorObservers: [routeObserver],
        home: const HomePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HOME_PAGE:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case MOVIE_POPULAR_ROUTE:
              return MaterialPageRoute(builder: (_) => PopularMoviesPage());
            case MOVIE_TOPRATED_ROUTE:
              return MaterialPageRoute(builder: (_) => TopRatedMoviesPage());
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
            case TVSHOW_POPULAR_ROUTE:
              return MaterialPageRoute(builder: (_) => PopularTvPage());
            case TVSHOW_TOPRATED_ROUTE:
              return MaterialPageRoute(builder: (_) => TopRatedTvPage());
            case TVSHOW_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case TVSHOW_SEARCH_ROUTE:
              return MaterialPageRoute(builder: (_) => SearchTvPage());
            case TVSHOW_WATCHLIST_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
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
    TvPage(),
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
