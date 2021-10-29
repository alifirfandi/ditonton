import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tvshow/domain/entities/tv.dart';
import 'package:tvshow/domain/usecase/search_tv.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTv _searchTv;

  @override
  Stream<Transition<SearchTvEvent, SearchTvState>> transformEvents(
    Stream<SearchTvEvent> events,
    TransitionFunction<SearchTvEvent, SearchTvState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  SearchTvBloc(this._searchTv) : super(SearchTvInitial()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchTvLoading());
      final result = await _searchTv.execute(query);

      result.fold(
        (failure) {
          emit(SearchTvError(failure.message));
        },
        (tvSearch) {
          if (tvSearch.isEmpty) {
            emit(SearchTvEmpty());
          } else {
            emit(SearchTvHasData(tvSearch));
          }
        },
      );
    });
  }
}
