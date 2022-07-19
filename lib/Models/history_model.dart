import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gitsearch/Common/db_handler.dart';
import 'package:gitsearch/Items/history_item.dart';

class HistoryModel extends ChangeNotifier{

  final DBHandler _dbHandler = DBHandler();

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  List<HistoryItem> _history = [];
  UnmodifiableListView<HistoryItem> get history => UnmodifiableListView(_history);

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

  Future<void> getHistoryNext() async {

    // _isBusy = true;
    // notifyListeners();

    

    // _isBusy = false;
    // notifyListeners();

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