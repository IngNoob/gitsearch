import 'package:flutter_test/flutter_test.dart';
import 'package:gitsearch/Models/history_model.dart';
import 'package:gitsearch/Services/db_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() async {

  sqfliteFfiInit();

  group('History(SQlite) provider tests:', (){
    test('Default values should be null or preset', () {

      final HistoryModel hModel = HistoryModel(dbHandler: DBHandler(), exceptionCatcher: (String errorMsg) {});

      // Start on res
      expect(hModel.isBusy, false);
      // Default results, nothing
      expect(hModel.history, []);

    });

    test('Opening database', () async {

      /*
        SQLite can't be tested due to problems with path and the likes
        https://github.com/tekartik/sqflite/issues/49
        https://github.com/tekartik/sqflite/issues/83
      */

      TestWidgetsFlutterBinding.ensureInitialized();

      final HistoryModel hModel = HistoryModel(dbHandler: DBHandler(), exceptionCatcher: (String errorMsg) {});

      //Database not opened/set up before operating
      //expect(() async => await hModel.getHistory(), throwsA(CastError()) );

      var db = await databaseFactoryFfi.openDatabase("gitsearchdb_ffi", 
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (Database instance, int version) async {
            await instance.execute(
              '''CREATE TABLE history (keyword TEXT PRIMARY KEY, search_date TEXT)'''
            );
          }
        )
      );

      // No error when setting up the database
      expect(() async => await hModel.debugOpen(db), returnsNormally );

      db.close();

    });

    test('Operating with the history database', () async {

      /*
        SQLite can't be tested due to problems with path and the likes
        https://github.com/tekartik/sqflite/issues/49
        https://github.com/tekartik/sqflite/issues/83
      */

      TestWidgetsFlutterBinding.ensureInitialized();

      final HistoryModel hModel = HistoryModel(dbHandler: DBHandler(), exceptionCatcher: (String errorMsg) {});

      var db = await databaseFactoryFfi.openDatabase("gitsearchdb_ffi", 
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (Database instance, int version) async {
          await instance.execute(
            '''CREATE TABLE history (keyword TEXT PRIMARY KEY, search_date TEXT)'''
          );
         }
      ));

      //Retrieve data, if any
      await hModel.debugOpen(db);

      expect(() async => await hModel.emptyHistory(), returnsNormally);
      expect(hModel.history.length, same(0));

      // Make sure database starts of empty
      await hModel.getHistory();
      final int initLength = hModel.history.length;
      expect(hModel.history.length, equals(0));

      // New record gets added
      expect(() async => await hModel.addToHistory("fluter_test"), returnsNormally);
      await hModel.getHistory();
      expect(hModel.history.length, greaterThan(initLength));

      // Data is set up properly
      expect(hModel.history[0].keyword, isNotEmpty);
      expect(hModel.history[0].searchDate, isNotEmpty);

      // New record gets added
      expect(() async => await hModel.addToHistory("fluter_test2"), returnsNormally);
      await hModel.getHistory();            
      expect(hModel.history.length, greaterThan(initLength));

      // New record gets deleted
      expect(() async => await hModel.deleteFromHistory("fluter_test"), returnsNormally);
      await hModel.getHistory();                  
      expect(hModel.history.length, greaterThan(initLength));

      // All records get deleted
      expect(() async => await hModel.addToHistory("fluter_test3"), returnsNormally);
      expect(() async => await hModel.addToHistory("fluter_test4"), returnsNormally);
      expect(() async => await hModel.emptyHistory(), returnsNormally);
      await hModel.getHistory();                  
      expect(hModel.history.length, same(0));

      db.close();

    });

  });

}