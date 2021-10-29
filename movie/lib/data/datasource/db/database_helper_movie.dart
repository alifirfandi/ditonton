import 'dart:async';

import 'package:core/core.dart';
import 'package:movie/data/models/movie_table.dart';

class DatabaseHelperMovie {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertWatchlistMovie(MovieTable movie) async {
    final db = await _dbHelper.database;
    return await db!.insert(_dbHelper.tblWatchlistMovie, movie.toJson());
  }

  Future<int> removeWatchlistMovie(MovieTable movie) async {
    final db = await _dbHelper.database;
    return await db!.delete(
      _dbHelper.tblWatchlistMovie,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getByMovieId(int id) async {
    final db = await _dbHelper.database;
    final results = await db!.query(
      _dbHelper.tblWatchlistMovie,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovie() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> results =
        await db!.query(_dbHelper.tblWatchlistMovie);

    return results;
  }
}
