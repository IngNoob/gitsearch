import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Widget> elements = [];

  @override
  void initState() {
    super.initState();
    final Random rng = Random();
    elements= List.generate(10, (index) => ListTile(title: const Text("Hello Vivi World"), tileColor: Color.fromRGBO(rng.nextInt(255), rng.nextInt(255), rng.nextInt(255), 1) ));
  }
   

  Future<void> _doSearch() async {
    
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(child: Column( children: elements)),
      floatingActionButton: FloatingActionButton(
        onPressed: _doSearch,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


