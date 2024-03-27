import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';

import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/models/schoolday_models/schoolday.dart';
import 'schoolday_api.dart';

class SchooldayRepository {
  final SchooldayApi schooldayApi;

  SchooldayRepository(this.schooldayApi);

  Future<List<Schoolday>> getSchooldaysFromRepository() async {
    try {
      final response = await schooldayApi.fetchSchooldayfromApi();
      final schooldays =
          (response as List).map((e) => Schoolday.fromJson(e)).toList();
      debug.success(
          'SchooldayRepository fetched ${schooldays.length} schooldays! | ${StackTrace.current}');
      return schooldays;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      log(errorMessage.toString());
      rethrow;
    }
  }
}
