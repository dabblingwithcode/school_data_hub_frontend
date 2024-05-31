import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';

class DownloadOrCachedAndDecryptImage extends StatelessWidget {
  final String? imageUrl;
  final String? tag;

  const DownloadOrCachedAndDecryptImage({this.imageUrl, this.tag, super.key});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return const Icon(Icons.camera_alt_rounded);
    }

    return const Placeholder();
  }
}

Future<Widget> downloadOrCachedAndDecryptImage(
    String? imageUrl, String? tag) async {
  if (imageUrl == null) {
    return const Icon(Icons.camera_alt_rounded);
  }

  final cacheManager = DefaultCacheManager();
  final cacheKey = tag!;

  final fileInfo = await cacheManager.getFileFromCache(cacheKey);

  if (fileInfo != null && await fileInfo.file.exists()) {
    // File is already cached, decrypt it before using
    final encryptedBytes = await fileInfo.file.readAsBytes();
    final decryptedBytes =
        await compute(customEncrypter.decryptTheseBytes, encryptedBytes);
    return Image.memory(decryptedBytes);
  }

  final client = locator.get<ApiManager>().dioClient.value;
  final Response response = await client.get(imageUrl,
      options: Options(responseType: ResponseType.bytes));

  if (response.statusCode == 200) {
    final encryptedBytes = Uint8List.fromList(response.data!);
    // Cache the encrypted bytes
    await cacheManager.putFile(cacheKey, encryptedBytes);
    // Decrypt the bytes before returning
    final decryptedBytes =
        await compute(customEncrypter.decryptTheseBytes, encryptedBytes);
    return Image.memory(decryptedBytes);
  } else {
    throw Exception('Failed to download image');
  }
}
