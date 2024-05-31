import 'dart:io';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

final customEncrypter = CustomEncrypter();

class CustomEncrypter {
  // We get the encryption keys from the .env file
  final key = enc.Key.fromUtf8(locator<EnvManager>().env.value.key!);
  final iv = enc.IV.fromUtf8(locator<EnvManager>().env.value.iv!);

  String encrypt(String nonEncryptedString) {
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final encryptedString =
        encrypter.encrypt(nonEncryptedString, iv: iv).base64;
    return encryptedString;
  }

  String decrypt(String encryptedString) {
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final thisEncryptedString = enc.Encrypted.fromBase64(encryptedString);
    final decryptedString = encrypter.decrypt(thisEncryptedString, iv: iv);
    return decryptedString;
  }

  Future<File> encryptFile(File file) async {
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final List<int> fileBytes = await file.readAsBytes();
    final encrypted = encrypter.encryptBytes(fileBytes, iv: iv);
    final Directory tempDir = await getTemporaryDirectory();
    final Uri uri = Uri.parse(file.path);
    final String extension = uri.pathSegments.last.split('.').last;
    final File tempFile = File('${tempDir.path}/encrypted_file.$extension');
    await tempFile.writeAsBytes(encrypted.bytes);
    return tempFile;
  }

  Future<File> decryptFile(File file, int pupilId) async {
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));

    // Read the encrypted file as bytes
    final encryptedBytes = await file.readAsBytes();

    // Decrypt the bytes
    final decrypted =
        encrypter.decryptBytes(enc.Encrypted(encryptedBytes), iv: iv);

    // Get the temporary directory
    final tempDir = await getTemporaryDirectory();

    // Create a temporary file for the decrypted content
    final uri = Uri.parse(file.path);
    final extension = uri.pathSegments.last.split('.').last;
    //debug.warning('Extension is $extension');
    final tempFile =
        File('${tempDir.path}/${pupilId}_decrypted_file.$extension');
    // debug.warning(tempFile.path);
    // Write the decrypted bytes to the temporary file
    await tempFile.writeAsBytes(decrypted);

    return tempFile;
  }

  Uint8List decryptTheseBytes(Uint8List encryptedBytes) {
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final List<int> decrypted =
        encrypter.decryptBytes(enc.Encrypted(encryptedBytes), iv: iv);

    final Uint8List decryptedBytes = Uint8List.fromList(decrypted);
    return decryptedBytes;
  }
}
