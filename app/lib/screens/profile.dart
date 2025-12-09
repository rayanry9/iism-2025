import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/services/user_cache.dart';
import 'package:iism_2025/services/user_loader.dart';
import 'package:iism_2025/widgets/sbs.dart';
import 'package:iism_2025/services/sport.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

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
    load();
    //    print("yo");
    // print(sportImage);
  }

  Future<void> load() async {
    await loadUserData();

    if (UserCache().sports != null && UserCache().sports!.isNotEmpty) {
      //       print("FIRST SPORT ENTRY: ${UserCache().sports![0]}");
      // print("TYPE: ${UserCache().sports![0].runtimeType}");
      final firstSport = UserCache().sports![0];

      final sportId = firstSport["sportId"];
      sportEnum = getSportFromSportId(sportId);
      sportImage = getSportImageSrc(sportEnum);
    }
    setState(() {
      loading = false; // set once, AFTER async load
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),

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
                        backgroundImage: UserCache().profilePic != null
                            ? NetworkImage(UserCache().profilePic!)
                            : null,
                        child: UserCache().profilePic == null
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
                                (UserCache().firstName ?? "") +
                                    " " +
                                    (UserCache().lastName ?? ""),
                                style: TextStyle(
                                  fontSize: Constants.titlesTextSize,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            UserCache().email ?? "",
                            style: const TextStyle(
                              fontSize: Constants.buttonTextSize,
                              color: CustomColors.darkGray,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "IIT " + (UserCache().institute ?? ""),
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
                        (UserCache().sports != null &&
                            UserCache().sports!.isNotEmpty)
                        ? sportEnum?.name ?? "NULL"
                        : "NULL",
                    gender: UserCache().gender ?? "No name",
                    imageUrl: sportImage,
                    right: Text("View"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "MESS CODE",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // 🔥 Barcode 128 using assignedId
                        if (UserCache().assignedId != null)
                          BarcodeWidget(
                            barcode: Barcode.code128(),
                            data: UserCache().assignedId.toString(),
                            width: double.infinity,
                            height: 40,
                            drawText: false,
                          )
                        else
                          const Text("No Code Available"),
                      ],
                    ),
                  ),

                  // -----------------------------
                  // OUTING CARDS BASED ON ROLE
                  // -----------------------------
                  if (UserCache().role == 2)
                    GestureDetector(
                      onTap: () {
                        context.push("/request-outing");
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
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
                                  "REQUEST FOR OUTING",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0A3B3D),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Request campus outing approval here.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            Icon(Icons.double_arrow, color: Color(0xFF0A3B3D)),
                          ],
                        ),
                      ),
                    ),

                  if (UserCache().role == 6)
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

                  const SizedBox(height: 20),

                  const Text(
                    "More profile info coming here...",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
    );
  }
}
