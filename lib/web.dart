import 'package:firebase/firebase.dart';

class FbStorage {
  FbStorage._();

  static Future<String> uploadString(
    String data,
    String fileName, {
    String folder = 'images',
    String owner = 'Guest',
    String contentType = 'text/plain',
  }) async {
    try {
      final StorageReference ref = storage().ref('$folder');
      var customMetadata = {"owner": owner};
      var uploadTask = ref.child('$fileName').putString(
            data,
            StringFormat.RAW,
            UploadMetadata(
              contentType: contentType,
              customMetadata: customMetadata,
            ),
          );
      var snapshot = await uploadTask.future;
      final _url = await snapshot.ref.getDownloadURL();
      return _url.toString();
    } catch (e) {
      print(e);
    }
    return null;
  }
}
