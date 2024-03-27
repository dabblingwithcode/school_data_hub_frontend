import 'package:flutter/material.dart';

import 'package:schuldaten_hub/common/widgets/custom_expansion_tile.dart';

listTiles(Widget? title, BuildContext context,
    CustomExpansionTileController? controller, List<Widget> detailsList) {
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    minVerticalPadding: 0,
    child: Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: CustomExpansionTile(
          collapsedBackgroundColor: Colors.white,
          tilePadding: const EdgeInsets.all(0),
          title: title ?? const SizedBox.shrink(),
          controller: controller,
          children: [...detailsList]),
    ),
  );
}
