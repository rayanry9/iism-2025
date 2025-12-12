import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/constants/sport.dart';
import 'package:iism_2025/viewmodel/user.dart';
import 'package:iism_2025/widgets/sbs.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:go_router/go_router.dart';

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
    if (widget._userViewModel.me!.sports != null &&
        (widget._userViewModel.me!.sports as List<dynamic>).isNotEmpty) {
      final firstSport = widget._userViewModel.me!.sports![0];

      final sportId = firstSport["sportId"];
      sportEnum = getSportFromSportId(sportId);
      sportImage = getSportImageSrc(sportEnum);
    }
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: loading
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 16,
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 35,
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
                                size: 40,
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

                  UserRow(
                    title:
                        (widget._userViewModel.me!.sports != null &&
                            widget._userViewModel.me!.sports!.isNotEmpty)
                        ? sportEnum?.name ?? "NULL"
                        : "NULL",
                    gender: widget._userViewModel.me!.gender,
                    imageUrl: sportImage,
                    right: Text("View"),
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
                          vertical: 14,
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
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.darkTeal,
                                  ),
                                ),
                                Text(
                                  "Request campus outing approval here.",
                                  style: TextStyle(
                                    fontSize: 14,
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
                          vertical: 22,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F7F7),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Color(0xFF0A6C70),
                            width: 1.5,
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
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0A3B3D),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Approve the Outing Requests here.",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.double_arrow,
                              color: Color(0xFF0A3B3D),
                              size: 28,
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
