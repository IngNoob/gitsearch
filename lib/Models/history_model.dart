import 'dart:collection';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gitsearch/Common/utils.dart';
import 'package:gitsearch/Items/history_item.dart';
import 'package:gitsearch/Services/db_handler.dart';
import 'package:sqflite/sqlite_api.dart';

class HistoryModel extends ChangeNotifier{


  HistoryModel({
    required this.dbHandler,
    required this.exceptionCatcher
  });

  final DBHandler dbHandler;

  // This is a callback to a function that is gonna deal with the 
  // visual feedback to the user. We can leave it as an empty funcion
  // so that there's no feedback to the user or change it for another one to
  // choose different ways of how to provide said feedback
  final OnExceptionCatch exceptionCatcher;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  List<HistoryItem> _history = [];
  UnmodifiableListView<HistoryItem> get history => UnmodifiableListView(_history);

  Future<void> debugOpen(Database db) async {
    if (Platform.environment.containsKey('FLUTTER_TEST')){
      dbHandler.openTestDatabase(db);
    }
  }

  Future<void> openDb() async {
    _isBusy = true;
    notifyListeners();
    try{
      await dbHandler.initDatabase();
     }catch(e){
      
      // In case an error pops up we show a snackbar
      // with a message for it.

      String msg = e.toString();
      if (e.runtimeType != IOException){
        msg = 'errorGeneric'.tr(args: [msg]);
      }
      exceptionCatcher(msg);
    }
    _isBusy = false;
    notifyListeners();
  }

  Future<void> getHistory() async {

    _isBusy = true;
    _history = [];
    notifyListeners();

    try{

      _history = await dbHandler.getHistories();

    }catch(e){
      
      // In case an error pops up we show a snackbar
      // with a message for it.

      String msg = e.toString();
      if (e.runtimeType != IOException){
        msg = 'errorGeneric'.tr(args: [msg]);
      }
      exceptionCatcher(msg);
    }

    _isBusy = false;
    notifyListeners();

  }

  Future<void> addToHistory(String? keyword) async {
    
    _isBusy = true;
    notifyListeners();
    try{

      final HistoryItem item = HistoryItem(keyword!);
      dbHandler.updateOrInsertHistoryRecord(item);
      _history = await dbHandler.getHistories();

    }catch(e){

      // In case an error pops up we show a snackbar
      // with a message for it.

      String msg = e.toString();
      if (e.runtimeType != IOException){
        msg = 'errorGeneric'.tr(args: [msg]);
      }
      exceptionCatcher(msg);
    }

    _isBusy = false;
    notifyListeners();

  }

  Future<void> deleteFromHistory(keyword) async {

    _isBusy = true;
    notifyListeners();

    try{

      final HistoryItem item = HistoryItem(keyword!);
      dbHandler.deleteHistoryRecord(item);
      _history = await dbHandler.getHistories();

    }catch(e){
      // In case an error pops up we show a snackbar
      // with a message for it.
      String msg = e.toString();
      if (e.runtimeType != IOException){
        msg = 'errorGeneric'.tr(args: [msg]);
      }
      exceptionCatcher(msg);
    }

    _isBusy = false;
    notifyListeners();
  }

  Future<void> emptyHistory() async {

    _isBusy = true;
    notifyListeners();
    
    try{

      dbHandler.clearHistory();
      _history = [];

    }catch(e){
      // In case an error pops up we show a snackbar
      // with a message for it.
      String msg = e.toString();
      if (e.runtimeType != IOException){
        msg = 'errorGeneric'.tr(args: [msg]);
      }
      exceptionCatcher(msg);
    }

    _isBusy = false;
    notifyListeners();
  }

}