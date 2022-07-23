import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitsearch/Widgets/search_result_item_card.dart';

import 'package:gitsearch/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

group('Integration tests', () {
  testWidgets('Do search', (tester) async {
    app.main();
    await tester.pumpAndSettle(Duration(seconds: 5));
    
    //Start the application and try
    expect(find.byType(TextFormField), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), "IngNoob/gitsearch");

    var searchBtn = find.byKey(const Key('searchBtn'));    
    expect(searchBtn, findsOneWidget);
    await tester.tap(searchBtn);

    // Waiting for the API call to complete
    await tester.pumpAndSettle();
    await tester.pump();

    // Check that the button was pressed and the result widget was drawn
    expect(find.byType(SearchResultItemCard), findsOneWidget);

    await tester.pumpAndSettle(Duration(seconds: 5));

    });
  });
}
