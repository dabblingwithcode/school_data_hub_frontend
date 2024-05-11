import 'package:flutter/material.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/download_decrypt_or_cached_image.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_helper_functions.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:widget_zoom/widget_zoom.dart';

class AvatarImage extends StatelessWidget {
  final PupilProxy pupil;
  final double size;
  const AvatarImage({required this.pupil, required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: pupil.avatarUrl != null
              ? WidgetZoom(
                  heroAnimationTag: pupil.internalId,
                  zoomWidget: FutureBuilder<Widget>(
                    future: downloadAndDecryptOrCachedImage(
                      '${locator<EnvManager>().env.value.serverUrl}${EndpointsPupil().getPupilAvatar(pupil.internalId)}',
                      pupil.internalId.toString(),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Display a loading indicator while the future is not complete
                        return const CircularProgressIndicator(
                          strokeWidth: 8,
                          color: backgroundColor,
                        );
                      } else if (snapshot.hasError) {
                        // Display an error message if the future encounters an error
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return snapshot.data!;
                      }
                    },
                  ),
                )
              : Image.asset(
                  'assets/dummy-profile-pic.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}

class AvatarWithBadges extends StatelessWidget {
  final PupilProxy pupil;
  final double size;
  const AvatarWithBadges({required this.pupil, required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: AvatarImage(pupil: pupil, size: size),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color:
                    pupilIsMissedToday(pupil) ? warningButtonColor : groupColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  pupil.group!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: SchoolEventHelper.pupilIsAdmonishedToday(pupil)
                    ? Colors.red
                    : schoolyearColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  pupil.schoolyear!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          if (pupil.ogs == true)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 30.0,
                height: 30.0,
                decoration: const BoxDecoration(
                  color: ogsColor,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'OGS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          if (pupil.migrationSupportEnds != null)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: hasLanguageSupport(pupil.migrationSupportEnds)
                      ? Colors.green
                      : Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.language_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
