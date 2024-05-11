import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';

Future<Widget> downloadAndDecryptOrCachedImage(
    String? imageUrl, String? tag) async {
  if (imageUrl == null) {
    return const Icon(Icons.camera_alt_rounded);
  }

  final cacheManager = DefaultCacheManager();
  final cacheKey = tag!;
  final customEncrypter = CustomEncrypter();
  final fileInfo = await cacheManager.getFileFromCache(cacheKey);

  if (fileInfo != null && await fileInfo.file.exists()) {
    // File is already cached, decrypt it before using
    final encryptedBytes = await fileInfo.file.readAsBytes();
    final decryptedBytes =
        await customEncrypter.decryptTheseBytes(encryptedBytes);
    return Image.memory(decryptedBytes);
  }

  final client = locator.get<ApiManager>().dioClient.value;
  final Response response = await client.get(imageUrl,
      options: Options(responseType: ResponseType.bytes));

  if (response.statusCode == 200) {
    // Cache the encrypted bytes
    final cachedFile =
        await cacheManager.putFile(cacheKey, response.data as Uint8List);
    // Decrypt the bytes before returning
    final decryptedBytes =
        await customEncrypter.decryptTheseBytes(await cachedFile.readAsBytes());
    return Image.memory(decryptedBytes);
  } else {
    throw Exception('Failed to download image');
  }
}
