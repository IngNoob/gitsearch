import 'package:gitsearch/Common/globals.dart';
import 'package:gitsearch/Models/search_model.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  group('Search(API) provider tests:', (){
    test('Default values should be null or preset', () {

      final SearchModel sModel = SearchModel();

      // Start on res
      expect(sModel.isBusy, false);
      // Default query, no keyword input
      expect(sModel.queryParams.keyword, null);
      // Default results, nothing
      expect(sModel.searchResult.items, null);

    });
    test('Trying sample search', () async {

      final SearchModel sModel = SearchModel();

      // Search for own repository with own name, one single hit
      await sModel.doSearch('IngNoob/gitsearch');

      expect(sModel.searchResult.items!.length, 1);

    });

    test('Searching for next page', () async {

      final SearchModel sModel = SearchModel();

      // Search for own repository with own name, one single hit
      await sModel.doSearch('google');

      // Expecing for a full page to be received
      expect(sModel.searchResult.totalCount, greaterThanOrEqualTo(Globals.apiPerPageDefault));
      expect(sModel.searchResult.items!.length, Globals.apiPerPageDefault);

      await sModel.searchNext();

      // Expect for next page and for the total items to be more than before
      expect(sModel.queryParams.page,2);
      expect(sModel.searchResult.items!.length, greaterThan(Globals.apiPerPageDefault));

    });

  });

}