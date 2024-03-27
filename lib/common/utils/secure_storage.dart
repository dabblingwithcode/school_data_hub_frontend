import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const secureStorage = FlutterSecureStorage();

Future<bool> secureStorageContains(String key) async {
  if (await secureStorage.containsKey(key: key)) {
    return true;
  } else {
    return false;
  }
}

Future<String?> secureStorageRead(String key) async {
  final value = await secureStorage.read(key: key);
  return value!;
}

Future<void> secureStorageWrite(String key, String value) async {
  await secureStorage.write(key: key, value: value);
  return;
}

Future<void> secureStorageDelete(String key) async {
  await secureStorage.delete(key: key);
  return;
}
