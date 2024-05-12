import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

class SchooldayApi {
  // dio instance

  final client = locator<ApiManager>().dioClient.value;

  Future fetchSchooldayfromApi() async {
    try {
      final response = await client.get(EndpointsSchoolday.getSchooldays);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
