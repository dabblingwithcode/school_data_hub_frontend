import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/widgets/custom_expansion_tile.dart';

class TileController extends StatefulWidget {
  final Widget tileSwitch;
  final CustomExpansionTileController tileController;
  const TileController(this.tileSwitch, this.tileController, {super.key});

  @override
  TileControllerState createState() => TileControllerState();
}

class TileControllerState extends State<TileController> {
  late final CustomExpansionTileController _tileController;

  @override
  void initState() {
    _tileController = widget.tileController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (_tileController.isExpanded) {
            _tileController.collapse();
          } else {
            _tileController.expand();
          }
        },
        child: widget.tileSwitch);
  }
}

Widget tileControllerWidget(
  Widget switchWidget,
  CustomExpansionTileController controller,
) {
  return TileController(switchWidget, controller);
}

// CustomExpansionTileController getTileController(
//     CustomExpansionTileController controller) {
//   return controller;
// }
