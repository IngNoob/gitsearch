
import 'package:flutter/material.dart';
import 'package:gitsearch/Pages/history_page_tab.dart';
import 'package:gitsearch/Pages/search_page_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<HomePage>{

  // Adding mixins for the tabcontroller and to preserve as much data as possible when changing tabs

  late TabController _tabController;
  final PageStorageKey _tabviewKey = const PageStorageKey('tabView');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: TabBarView(
        key: _tabviewKey,
        controller: _tabController,
        children: const [
          SearchPageTab(),
          HistoryPageTab()
        ]
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.primary,
        child: 
          TabBar(
            controller: _tabController,    
            indicatorWeight: 5,
            indicatorColor: Colors.white,
            tabs: const <Widget>[
              Tab(icon: Icon(Icons.search, size: 36)),
              Tab(icon: Icon(Icons.history, size: 36)),
            ],
          )
      )
    );
  }
  
 
}