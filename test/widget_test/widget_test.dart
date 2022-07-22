// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitsearch/Items/owner.dart';
import 'package:gitsearch/Items/search_query.dart';
import 'package:gitsearch/Items/search_result.dart';
import 'package:gitsearch/Items/search_result_item.dart';
import 'package:gitsearch/Models/history_model.dart';
import 'package:gitsearch/Models/search_model.dart';
import 'package:gitsearch/Pages/search_page_tab.dart';
import 'package:gitsearch/Services/github_service.dart';
import 'package:gitsearch/Widgets/search_result_item_card.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';


 
class MockGitHubService extends Mock implements GitHubService {}

void main() async {

  late MockGitHubService mockGitHubService;

  setUpAll((){
    mockGitHubService = MockGitHubService();
    
    when(() => mockGitHubService.repoSearch(SearchQuery(keyword: "test"))).thenAnswer( (_) async => 
      Future.value(SearchResult(
        totalCount: 1,
        incompleteResults: false,
        items: [
          SearchResultItem(
            name: "gitsearch",
            owner: Owner(
              avatarUrl: "https://avatars.githubusercontent.com/u/105554453?v=4"
            )
          ),
        ]
      )      
    ));
  });
  

  testWidgets('Testing the search form', (WidgetTester tester) async {
    await tester.runAsync(() async {

      SearchModel searchModel = SearchModel(mockGitHubService);

      await tester.pumpWidget( 
        MultiProvider(providers: [
          ChangeNotifierProvider(create: (context) => searchModel),
          ChangeNotifierProvider(create: (context) => HistoryModel())
        ],
        child: const MaterialApp( 
            home: SearchPageTab()
          )
        ), const Duration(seconds: 1)
      );

      // On the page
      expect(find.text('welcomeSearch'), findsOneWidget);

      // Input and press search
      expect(find.byType(TextFormField), findsOneWidget);
      //await tester.enterText(find.byType(TextFormField), "IngNoob/gitsearch");
      await tester.enterText(find.byType(TextFormField), "test");

      var searchBtn = find.byKey(const Key('searchBtn'));    
      expect(searchBtn, findsOneWidget);
      //await tester.tap(searchBtn);

      await searchModel.doSearch("test");
      print(searchModel.searchResult);

      // Waiting for the API call to complete
      await tester.pumpAndSettle();
      await tester.pump();

      // //See that there are query results
      expect(find.byType(SearchResultItemCard), findsWidgets);

    });
  });

}
