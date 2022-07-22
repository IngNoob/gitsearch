import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gitsearch/Services/db_handler.dart';
import 'package:gitsearch/Items/history_item.dart';
import 'package:sqflite/sqlite_api.dart';

class HistoryModel extends ChangeNotifier{

  final DBHandler _dbHandler = DBHandler();

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  List<HistoryItem> _history = [];
  UnmodifiableListView<HistoryItem> get history => UnmodifiableListView(_history);

  Future<void> debugOpen(Database db) async {
    if (Platform.environment.containsKey('FLUTTER_TEST')){
      _dbHandler.openTestDatabase(db);
    }
  }

  Future<void> openDb() async {
    await _dbHandler.initDatabase();
  }

  Future<void> getHistory() async {

    _isBusy = true;
    _history = [];
    notifyListeners();

    _history = await _getHistories();

    _isBusy = false;
    notifyListeners();

  }

  Future<List<HistoryItem>> _getHistories() async {
    return _dbHandler.getHistories();
  }


  Future<void> addToHistory(String? keyword) async {
    
    _isBusy = true;
    notifyListeners();

    final HistoryItem item = HistoryItem(keyword!);
    _dbHandler.updateOrInsertHistoryRecord(item);
    _history = await _getHistories();

    _isBusy = false;
    notifyListeners();

  }

  Future<void> deleteFromHistory(keyword) async {

    _isBusy = true;
    notifyListeners();

    final HistoryItem item = HistoryItem(keyword!);
    _dbHandler.deleteHistoryRecord(item);
    _history = await _getHistories();


    _isBusy = false;
    notifyListeners();
  }

  Future<void> emptyHistory() async {

    _isBusy = true;
    notifyListeners();

    _dbHandler.clearHistory();
    _history = [];

    _isBusy = false;
    notifyListeners();
  }

}