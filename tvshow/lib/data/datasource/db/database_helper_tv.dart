import 'dart:async';

import 'package:core/core.dart';
import 'package:tvshow/data/models/tv_table.dart';

class DatabaseHelperTv {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertWatchlistTv(TvTable tv) async {
    final db = await _dbHelper.database;
    return await db!.insert(_dbHelper.tblWatchlistTv, tv.toJson());
  }

  Future<int> removeWatchlistTv(TvTable tv) async {
    final db = await _dbHelper.database;
    return await db!.delete(
      _dbHelper.tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getByTvId(int id) async {
    final db = await _dbHelper.database;
    final results = await db!.query(
      _dbHelper.tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> results =
        await db!.query(_dbHelper.tblWatchlistTv);

    return results;
  }
}
