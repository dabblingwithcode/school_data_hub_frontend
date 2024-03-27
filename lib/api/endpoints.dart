import 'package:schuldaten_hub/common/utils/extensions.dart';

part 'endpoints/schooldays_endpoints.dart';
part 'endpoints/pupil_endpoints.dart';
part 'endpoints/admonition_endpoints.dart';
part 'endpoints/authorization_endpoints.dart';
part 'endpoints/user_endpoints.dart';
part 'endpoints/competence_endpoints.dart';
part 'endpoints/school_list_endpoints.dart';
part 'endpoints/missed_class_endpoints.dart';
part 'endpoints/learning_support_endpoints.dart';
part 'endpoints/workbook_endpoints.dart';
part 'endpoints/pupil_workbook_endpoints.dart';

class Endpoints {
  // dev environment urls:
  //static const baseUrl = 'http://10.0.2.2:5000/api'; // android VM
  //static const baseUrl = 'http://127.0.0.1:5000/api'; //windows

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 30000);
}
