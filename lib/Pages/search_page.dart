import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<Widget> elements = [];

  @override
  void initState() {
    super.initState();
    final Random rng = Random();
    elements= List.generate(10, (index) => ListTile(title: const Text("Hello Vivi World"), tileColor: Color.fromRGBO(rng.nextInt(255), rng.nextInt(255), rng.nextInt(255), 1) ));
  }
   

  Future<void> _doSearch() async {
    
    final Uri uri = Uri.https(
      "api.github.com",
      'search/repositories',
      <String, String>{'q' : "hongkong" },
    );
    
    final Map<String, String> headers = <String, String>{
      'Accept': ' application/vnd.github+json',
    };


    final http.Response response = await http.get(
      uri,
      headers: headers,
    );

    final String body = utf8.decode(response.bodyBytes);

    final Map<String, dynamic> jsonMap = jsonDecode(body);

    elements.clear();
    final Random rng = Random();
    for (var item in jsonMap["items"]) {
      elements.add(ListTile(title: Text(item["full_name"]), tileColor: Color.fromRGBO(rng.nextInt(255), rng.nextInt(255), rng.nextInt(255), 1) ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: SingleChildScrollView(child: Column( children: elements)),
      floatingActionButton: FloatingActionButton(
        onPressed: _doSearch,
        tooltip: 'Search',
        child: const Icon(Icons.search),
      ),
    );
  }
}
