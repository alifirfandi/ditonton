import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/presentation/bloc/now_playing_tv_bloc.dart';
import 'package:tvshow/presentation/bloc/popular_tv_bloc.dart';
import 'package:tvshow/presentation/bloc/top_rated_tv_bloc.dart';

import '../widget/tv_card_list.dart';

class TvPage extends StatefulWidget {
  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTvBloc>().add(GetNowPlayingTvEvent());
      context.read<PopularTvBloc>().add(GetPopularTvEvent());
      context.read<TopRatedTvBloc>().add(GetTopRatedTvEvent());
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
                        Navigator.of(context).pushNamed(TVSHOW_WATCHLIST_ROUTE);
                      },
                      child: Text("TV Show Watchlist")),
                ),
                SizedBox(width: 25),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(TVSHOW_SEARCH_ROUTE);
                      },
                      child: Text("Search TV Show")),
                ),
              ],
            ),
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
                builder: (context, state) {
              if (state is NowPlayingTvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NowPlayingTvHasData) {
                return TvCardList(state.nowPlayingTv);
              } else if (state is NowPlayingTvError) {
                return Text(state.message);
              } else {
                return const Text('Unknown Error!');
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, TVSHOW_POPULAR_ROUTE),
            ),
            BlocBuilder<PopularTvBloc, PopularTvState>(
                builder: (context, state) {
              if (state is PopularTvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularTvHasData) {
                return TvCardList(state.popularTv);
              } else if (state is PopularTvError) {
                return Text(state.message);
              } else {
                return const Text('Unknown Error!');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, TVSHOW_TOPRATED_ROUTE),
            ),
            BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                builder: (context, state) {
              if (state is TopRatedTvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedTvHasData) {
                return TvCardList(state.topRatedTv);
              } else if (state is TopRatedTvError) {
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
