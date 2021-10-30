import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tvshow/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:tvshow/presentation/widget/tv_card.dart';

class WatchlistTvPage extends StatefulWidget {
  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<WatchlistTvBloc>().add(GetWatchlistTvEvent()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvBloc>().add(GetWatchlistTvEvent());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<WatchlistTvBloc>().add(GetWatchlistTvEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
            builder: (context, state) {
          if (state is GetWatchlistTvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetWatchlistTvEmpty) {
            return Center(
              child: Text("No Watchlist Tv"),
            );
          } else if (state is GetWatchlistTvHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.tv[index];
                return TvCard(movie);
              },
              itemCount: state.tv.length,
            );
          } else if (state is GetWatchlistTvError) {
            return Text(state.message);
          } else {
            return const Text('Unknown Error!');
          }
        }),
      ),
    );
  }
}
