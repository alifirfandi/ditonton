import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tvshow/presentation/widget/tv_card.dart';

class TopRatedTvPage extends StatefulWidget {

  @override
  _TopRatedTvPageState createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TopRatedTvBloc>().add(GetTopRatedTvEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
          builder: (context, state) {
            if (state is TopRatedTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.topRatedTv[index];
                  return TvCard(tv);
                },
                itemCount: state.topRatedTv.length,
              );
            } else if (state is TopRatedTvEmpty) {
              return const Text('No Top Rated Tv');
            } else if (state is TopRatedTvError) {
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
