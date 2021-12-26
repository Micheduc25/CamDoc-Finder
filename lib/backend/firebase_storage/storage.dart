import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:mime_type/mime_type.dart';

Future<String> uploadData(String path, Uint8List data) async {
  final storageRef = FirebaseStorage.instance.ref().child(path);
  final metadata = SettableMetadata(contentType: mime(path));
  final result = await storageRef.putData(data, metadata);
  return result.state == TaskState.success ? result.ref.getDownloadURL() : null;
}

Future<bool> deleteFile(String url) async {
  try {
    final fileRef = FirebaseStorage.instance.refFromURL(url);
    await fileRef.delete();
    return true;
  } on Exception catch (e) {
    debugPrint(e.toString());
    return false;
  }
}
