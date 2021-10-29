import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

import '../widget/movie_card_list.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMovieBloc>().add(GetNowPlayingMovieEvent());
      context.read<PopularMovieBloc>().add(GetPopularMovieEvent());
      context.read<TopRatedMovieBloc>().add(GetTopRatedMovieEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(MOVIE_WATCHLIST_ROUTE);
                      },
                      child: Text("Movie Watchlist")),
                ),
                SizedBox(width: 25),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(MOVIE_SEARCH_ROUTE);
                      },
                      child: Text("Search Movie")),
                ),
              ],
            ),
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
                builder: (context, state) {
              if (state is NowPlayingMovieLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NowPlayingMovieHasData) {
                return MovieCardList(state.nowPlayingMovie);
              } else if (state is NowPlayingMovieError) {
                return Text(state.message);
              } else {
                return const Text('Unknown Error!');
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, MOVIE_POPULAR_ROUTE),
            ),
            BlocBuilder<PopularMovieBloc, PopularMovieState>(
                builder: (context, state) {
              if (state is PopularMovieLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularMovieHasData) {
                return MovieCardList(state.popularMovie);
              } else if (state is PopularMovieError) {
                return Text(state.message);
              } else {
                return const Text('Unknown Error!');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, MOVIE_TOPRATED_ROUTE),
            ),
            BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
                builder: (context, state) {
              if (state is TopRatedMovieLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedMovieHasData) {
                return MovieCardList(state.topRatedMovie);
              } else if (state is TopRatedMovieError) {
                return Text(state.message);
              } else {
                return const Text('Unknown Error!');
              }
            }),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
