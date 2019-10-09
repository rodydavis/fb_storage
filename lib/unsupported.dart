import 'impl.dart';

class FbStorage implements FbStorageImpl {
  FbStorage({
    this.owner = 'Guest',
    this.filesBucket = 'files',
    this.imagesBucket = 'images',
    this.videosBucket = 'videos',
  });

  @override
  final String owner;

  @override
  final String filesBucket;

  @override
  final String imagesBucket;

  @override
  final String videosBucket;

  @override
  Future<String> captureUploadPhoto({
    String bucketPath = 'images',
    String owner = 'Guest',
  }) {
    throw 'Platform Not Supported';
  }

  @override
  Future<String> captureUploadVideo({
    String bucketPath = 'images',
    String owner = 'Guest',
  }) {
    throw 'Platform Not Supported';
  }

  @override
  Future<String> pickAndUploadFile({
    String bucketPath = 'images',
    String owner = 'Guest',
  }) {
    throw 'Platform Not Supported';
  }

  @override
  Future<String> pickUploadPhoto({
    String bucketPath = 'images',
    String owner = 'Guest',
  }) {
    throw 'Platform Not Supported';
  }

  @override
  Future<String> pickUploadVideo({
    String bucketPath = 'images',
    String owner = 'Guest',
  }) {
    throw 'Platform Not Supported';
  }

  @override
  Future<String> uploadString(
    String data,
    String fileName, {
    String folder = 'files',
    String owner = 'Guest',
    String contentType = 'text/plain',
  }) {
    throw 'Platform Not Supported';
  }
}
