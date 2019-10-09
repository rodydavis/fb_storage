import 'package:fb_storage/fb_storage.dart';
import 'package:flutter/material.dart';

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
          title: const Text('Unify Connect Admin'),
        ),
        body: Center(
          child:
              _loading ? CircularProgressIndicator() : Text(_url ?? 'No Url'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.file_upload),
          onPressed: () {
            _uploadFile();
          },
        ),
      ),
    );
  }

  void _uploadImage() {
    if (mounted)
      setState(() {
        _loading = true;
      });
    FbStorage().pickUploadPhoto().then((data) {
      if (mounted)
        setState(() {
          _url = data;
          _loading = false;
        });
    });
  }

  void _uploadVideo() {
    if (mounted)
      setState(() {
        _loading = true;
      });
    FbStorage().pickUploadVideo().then((data) {
      if (mounted)
        setState(() {
          _url = data;
          _loading = false;
        });
    });
  }

  void _uploadFile() {
    if (mounted)
      setState(() {
        _loading = true;
      });
    FbStorage().pickAndUploadFile().then((data) {
      if (mounted)
        setState(() {
          _url = data;
          _loading = false;
        });
    });
  }

  void _uploadString() {
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
  }
}
