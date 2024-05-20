import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';

class GenericAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData iconData;
  final String title;

  const GenericAppBar({
    super.key,
    required this.iconData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 25,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: appBarTextStyle,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
