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
    // File is already cached, use it directly
    //cacheManager.emptyCache();

    return Image.file(fileInfo.file);
  }
  final client = locator.get<ApiManager>().dioClient.value;
  final Response response = await client.get(imageUrl,
      options: Options(responseType: ResponseType.bytes));
  if (response.statusCode == 200) {
    final Uint8List decryptedBytes =
        await customEncrypter.decryptTheseBytes(response.data!);
    // Cache the decrypted bytes
    final cachedFile = await cacheManager.putFile(cacheKey, decryptedBytes);
    return Image.file(cachedFile);
  } else {
    throw Exception('Failed to download image');
  }
}
