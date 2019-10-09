class FbStorage {
  FbStorage._();

  static Future<String> uploadString(
    String data,
    String fileName, {
    String folder = 'images',
    String owner = 'Guest',
    String contentType = 'text/plain',
  }) {
    throw 'Platform Not Supported';
  }
}
