import 'dart:io';

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
      rethrow;
    }

  }

  void openTestDatabase(db) {

    if (Platform.environment.containsKey('FLUTTER_TEST')){
      _db = db;
    }

  }

  void onCreate(Database instance, int version) async {
    await instance.execute(
      '''CREATE TABLE history (keyword TEXT PRIMARY KEY, search_date TEXT)'''
    );
  }

  Future<List<Map<String, dynamic>>> query(String table) async => _db!.query(table);

  Future<void> updateOrInsertHistoryRecord(var model) async {
    
    if (_db == null) {
      await initDatabase();
    }

    await _db!.execute("insert or replace into history ${model.itemParamsString()} values ${model.itemValuesString()}");    
  }


  Future<void> insertHistoryRecord(var model) async {

    if (_db == null) {
      await initDatabase();
    }
    await _db!.insert('history', model.toMap());
  }
  
  Future<void> updateHistoryRecord(var model) async {

    if (_db == null) {
      await initDatabase();
    }
    await _db!.update('history', model.toMap(), 
      where: 'keyword = ?', 
      whereArgs: [model.keyword]
    );
  }

  Future<void> deleteHistoryRecord(var model) async {

    if (_db == null) {
      await initDatabase();
    }
    await _db!.delete('history', 
      where: 'keyword = ?', 
      whereArgs: [model.keyword]
    );
  }

  Future<void> clearHistory() async {

    if (_db == null) {
      await initDatabase();
    }

    await _db!.delete('history', where: '1');
  }


  Future<List<HistoryItem>> getHistories() async {


    if (_db == null) {
      await initDatabase();
    }

    List<Map<String, dynamic>> maps = await _db!.query('history', orderBy: 'search_date DESC');

    return List.generate(maps.length, (i) {
      return HistoryItem.fromMap(maps[i]);
    });

  }

}