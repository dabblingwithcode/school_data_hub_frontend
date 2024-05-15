export 'endpoints/schoolday_event_endpoints.dart';
export 'endpoints/authorization_endpoints.dart';
export 'endpoints/competence_endpoints.dart';
export 'endpoints/learning_support_endpoints.dart';
export 'endpoints/missed_class_endpoints.dart';
export 'endpoints/pupil_endpoints.dart';
export 'endpoints/pupil_workbook_endpoints.dart';
export 'endpoints/school_list_endpoints.dart';
export 'endpoints/schooldays_endpoints.dart';
export 'endpoints/user_endpoints.dart';
export 'endpoints/workbook_endpoints.dart';

class ApiSettings {
  // dev environment urls:
  //static const baseUrl = 'http://10.0.2.2:5000/api'; // android VM
  //static const baseUrl = 'http://127.0.0.1:5000/api'; //windows

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 30000);
}

class ApiException implements Exception {
  final String message;
  final int statusCode;
  ApiException(this.message, int? statusCode) : statusCode = statusCode ?? 0;
}
