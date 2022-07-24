// Dart imports:
import 'dart:developer';
import 'dart:ui';

// Package imports:
import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';

// Flutter imports:
import 'package:flutter/services.dart';

// Project imports:
import 'asset_loader.dart';

/*
  Original file from the easy_localization_loader 1.0.0 hasn't been updated in a long time
  so it has some incompatibilities with newer code. Therefore, accessing the github project at
  https://github.com/aissat/easy_localization_loader
  I can download the files and fix the small mistakes to make it work while waiting for the PR
  where it gets fixed.

  本物のコードをちょっと古くなったなので、新しいリリースを待ってるうちにリポジトリから
  必要なファイルを落として、コードを修正します。
*/

class CsvAssetLoader extends AssetLoader {
  CSVParser? csvParser;

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    if (csvParser != null) {
      log('easy localization loader: CSV parser already loaded, read cache');
    } else {
      log('easy localization loader: load csv file $path');
      csvParser = CSVParser(await rootBundle.loadString(path));
    }
    return csvParser!.getLanguageMap(locale.toString());
  }
}

class CSVParser {
  CSVParser(this.strings, {this.fieldDelimiter = ','})
      : lines = _convertN(const CsvToListConverter(
          csvSettingsDetector: FirstOccurrenceSettingsDetector(
            fieldDelimiters: <String>[',', ';'],
            textDelimiters: <String>['"', "'"],
            textEndDelimiters: <String>['"', "'"],
            eols: <String>['\n', '\r\n'],
          ),
        ).convert<dynamic>(strings, fieldDelimiter: fieldDelimiter));

  static List<List<dynamic>> _convertN(List<List<dynamic>> lines) {
    // converts //n to /n
    for (List<dynamic> lineList in lines) {
      lineList.asMap().forEach((int key, dynamic value) {
        if ((value is String) && value.contains('\\n')) {
          lineList[key] = value.replaceAll('\\n', '\n');
        }
      });
    }
    return lines;
  }

  final String fieldDelimiter;
  final String strings;
  final List<List<dynamic>> lines;

  List<dynamic> getLanguages() {
    return lines.first.sublist(1, lines.first.length);
  }

  Map<String, dynamic> getLanguageMap(String localeName) {
    final int indexLocale = lines.first.indexOf(localeName);

    final Map<String, dynamic> translations = <String, dynamic>{};
    for (int i = 1; i < lines.length; i++) {
      translations
          .addAll(<String, dynamic>{lines[i][0]: lines[i][indexLocale]});
    }
    return translations;
  }
}
