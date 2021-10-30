// Mocks generated by Mockito 5.0.15 from annotations
// in movie/test/presentation/bloc/action_watchlist_movie_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/core.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/domain/entities/movie_detail.dart' as _i7;
import 'package:movie/domain/repositories/movie_repository.dart' as _i2;
import 'package:movie/domain/usecase/remove_watchlist_movie.dart' as _i8;
import 'package:movie/domain/usecase/save_watchlist_movie.dart' as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeMovieRepository_0 extends _i1.Fake implements _i2.MovieRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [SaveWatchlistMovie].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistMovie extends _i1.Mock
    implements _i4.SaveWatchlistMovie {
  MockSaveWatchlistMovie() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i7.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [RemoveWatchlistMovie].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistMovie extends _i1.Mock
    implements _i8.RemoveWatchlistMovie {
  MockRemoveWatchlistMovie() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i7.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
  @override
  String toString() => super.toString();
}
