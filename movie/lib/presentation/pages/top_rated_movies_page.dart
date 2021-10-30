import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:movie/presentation/widget/movie_card.dart';

class TopRatedMoviesPage extends StatefulWidget {
  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TopRatedMovieBloc>().add(GetTopRatedMovieEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
          builder: (context, state) {
            if (state is TopRatedMovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMovieHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.topRatedMovie[index];
                  return MovieCard(movie);
                },
                itemCount: state.topRatedMovie.length,
              );
            } else if (state is TopRatedMovieEmpty) {
              return const Text('No Top Rated Movies');
            } else if (state is TopRatedMovieError) {
              return Text(state.message);
            } else {
              return const Text('Unknown Error!');
            }
          },
        ),
      ),
    );
  }
}
