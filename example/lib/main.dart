import 'package:flutter/material.dart';

import 'package:fb_storage/fb_storage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  String _url;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: _loading ? CircularProgressIndicator() : Text(_url ?? ''),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.file_upload),
          onPressed: () {
            if (mounted)
              setState(() {
                _loading = true;
              });
            FbStorage().uploadString('{}', 'test.json').then((data) {
              if (mounted)
                setState(() {
                  _url = data;
                  _loading = false;
                });
            });
          },
        ),
      ),
    );
  }
}
