import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/dio/dio_client.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

class EndpointsPupil {
  late final DioClient _client = locator<ApiManager>().dioClient.value;

  //-
  static const exportPupilsTxt = '/import/pupils/txt';

  //- THIS ENDPOINTS ARE NOT USED IN THE APP
  static const getAllPupils = '/pupils/all';
  static const getPupilsFlat = '/pupils/all/flat';
  static const postPupil = '/pupils/new';
  String deletePupil(int pupilId) {
    return '/pupils/$pupilId';
  }

  //- fetch list of pupils

  static const fetchPupils = '/pupils/list';
  Future<List<Pupil>> fetchListOfPupils({
    required List<int> internalPupilIds,
  }) async {
    final pupilIdsListToJson = jsonEncode({"pupils": internalPupilIds});
    final response = await _client.post(fetchPupils, data: pupilIdsListToJson);
    if (response.statusCode != 200) {
      throw ApiException('Failed to fetch pupils', response.statusCode);
    }
    return (response.data as List).map((e) => Pupil.fromJson(e)).toList();
  }

  //- NOT USED - Ist das nicht das gleiche wie fetchPupils mit diese eine internalId in der Liste?
  String getOnePupil(int id) {
    return '/pupils/$id';
  }

  //- NOT USED - instead the url is used in downloadOrCachedAndDecryptImage
  String getPupilAvatar(int id) {
    return '/pupils/$id/avatar';
  }

  /// mach das hier für alle endpoints
  /// Functionen mit aussagekraäfigen Namen
  /// die die richtigen Typen zurückgeben
  /// die verwendung in der App kommt dann im nöchsten Schritt
  /// diese funktionen lassen sich dann auch testen
  //- update pupil property

  String patchPupil(int id) {
    return '/pupils/$id';
  }

  Future<Pupil> updatePupilProperty({
    required int id,
    required String property,
    required dynamic value,
  }) async {
    final Map<String, dynamic> data = {property: value};
    final response = await _client.patch(patchPupil(id), data: data);
    if (response.statusCode != 200) {
      throw ApiException(
          'Failed to update pupil property', response.statusCode);
    }

    /// wenn immer möglich mach die deserialisierung direkt am endpoint
    /// so dass die app nicht mit resonse objekten arbeiten und wissen muss
    /// wie die daten aussehen
    return Pupil.fromJson(response.data);
  }

  //- patch siblings

  static const patchSiblings = '/pupils/patch_siblings';
  Future<List<Pupil>> updateSiblingsProperty({
    required List<int> siblingsPupilIds,
    required String property,
    required dynamic value,
  }) async {
    final data = jsonEncode({
      'pupils': siblingsPupilIds,
      property: value,
    });
    final response = await _client.patch(patchSiblings, data: data);
    if (response.statusCode != 200) {
      throw ApiException('Failed to patch siblings', response.statusCode);
    }
    return (response.data as List).map((e) => Pupil.fromJson(e)).toList();
  }

  //- post / patch pupil avatar

  String patchPupilhWithAvatar(int id) {
    return '/pupils/$id/avatar';
  }

  Future<Pupil> updatePupilWithAvatar({
    required int id,
    required FormData formData,
  }) async {
    final Response response =
        await _client.patch(patchPupilhWithAvatar(id), data: formData);
    if (response.statusCode != 200) {
      throw ApiException('Failed to upload pupil avatar', response.statusCode);
    }
    return Pupil.fromJson(response.data);
  }

  //- delete pupil avatar

  String deletePupilAvatar(int internalId) {
    return '/pupils/$internalId/avatar';
  }

  Future<Pupil> deleteAvatar(int internalId) async {
    final Response response =
        await _client.delete(deletePupilAvatar(internalId));
    if (response.statusCode != 200) {
      throw ApiException(
          'Something went wrong deleting the avatar', response.statusCode);
    }
    return Pupil.fromJson(response.data);
  }
}
