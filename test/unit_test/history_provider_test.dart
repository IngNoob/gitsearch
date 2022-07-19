import 'package:gitsearch/Models/history_model.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  group('History(SQlite) provider tests:', (){
    test('Default values should be null or preset', () {

      final HistoryModel hModel = HistoryModel();

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

      // TestWidgetsFlutterBinding.ensureInitialized();

      // final HistoryModel hModel = HistoryModel();

      // //Database not opened/set up before operating
      // expect(() async => await hModel.getHistory(), throwsA(Exception()) );

      // // No error when setting up the database
      // expect(() async => await hModel.openDb(), returnsNormally );

    });

    test('Operating with the history database', () async {

      /*
        SQLite can't be tested due to problems with path and the likes
        https://github.com/tekartik/sqflite/issues/49
        https://github.com/tekartik/sqflite/issues/83
      */

      // TestWidgetsFlutterBinding.ensureInitialized();

      // final HistoryModel hModel = HistoryModel();

      // //Retrieve data, if any
      // await hModel.openDb();
      // await hModel.getHistory();
      // final int initLength = hModel.history.length;
      // expect(hModel.history.length, greaterThanOrEqualTo(0));

      // // Data is set up properly
      // expect(hModel.history[0].keyword, returnsNormally);
      // expect(hModel.history[0].searchDate, returnsNormally);

      // // New record gets added
      // expect(() async => await hModel.addToHistory("fluter_test"), returnsNormally);
      // expect(hModel.history.length, greaterThan(initLength));

      // // New record gets deleted
      // expect(() async => await hModel.deleteFromHistory("fluter_test"), returnsNormally);
      // expect(hModel.history.length, same(initLength));

      // // All records get deleted
      // expect(() async => await hModel.addToHistory("fluter_test1"), returnsNormally);
      // expect(() async => await hModel.addToHistory("fluter_test2"), returnsNormally);
      // expect(() async => await hModel.emptyHistory(), returnsNormally);
      // expect(hModel.history.length, same(0));

    });

  });

}