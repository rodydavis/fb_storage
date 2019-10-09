import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'impl.dart';

class FbStorage implements FbStorageImpl {
  FbStorage({
    this.owner = 'Guest',
    this.filesBucket = 'files',
    this.imagesBucket = 'images',
    this.videosBucket = 'videos',
  });

  @override
  Future<String> captureUploadPhoto() async {
    final _file = await ImagePicker.pickImage(source: ImageSource.camera);
    if (_file != null) {
      return _uploadFile(_file, imagesBucket, owner);
    }
    return null;
  }

  @override
  Future<String> captureUploadVideo() async {
    final _file = await ImagePicker.pickVideo(source: ImageSource.camera);
    if (_file != null) {
      return _uploadFile(_file, videosBucket, owner);
    }
    return null;
  }

  @override
  Future<String> pickAndUploadFile() async {
    final _file = await FilePicker.getFile();
    if (_file != null) {
      return _uploadFile(_file, filesBucket, owner);
    }
    return null;
  }

  @override
  Future<String> pickUploadPhoto() async {
    final _file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (_file != null) {
      return _uploadFile(_file, imagesBucket, owner);
    }
    return null;
  }

  @override
  Future<String> pickUploadVideo() async {
    final _file = await ImagePicker.pickVideo(source: ImageSource.gallery);
    if (_file != null) {
      return _uploadFile(_file, videosBucket, owner);
    }
    return null;
  }

  @override
  Future<String> uploadString(
    String data,
    String fileName, {
    String folder = 'files',
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

  Future<String> _uploadFile(
    File _file,
    String bucketPath,
    String owner,
  ) async {
    final _storage = FirebaseStorage.instance;
    final StorageReference ref = _storage.ref();
    var customMetadata = {"owner": owner};
    var uploadTask = ref.child(bucketPath).putFile(
          _file,
          StorageMetadata(
            customMetadata: customMetadata,
          ),
        );
    try {
      var snapshot = await uploadTask.onComplete;
      final _url = await snapshot.ref.getDownloadURL();
      if (_url != null) {
        return _url;
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
