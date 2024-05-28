import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_personal_data_manager.dart';

String tokenLifetimeLeft(String token) {
  Duration remainingTime = JwtDecoder.getRemainingTime(token);
  String days = remainingTime.inDays == 1 ? 'Tag' : 'Tage';
  String hours = remainingTime.inHours == 1 ? 'Stunde' : 'Stunden';
  String minutes = remainingTime.inMinutes == 1 ? 'Minute' : 'Minuten';
  String timeLeft =
      '${remainingTime.inDays} $days, ${remainingTime.inHours % 24} $hours, ${remainingTime.inMinutes % 60} $minutes';
  return timeLeft;
}

void logout(BuildContext context) async {
  await locator<SessionManager>().logout();
  locator<NotificationManager>().showSnackBar(
      NotificationType.success, 'Zugangsdaten und QR-Ids gelöscht!');
}

void logoutAndDeleteAllData(BuildContext context) async {
  await locator<PupilPersonalDataManager>().deleteData();
  await locator<EnvManager>().deleteEnv();
  await locator<SessionManager>().logout();
  final cacheManager = DefaultCacheManager();

  await cacheManager.emptyCache();

  locator<NotificationManager>()
      .showSnackBar(NotificationType.success, 'Alle Daten gelöscht!');
}
