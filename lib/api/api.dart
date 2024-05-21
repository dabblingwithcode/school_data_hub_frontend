export 'endpoints/api_schoolday_event_service.dart';
export 'endpoints/api_authorization_service.dart';
export 'endpoints/api_competence_service.dart';
export 'endpoints/api_learning_support_service.dart';
export 'endpoints/api_attendance_service.dart';
export 'endpoints/api_pupil_service.dart';
export 'endpoints/api_pupil_workbook_service.dart';
export 'endpoints/api_school_list_service.dart';
export 'endpoints/api_schoolday_service.dart';
export 'endpoints/user_endpoints.dart';
export 'endpoints/api_workbook_service.dart';

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
