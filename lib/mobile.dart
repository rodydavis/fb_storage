import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FbStorage {
  FbStorage._();

  static Future<String> uploadString(
    String data,
    String fileName, {
    String folder = 'images',
    String owner = 'Guest',
    String contentType = 'text/plain',
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(data);
    final _storage = FirebaseStorage.instance;
    final StorageReference ref = _storage.ref();
    var customMetadata = {"owner": owner};
    var uploadTask = ref.child('$folder').putFile(
          file,
          StorageMetadata(
            contentType: contentType,
            customMetadata: customMetadata,
          ),
        );
    try {
      var snapshot = await uploadTask.onComplete;
      final _url = await snapshot.ref.getDownloadURL();
      return _url.toString();
    } catch (e) {
      print(e);
    }
    return null;
  }
}
