import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gitsearch/Items/history_item.dart';

class DBHandler {

  Database? _db;
  String? _path;
  int get _version => 1;

  Future<void> initDatabase() async {

    try {
      _path = '${await getDatabasesPath()}/gitsearchdb';
      _db = await openDatabase(_path!, version: _version, onCreate: onCreate);
    }
    catch(ex) { 
      if (kDebugMode) {
        print(ex);
      }
    }

  }

  void onCreate(Database instance, int version) async {
    await instance.execute(
      '''CREATE TABLE history (keyword TEXT PRIMARY KEY, search_date TEXT)'''
    );
  }

  Future<List<Map<String, dynamic>>> query(String table) async => _db!.query(table);

  Future<void> updateOrInsertHistoryRecord(var model) async =>
      await _db!.execute("insert or replace into history ${model.itemParamsString()} values ${model.itemValuesString()}");


  Future<int> insertHistoryRecord(var model) async =>
      await _db!.insert('history', model.toMap());
  
  Future<int> updateHistoryRecord(var model) async =>
      await _db!.update('history', model.toMap(), 
        where: 'keyword = ?', 
        whereArgs: [model.keyword]
      );

  Future<int> deleteHistoryRecord(var model) async =>
      await _db!.delete('history', 
        where: 'keyword = ?', 
        whereArgs: [model.keyword]
      );

  Future<int> clearHistory() async =>
      await _db!.delete('history', where: '1');


  Future<List<HistoryItem>> getHistories() async {

    List<Map<String, dynamic>> maps = await _db!.query('history', orderBy: 'search_date DESC');

    return List.generate(maps.length, (i) {
      return HistoryItem.fromMap(maps[i]);
    });

  }

}