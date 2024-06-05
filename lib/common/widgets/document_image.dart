import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/widgets/download_or_cached_and_decrypt_image.dart';
import 'package:widget_zoom/widget_zoom.dart';

class DocumentImage extends StatelessWidget {
  final String? documentUrl;
  final String documentTag;
  final double size;
  const DocumentImage(
      {required this.documentUrl,
      required this.documentTag,
      required this.size,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: (21 / 30) * size,
      child: Center(
        child: WidgetZoom(
          heroAnimationTag: documentTag,
          zoomWidget: FutureBuilder<Widget>(
            future: downloadOrCachedAndDecryptImage(documentUrl, documentTag),
            builder: (context, snapshot) {
              Widget child;
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while the future is not complete
                child = const SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    color: backgroundColor,
                  ),
                );
              } else if (snapshot.hasError) {
                // Display an error message if the future encounters an error
                child = Text('Error: ${snapshot.error}');
              } else {
                // Display the result when the future is complete
                child = ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: snapshot.data!);
              }
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300), child: child);
            },
          ),
        ),
      ),
    );
  }
}
