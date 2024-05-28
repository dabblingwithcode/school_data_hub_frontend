import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/widgets/custom_expansion_tile.dart';
import 'package:schuldaten_hub/common/widgets/custom_list_tiles.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_user.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_helper_functions.dart';
import 'package:schuldaten_hub/features/matrix/views/room_list_page/widgets/users_in_room_list.dart';
import 'package:watch_it/watch_it.dart';

class RoomListCard extends WatchingStatefulWidget {
  final MatrixRoom matrixRoom;
  const RoomListCard(this.matrixRoom, {super.key});

  @override
  State<RoomListCard> createState() => _RoomListCardState();
}

class _RoomListCardState extends State<RoomListCard> {
  late CustomExpansionTileController _tileController;
  @override
  void initState() {
    super.initState();
    _tileController = CustomExpansionTileController();
  }

  @override
  Widget build(BuildContext context) {
    // PupilProxy pupil = watchValue((PupilFilterManager x) => x.filteredPupils)
    //     .where((element) => element.internalId == widget.passedPupil.internalId)
    //     .first;
    final List<MatrixUser> matrixUsersInRoom =
        usersInRoom(widget.matrixRoom.id);
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin:
          const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //AvatarWithBadges(pupil: pupil, size: 80),
              const Gap(10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(15),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              onTap: () {
                                // locator<BottomNavManager>()
                                //     .setPupilProfileNavPage(2);
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (ctx) => PupilProfile(
                                //     pupil,
                                //   ),
                                // ));
                              },
                              child: Text(
                                '${widget.matrixRoom.name}',
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  widget.matrixRoom.id,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const Gap(10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    const Text('Berechtigungen',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const Text(
                                  'Schreiben: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const Gap(5),
                                Text(
                                  widget.matrixRoom.eventsDefault.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Gap(5),
                                const Text(
                                  'Reaktionen:',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const Gap(5),
                                Text(
                                  widget.matrixRoom.powerLevelReactions
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Gap(10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    const Text('Rechte',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    const Gap(5),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final roomAdmin
                                in widget.matrixRoom.roomAdmins!)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    roomAdmin.id,
                                  ),
                                  const Gap(5),
                                  Text(
                                    roomAdmin.powerLevel.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        )
                      ],
                    ),
                    const Gap(10),
                  ],
                ),
              ),
              const Gap(20),
              InkWell(
                onTap: () {
                  _tileController.isExpanded
                      ? _tileController.collapse()
                      : _tileController.expand();
                },
                child: Column(
                  children: [
                    const Gap(20),
                    const Text('Konten'),
                    Center(
                      child: Text(
                        matrixUsersInRoom.length.toString(),
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: backgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
            ],
          ),
          CustomListTiles(
              title: null,
              tileController: _tileController,
              widgetList: usersInRoomList(matrixUsersInRoom, context))
        ],
      ),
    );
  }
}
