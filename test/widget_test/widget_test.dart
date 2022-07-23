// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitsearch/Items/search_result.dart';
import 'package:gitsearch/Models/history_model.dart';
import 'package:gitsearch/Models/search_model.dart';
import 'package:gitsearch/Pages/search_page_tab.dart';
import 'package:gitsearch/Services/db_handler.dart';
import 'package:gitsearch/Services/github_service.dart';
import 'package:gitsearch/Widgets/search_result_item_card.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:gitsearch/Common/utils.dart' as utils;
import '../unit_test/search_provider_test.mocks.dart';

 
@GenerateMocks([GitHubService])
void main() async {

  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGitHubService mockGitHubService;
  late SearchModel searchModel;
  late HistoryModel historyModel;

  setUpAll((){
    mockGitHubService = MockGitHubService();
    searchModel = SearchModel(
      gitService: mockGitHubService,
      exceptionCatcher: utils.showErrorSnackbar
    );
    historyModel = HistoryModel(
      dbHandler: DBHandler(), 
      exceptionCatcher: utils.showErrorSnackbar
    );
  });
  

  testWidgets('Testing the search form widgets', (WidgetTester tester) async {

    when(mockGitHubService.repoSearch(any)).thenAnswer( (_) async => 
      SearchResult.fromJson({"total_count":1,"incomplete_results":false,"items":[{"id":512862280,"node_id":"R_kgDOHpGoSA","name":"gitsearch","full_name":"IngNoob/gitsearch","private":false,"owner":{"login":"IngNoob","id":105554453,"node_id":"U_kgDOBkqiFQ","avatar_url":null,"gravatar_id":"","url":"https://api.github.com/users/IngNoob","html_url":"https://github.com/IngNoob","followers_url":"https://api.github.com/users/IngNoob/followers","following_url":"https://api.github.com/users/IngNoob/following{/other_user}","gists_url":"https://api.github.com/users/IngNoob/gists{/gist_id}","starred_url":"https://api.github.com/users/IngNoob/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/IngNoob/subscriptions","organizations_url":"https://api.github.com/users/IngNoob/orgs","repos_url":"https://api.github.com/users/IngNoob/repos","events_url":"https://api.github.com/users/IngNoob/events{/privacy}","received_events_url":"https://api.github.com/users/IngNoob/received_events","type":"User","site_admin":false},"html_url":"https://github.com/IngNoob/gitsearch","description":"Githubのリポジトリを検索できるアプリ ","fork":false,"url":"https://api.github.com/repos/IngNoob/gitsearch","forks_url":"https://api.github.com/repos/IngNoob/gitsearch/forks","keys_url":"https://api.github.com/repos/IngNoob/gitsearch/keys{/key_id}","collaborators_url":"https://api.github.com/repos/IngNoob/gitsearch/collaborators{/collaborator}","teams_url":"https://api.github.com/repos/IngNoob/gitsearch/teams","hooks_url":"https://api.github.com/repos/IngNoob/gitsearch/hooks","issue_events_url":"https://api.github.com/repos/IngNoob/gitsearch/issues/events{/number}","events_url":"https://api.github.com/repos/IngNoob/gitsearch/events","assignees_url":"https://api.github.com/repos/IngNoob/gitsearch/assignees{/user}","branches_url":"https://api.github.com/repos/IngNoob/gitsearch/branches{/branch}","tags_url":"https://api.github.com/repos/IngNoob/gitsearch/tags","blobs_url":"https://api.github.com/repos/IngNoob/gitsearch/git/blobs{/sha}","git_tags_url":"https://api.github.com/repos/IngNoob/gitsearch/git/tags{/sha}","git_refs_url":"https://api.github.com/repos/IngNoob/gitsearch/git/refs{/sha}","trees_url":"https://api.github.com/repos/IngNoob/gitsearch/git/trees{/sha}","statuses_url":"https://api.github.com/repos/IngNoob/gitsearch/statuses/{sha}","languages_url":"https://api.github.com/repos/IngNoob/gitsearch/languages","stargazers_url":"https://api.github.com/repos/IngNoob/gitsearch/stargazers","contributors_url":"https://api.github.com/repos/IngNoob/gitsearch/contributors","subscribers_url":"https://api.github.com/repos/IngNoob/gitsearch/subscribers","subscription_url":"https://api.github.com/repos/IngNoob/gitsearch/subscription","commits_url":"https://api.github.com/repos/IngNoob/gitsearch/commits{/sha}","git_commits_url":"https://api.github.com/repos/IngNoob/gitsearch/git/commits{/sha}","comments_url":"https://api.github.com/repos/IngNoob/gitsearch/comments{/number}","issue_comment_url":"https://api.github.com/repos/IngNoob/gitsearch/issues/comments{/number}","contents_url":"https://api.github.com/repos/IngNoob/gitsearch/contents/{+path}","compare_url":"https://api.github.com/repos/IngNoob/gitsearch/compare/{base}...{head}","merges_url":"https://api.github.com/repos/IngNoob/gitsearch/merges","archive_url":"https://api.github.com/repos/IngNoob/gitsearch/{archive_format}{/ref}","downloads_url":"https://api.github.com/repos/IngNoob/gitsearch/downloads","issues_url":"https://api.github.com/repos/IngNoob/gitsearch/issues{/number}","pulls_url":"https://api.github.com/repos/IngNoob/gitsearch/pulls{/number}","milestones_url":"https://api.github.com/repos/IngNoob/gitsearch/milestones{/number}","notifications_url":"https://api.github.com/repos/IngNoob/gitsearch/notifications{?since,all,participating}","labels_url":"https://api.github.com/repos/IngNoob/gitsearch/labels{/name}","releases_url":"https://api.github.com/repos/IngNoob/gitsearch/releases{/id}","deployments_url":"https://api.github.com/repos/IngNoob/gitsearch/deployments","created_at":"2022-07-11T18:09:38Z","updated_at":"2022-07-11T18:14:03Z","pushed_at":"2022-07-22T21:46:34Z","git_url":"git://github.com/IngNoob/gitsearch.git","ssh_url":"git@github.com:IngNoob/gitsearch.git","clone_url":"https://github.com/IngNoob/gitsearch.git","svn_url":"https://github.com/IngNoob/gitsearch","homepage":"","size":1964,"stargazers_count":0,"watchers_count":0,"language":"Dart","has_issues":true,"has_projects":true,"has_downloads":true,"has_wiki":true,"has_pages":false,"forks_count":0,"mirror_url":null,"archived":false,"disabled":false,"open_issues_count":0,"license":null,"allow_forking":true,"is_template":false,"web_commit_signoff_required":false,"topics":[],"visibility":"public","forks":0,"open_issues":0,"watchers":0,"default_branch":"master","score":1.0}]})
    );

    await tester.pumpWidget( 
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => searchModel),
        ChangeNotifierProvider(create: (context) => historyModel)
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
    await tester.enterText(find.byType(TextFormField), "IngNoob/gitsearch");

    var searchBtn = find.byKey(const Key('searchBtn'));    
    expect(searchBtn, findsOneWidget);
    await tester.tap(searchBtn);

    // Waiting for the API call to complete
    await tester.pumpAndSettle();
    await tester.pump();

    // Check that the button was pressed and the result widget was drawn
    expect(find.byType(SearchResultItemCard), findsOneWidget);

  });
}
