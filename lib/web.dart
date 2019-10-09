import 'package:firebase/firebase.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:universal_html/prefer_universal/html.dart' as html;

import 'impl.dart';

class FbStorage implements FbStorageImpl {
  FbStorage({
    this.owner = 'Guest',
    this.filesBucket = 'files',
    this.imagesBucket = 'images',
    this.videosBucket = 'videos',
  });

  @override
  Future<String> uploadString(
    String data,
    String fileName, {
    String folder = 'files',
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

  @override
  Future<String> captureUploadPhoto() async {
    final _images = html.FileUploadInputElement();
    _images.accept = "image/*";
    _images.click();
    final e = await _images.onChange.first;
    html.File file = (e.target as dynamic).files[0];
    if (file != null) return _uploadFile(file, imagesBucket, owner);
    return null;
  }

  @override
  Future<String> captureUploadVideo() async {
    final _images = html.FileUploadInputElement();
    _images.accept = "video/*";
    _images.click();
    final e = await _images.onChange.first;
    html.File file = (e.target as dynamic).files[0];
    if (file != null) return _uploadFile(file, imagesBucket, owner);
    return null;
  }

  @override
  Future<String> pickAndUploadFile() async {
    final _files = html.FileUploadInputElement();
    _files.accept = "*";
    final e = await _files.onChange.first;
    html.File file = (e.target as dynamic).files[0];
    if (file != null) return _uploadFile(file, imagesBucket, owner);
    return null;
  }

  @override
  Future<String> pickUploadPhoto() async {
    final _images = html.FileUploadInputElement();
    _images.accept = "image/*";
    _images.click();
    final e = await _images.onChange.first;
    html.File file = (e.target as dynamic).files[0];
    if (file != null) return _uploadFile(file, imagesBucket, owner);
    return null;
  }

  @override
  Future<String> pickUploadVideo() async {
    final _images = html.FileUploadInputElement();
    _images.accept = "video/*";
    _images.click();
    final e = await _images.onChange.first;
    html.File file = (e.target as dynamic).files[0];
    if (file != null) return _uploadFile(file, imagesBucket, owner);
    return null;
  }

  Future<String> _uploadFile(
      html.File file, String bucketPath, String owner) async {
    final fb.StorageReference ref = fb.storage().ref(bucketPath);
    var customMetadata = {"owner": owner};
    var uploadTask = ref.child(file.name).put(
          file,
          fb.UploadMetadata(
            contentType: file.type,
            customMetadata: customMetadata,
          ),
        );

    try {
      var snapshot = await uploadTask.future;
      final _url = await snapshot.ref.getDownloadURL();

      if (_url != null) {
        return _url.toString();
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  final String owner;

  @override
  final String filesBucket;

  @override
  final String imagesBucket;

  @override
  final String videosBucket;
}
