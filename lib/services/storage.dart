import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<String> getImageUrl(String filename) async {
    return await storage.ref().child(filename).getDownloadURL();
  }
}