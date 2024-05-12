import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/dio/dio_client.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

class EndpointsPupil {
  final DioClient client;

  // auch für diese endpoints funktionen wie unten erstellen
  //- POST
  static const postPupil = '/pupils/new';
  static const exportPupilsTxt = '/import/pupils/txt';

  //- GET
  static const getAllPupils = '/pupils/all';
  static const getPupilsFlat = '/pupils/all/flat';
  static const getPupils = '/pupils/list';

  EndpointsPupil(this.client);

  String getOnePupil(int id) {
    return '/pupils/$id';
  }

  String getPupilAvatar(int id) {
    return '/pupils/$id/avatar';
  }

  //- PATCH
  String patchPupil(int id) {
    return '/pupils/$id';
  }

  /// mach das hier für alle endpoints
  /// Functionen mit aussagekraäfigen Namen
  /// die die richtigen Typen zurückgeben
  /// die verwendung in der App kommt dann im nöchsten Schritt
  /// diese funktionen lassen sich dann auch testen
  Future<Pupil> updatePupilProperty({
    required int id,
    required String property,
    required dynamic value,
  }) async {
    final Map<String, dynamic> data = {property: value};
    final response = await client.patch(patchPupil(id), data: data);
    if (response.statusCode != 200) {
      throw ApiException(
          'Failed to update pupil property', response.statusCode);
    }

    /// wenn immer möglich mach die deserialisierung direkt am endpoint
    /// so dass die app nicht mit resonse objekten arbeiten und wissen muss
    /// wie die daten aussehen
    return Pupil.fromJson(response.data);
  }

  static const patchSiblings = '/pupils/patch_siblings';

  String patchPupilhWithAvatar(int id) {
    return '/pupils/$id/avatar';
  }

  //- DELETE
  String deletePupil(int pupilId) {
    return '/pupils/$pupilId';
  }

  String deletePupilAvatar(int pupilId) {
    return '/pupils/$pupilId/avatar';
  }
}
