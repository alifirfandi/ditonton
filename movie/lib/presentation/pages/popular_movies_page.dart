import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/popular_movie_bloc.dart';
import 'package:movie/presentation/widget/movie_card.dart';
import 'package:movie/presentation/widget/movie_card_list.dart';

class PopularMoviesPage extends StatefulWidget {
  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<PopularMovieBloc>().add(GetPopularMovieEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
          builder: (context, state) {
            if (state is PopularMovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMovieHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.popularMovie[index];
                  return MovieCard(movie);
                },
                itemCount: state.popularMovie.length,
              );
            } else if (state is PopularMovieEmpty) {
              return const Text('No Popular Movies');
            } else if (state is PopularMovieError) {
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
