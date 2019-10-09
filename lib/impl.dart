abstract class FbStorageImpl {
  final String imagesBucket, filesBucket, videosBucket;
  final String owner;

  FbStorageImpl({
    this.owner,
    this.imagesBucket,
    this.filesBucket,
    this.videosBucket,
  });

  Future<String> uploadString(
    String data,
    String fileName, {
    String folder = 'files',
    String contentType = 'text/plain',
  });

  Future<String> captureUploadPhoto();

  Future<String> captureUploadVideo();

  Future<String> pickUploadPhoto();

  Future<String> pickUploadVideo();

  Future<String> pickAndUploadFile();
}
