import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tvshow/domain/entities/genre.dart';
import 'package:tvshow/domain/entities/season.dart';
import 'package:tvshow/domain/entities/tv_detail.dart';
import 'package:tvshow/presentation/bloc/action_watchlist_tv_bloc.dart';
import 'package:tvshow/presentation/bloc/check_watchlist_tv_bloc.dart';
import 'package:tvshow/presentation/bloc/detail_tv_bloc.dart';
import 'package:tvshow/presentation/bloc/recommendation_tv_bloc.dart';

class TvDetailPage extends StatefulWidget {
  final int id;
  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailTvBloc>().add(GetDetailTvEvent(widget.id));
      context
          .read<RecommendationTvBloc>()
          .add(GetRecommendationTvEvent(widget.id));
      context.read<CheckWatchlistTvBloc>().add(CheckWatchlistTv(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTvBloc, DetailTvState>(builder: (context, state) {
        if (state is DetailTvLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DetailTvData) {
          return SafeArea(
            child: DetailContent(state.tvDetail),
          );
        } else if (state is DetailTvError) {
          return Text(state.message);
        } else {
          return const Text('Unknown Error!');
        }
      }),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tv;

  DetailContent(this.tv);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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
                              tv.name,
                              style: kHeading5,
                            ),
                            BlocBuilder<ActionWatchlistTvBloc,
                                ActionWatchlistTvState>(
                              builder: (ctx, stateAction) {
                                return BlocBuilder<CheckWatchlistTvBloc,
                                    CheckWatchlistTvState>(
                                  builder: (ctx, stateWatchlist) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        if (stateWatchlist
                                            is CheckWatchlistTvData) {
                                          if (!stateWatchlist
                                              .isAddedWatchlist) {
                                            context
                                                .read<ActionWatchlistTvBloc>()
                                                .add(AddWatchlistTv(tv));
                                          } else {
                                            context
                                                .read<ActionWatchlistTvBloc>()
                                                .add(DeleteWatchlistTv(tv));
                                          }
                                          context
                                              .read<CheckWatchlistTvBloc>()
                                              .add(CheckWatchlistTv(tv.id));
                                        }
                                      },
                                      child: stateWatchlist
                                              is CheckWatchlistTvLoading
                                          ? CircularProgressIndicator()
                                          : stateWatchlist
                                                  is CheckWatchlistTvData
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
                              _showGenres(tv.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            _showSeasons(context, tv.seasons),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationTvBloc,
                                    RecommendationTvState>(
                                builder: (context, state) {
                              if (state is RecommendationTvLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is RecommendationTvEmpty) {
                                return Text("No Recommendation For this Tv");
                              } else if (state is RecommendationTvData) {
                                return Container(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final tv = state.recommendationTv[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              TVSHOW_DETAIL_ROUTE,
                                              arguments: tv.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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
                                    itemCount: state.recommendationTv.length,
                                  ),
                                );
                              } else if (state is RecommendationTvError) {
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

  Widget _showSeasons(BuildContext context, List<Season> seasons) {
    return Container(
      color: Colors.black45,
      height: 110,
      child: ListView.builder(
        itemCount: seasons.length,
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (seasons.length == 0) return Text("No Season Found");
          return ListTile(
            isThreeLine: true,
            leading: CachedNetworkImage(
              width: 100,
              fit: BoxFit.cover,
              imageUrl:
                  'https://image.tmdb.org/t/p/w500${seasons[index].posterPath}',
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text(
              seasons[index].name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Episode : ${seasons[index].episode}',
                ),
                Text(
                  'Release Date : ${seasons[index].airDate}',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
