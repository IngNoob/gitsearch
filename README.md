# Gitsearch
Githubのリポジトリを検索できるアプリ

<p align="center">
<img src="https://github.com/IngNoob/gitsearch/blob/master/assets/images/splash_icon.png" width="400" height="400" />
</p>

## 基本機能：
    ＊リポジトリ検索（キーワード検索）
    ＊検索履歴
    ＊ダックテーマ対応
    ＊日本語／英語対応
    ＊画面回転レイアウト・様々な画面サイズ対応
    ＊マテリアルデザイン
    
## 開発環境：

Android とiOS、しかしiOS端末がないのため、確認できません。

Android はAPI16から対応です（Android4.1から）。

### Flutter

    [√] Flutter (Channel stable, 3.0.5, on Microsoft Windows [Versi¢n 10.0.19043.1826], locale es-ES)
    [√] Android toolchain - develop for Android devices (Android SDK version 33.0.0)
    
Dart2で開発したので、null_safetyを対応します。
Providerを使って、アプリ全体的に情報を提供して、ユーザーから入力した情報やGithubAPI結果をどこでも扱えます。

マインパッケージ：

        ＊ provider
        ＊ sqflite
        ＊ easy_localization
        ＊ http

## スクリーンショット 

クリックすると別タブで開けます
<p>
    <img src="https://i.imgur.com/b6skjAc.png" height="260"/>
    <img src="https://i.imgur.com/x7Qh6D6.png" height="260"/>
    <img src="https://i.imgur.com/Htvqxgl.png" height="260"/>
    <img src="https://i.imgur.com/s3iBfjH.png" height="260"/>
    <img src="https://i.imgur.com/B4pLysy.png" height="260"/>
    <img src="https://i.imgur.com/4WqWMGq.png" height="260"/>
</p>

## CI/CD

CI/CDのワークフローはGithubActionsから対応です。

実行例：https://github.com/IngNoob/gitsearch/actions/runs/2722850232

コードがプッシュされた時、自動テストやLint確認やコンパイルなどを起動します。さらにmasterブランチのPRを承認された場合は自動リリースを準備しておきます。ストアのアカウントは有料なので、その形で仮にデプロイします。

## Test

仮にUnit testとWidgetテストを対応します。Integrationテストも準備しておきました。
APIテストのためにMockito（https://pub.dev/packages/mockito)を準備しておきまして、様々な場合は確認できます。

例：

    test('Mocktail error response', () async {

      TestWidgetsFlutterBinding.ensureInitialized();

      when(mockGitHubService.repoSearch(argThat(isInstanceOf<SearchQuery>()))).thenAnswer( (invocation) async {
        if (invocation.positionalArguments[0].keyword == "error") throw Exception("error");
        return SearchResult.fromJson(sampleJson);           
      });

      bool res = await searchModel.doSearch("error");
      expect(res, false);
      expect(() async => await searchModel.doSearch('keyword'), returnsNormally);

    });


また、SQLiteにもMockします
https://github.com/tekartik/sqflite/blob/master/sqflite_common_ffi/doc/testing.md

## Github検索API

サイトに表示されるデータとAPIから取得するデータはちょっと違います。サポートフォーラムを参考して、様々なパラメターは昔結構違う意味がありましたので、サイトの改善からAPI更新されてないので、現在のデータと合わせません。


Watchers数　

    *　https://github.community/t/bug-watchers-count-is-the-duplicate-of-stargazers-count/140865

    *　https://developer.github.com/changes/2012-09-05-watcher-api/
    
検索結果ダブル

    *　https://github.com/Giphy/GiphyAPI/issues/235

検索結果件数

    *　https://stackoverflow.com/questions/55636683/why-api-github-search-dont-find-all-repositories
    

なので、実際のデータを確認するために、アプリからブラウザを開けます。