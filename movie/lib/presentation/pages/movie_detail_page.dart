import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/check_watchlist_movie_bloc.dart';
import 'package:movie/presentation/bloc/detail_movie_bloc.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailMovieBloc>().add(GetDetailMovieEvent(widget.id));
      context
          .read<RecommendationMovieBloc>()
          .add(GetRecommendationMovieEvent(widget.id));
      context
          .read<CheckWatchlistMovieBloc>()
          .add(CheckWatchlistMovie(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
          builder: (context, state) {
        if (state is DetailMovieLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DetailMovieData) {
          return SafeArea(
            child: DetailContent(state.movieDetail),
          );
        } else if (state is DetailMovieError) {
          return Text(state.message);
        } else {
          return const Text('Unknown Error!');
        }
      }),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;

  DetailContent(this.movie);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            BlocBuilder<ActionWatchlistMovieBloc,
                                ActionWatchlistMovieState>(
                              builder: (ctx, stateAction) {
                                return BlocBuilder<CheckWatchlistMovieBloc,
                                    CheckWatchlistMovieState>(
                                  builder: (ctx, stateWatchlist) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        if (stateWatchlist
                                            is CheckWatchlistMovieData) {
                                          if (!stateWatchlist
                                              .isAddedWatchlist) {
                                            context
                                                .read<
                                                    ActionWatchlistMovieBloc>()
                                                .add(AddWatchlistMovie(movie));
                                          } else {
                                            context
                                                .read<
                                                    ActionWatchlistMovieBloc>()
                                                .add(DeleteWatchlistMovie(
                                                    movie));
                                          }
                                          context
                                              .read<CheckWatchlistMovieBloc>()
                                              .add(CheckWatchlistMovie(
                                                  movie.id));
                                        }
                                      },
                                      child: stateWatchlist
                                              is CheckWatchlistMovieLoading
                                          ? CircularProgressIndicator()
                                          : stateWatchlist
                                                  is CheckWatchlistMovieData
                                              ? Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    stateWatchlist
                                                            .isAddedWatchlist
                                                        ? Icon(Icons.check)
                                                        : Icon(Icons.add),
                                                    Text('Watchlist'),
                                                  ],
                                                )
                                              : Text("Error"),
                                    );
                                  },
                                );
                              },
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationMovieBloc,
                                    RecommendationMovieState>(
                                builder: (context, state) {
                              if (state is RecommendationMoviesLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is RecommendationMoviesEmpty) {
                                return Text("No Recommendation For this Movie");
                              } else if (state is RecommendationMoviesData) {
                                return Container(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final movie =
                                          state.recommendationMovies[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              MOVIE_DETAIL_ROUTE,
                                              arguments: movie.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount:
                                        state.recommendationMovies.length,
                                  ),
                                );
                              } else if (state is RecommendationMoviesError) {
                                return Text(state.message);
                              } else {
                                return const Text('Unknown Error!');
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
