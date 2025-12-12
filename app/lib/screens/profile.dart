import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/constants/iit.dart';
import 'package:iism_2025/constants/mess_menu.dart';
import 'package:iism_2025/constants/sport.dart';
import 'package:iism_2025/viewmodel/user.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:iism_2025/widgets/sport_card_full.dart';

class ProfileScreen extends StatefulWidget {
  final UserViewModel _userViewModel;
  const ProfileScreen({super.key, required UserViewModel userViewModel})
    : _userViewModel = userViewModel;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool loading = true;
  String? sportImage;
  Sports? sportEnum;
  @override
  void initState() {
    super.initState();
    if (widget._userViewModel.me!.sports != null) {
      print("ASDASD");
      if ((widget._userViewModel.me!.sports as List<dynamic>).isNotEmpty) {
        final firstSport = widget._userViewModel.me!.sports![0];

        final sportId = firstSport["sportId"];
        sportEnum = getSportFromSportId(sportId);
        sportImage = getSportImageSrc(sportEnum);
      }
    }
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(Constants.screenWidthPadding),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // --------------------------
                  // PROFILE HEADER (TOP)
                  // --------------------------
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            widget._userViewModel.me!.profilePic != null
                            ? NetworkImage(
                                widget._userViewModel.me!.profilePic!,
                              )
                            : null,
                        child: widget._userViewModel.me!.profilePic == null
                            ? const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 60,
                              )
                            : null,
                      ),

                      // Text info
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${widget._userViewModel.me?.firstName} ${widget._userViewModel.me?.lastName ?? " "}',
                                style: TextStyle(
                                  fontSize: Constants.titlesTextSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget._userViewModel.me!.email,
                            style: const TextStyle(
                              fontSize: Constants.buttonTextSize,
                              color: CustomColors.darkGray,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "IIT ${widget._userViewModel.me!.institute}",
                            style: const TextStyle(
                              fontSize: Constants.buttonTextSize,
                              color: CustomColors.darkGray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  SportCardFull(
                    role: widget._userViewModel.me!.role,
                    sportId: widget._userViewModel.me?.sports != null
                        ? ((widget._userViewModel.me?.sports as List<dynamic>)
                                  .isNotEmpty
                              ? (widget
                                    ._userViewModel
                                    .me
                                    ?.sports?[0]["sportId"])
                              : null)
                        : null,
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          getIITImgSrcFromName(
                            widget._userViewModel.me!.institute,
                          ),
                          height: 58,
                        ),
                        Text(
                          "IIT ${widget._userViewModel.me!.institute}",
                          style: TextStyle(
                            fontSize: Constants.titlesTextSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: Constants.screenWidthPadding,
                    ),
                    decoration: BoxDecoration(
                      color: CustomColors.lightGray,
                      border: Border.all(color: CustomColors.gray),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 20,
                      children: [
                        const Text(
                          "MESS CODE",
                          style: TextStyle(
                            fontSize: Constants.buttonTextSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // 🔥 Barcode 128 using assignedId
                        if (widget._userViewModel.me!.assignedId != null)
                          Expanded(
                            child: BarcodeWidget(
                              barcode: Barcode.code128(),
                              data: widget._userViewModel.me!.assignedId
                                  .toString(),
                              width: null,
                              height: 56,
                              drawText: false,
                            ),
                          )
                        else
                          const Text("No Code Available"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24, height: 16),

                  ExpansionTile(
                    expandedAlignment: Alignment.centerLeft,
                    tilePadding: EdgeInsets.symmetric(
                      horizontal: Constants.screenWidthPadding,
                    ),
                    title: Text(
                      "TODAYS MESS MENU",
                      style: TextStyle(
                        fontSize: Constants.buttonTextSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: CustomColors.lightGray,
                    collapsedBackgroundColor: CustomColors.lightGray,
                    children: [
                      ExpansionTile(
                        title: Text(
                          "Breakfast",
                          style: TextStyle(fontSize: Constants.buttonTextSize),
                        ),
                        childrenPadding: EdgeInsetsGeometry.symmetric(
                          horizontal: Constants.screenWidthPadding,
                          vertical: 12,
                        ),
                        tilePadding: EdgeInsets.symmetric(
                          horizontal: Constants.screenWidthPadding,
                        ),
                        subtitle: Text(
                          "07:30 AM to 09:30 AM",
                          style: TextStyle(
                            fontSize: 12,
                            color: CustomColors.darkGray,
                          ),
                        ),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        children: getMessMenuByDayTime(DateTime.now().day)[0]
                            .indexed
                            .map((item) {
                              return Text(
                                '${item.$1 + 1}. ${item.$2}',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.left,
                              );
                            })
                            .toList(),
                      ),
                      ExpansionTile(
                        title: Text(
                          "Lunch",
                          style: TextStyle(fontSize: Constants.buttonTextSize),
                        ),
                        childrenPadding: EdgeInsetsGeometry.symmetric(
                          horizontal: Constants.screenWidthPadding,
                          vertical: 12,
                        ),
                        tilePadding: EdgeInsets.symmetric(
                          horizontal: Constants.screenWidthPadding,
                        ),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        subtitle: Text(
                          "12:30 PM to 2:30 PM",
                          style: TextStyle(
                            fontSize: 12,
                            color: CustomColors.darkGray,
                          ),
                        ),
                        children: getMessMenuByDayTime(DateTime.now().day)[1]
                            .indexed
                            .map((item) {
                              return Text(
                                '${item.$1 + 1}. ${item.$2}',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.left,
                              );
                            })
                            .toList(),
                      ),
                      ExpansionTile(
                        title: Text(
                          "Dinner",
                          style: TextStyle(fontSize: Constants.buttonTextSize),
                        ),
                        childrenPadding: EdgeInsetsGeometry.symmetric(
                          horizontal: Constants.screenWidthPadding,
                          vertical: 12,
                        ),
                        tilePadding: EdgeInsets.symmetric(
                          horizontal: Constants.screenWidthPadding,
                        ),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        subtitle: Text(
                          "07:30 PM to 09:30 PM",
                          style: TextStyle(
                            fontSize: 12,
                            color: CustomColors.darkGray,
                          ),
                        ),
                        children: getMessMenuByDayTime(DateTime.now().day)[2]
                            .indexed
                            .map((item) {
                              return Text(
                                '${item.$1 + 1}. ${item.$2}',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.left,
                              );
                            })
                            .toList(),
                      ),
                    ],
                  ),

                  // -----------------------------
                  // OUTING CARDS BASED ON ROLE
                  // -----------------------------
                  if (widget._userViewModel.me!.role == 2)
                    GestureDetector(
                      onTap: () {
                        context.push("/request-outing");
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: Constants.screenWidthPadding,
                        ),
                        decoration: BoxDecoration(
                          color: CustomColors.pastelBlue,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: CustomColors.teal,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "REQUEST FOR OUTING",
                                  style: TextStyle(
                                    fontSize: Constants.heading2TextSize,
                                    fontWeight: FontWeight.w600,
                                    color: CustomColors.darkTeal,
                                  ),
                                ),
                                Text(
                                  "Request campus outing approval here.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: CustomColors.darkTeal,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.double_arrow,
                              color: CustomColors.darkTeal,
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (widget._userViewModel.me!.role == 6)
                    GestureDetector(
                      onTap: () {
                        context.push("/approve-request");
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: Constants.screenWidthPadding,
                        ),
                        decoration: BoxDecoration(
                          color: CustomColors.pastelBlue,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: CustomColors.teal,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "OUTING REQUESTS",
                                  style: TextStyle(
                                    fontSize: Constants.heading2TextSize,
                                    fontWeight: FontWeight.w600,
                                    color: CustomColors.darkTeal,
                                  ),
                                ),
                                Text(
                                  "Approve the Outing Requests here.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: CustomColors.darkTeal,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.double_arrow,
                              color: CustomColors.darkTeal,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
