import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/constants/iit.dart';
import 'package:iism_2025/viewmodel/matches_view_model.dart';
import 'package:iism_2025/viewmodel/teams_view_model.dart';
import 'package:iism_2025/viewmodel/user.dart';
import 'package:iism_2025/widgets/dynamic_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final String route;
  final UserViewModel _userViewModel;

  const TopBar({super.key, required this.route, required UserViewModel user})
    : _userViewModel = user;

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(350);
}

// --------------------------------------------------------
// 🔥 This MUST be outside TopBar class
// --------------------------------------------------------
class _TopBarState extends State<TopBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<UserViewModel>();
    return DynamicNavbar(
      background: CustomColors.darkBlue,
      child: _buildChild(widget.route),
    );
  }

  final bool _liveMatches = true;

  Widget? _buildChild(String route) {
    if (route.contains("/home")) {
      return GestureDetector(
        onTap: () {
          context.push('/profile');
        },
        child: Row(
          spacing: 12,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: (widget._userViewModel.me?.profilePic) != null
                  ? NetworkImage(
                      '${dotenv.env["API_URL"]}/api/profile-pic/${widget._userViewModel.me!.profilePic!}.webp',
                    )
                  : null,
              child: widget._userViewModel.me?.profilePic == null
                  ? const Icon(Icons.person, color: Colors.white)
                  : null,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: Constants.buttonTextSize,
                    color: CustomColors.lightGray,
                    height: 0.9,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      widget._userViewModel.me?.firstName ?? '',
                      style: TextStyle(
                        fontSize: Constants.heading2TextSize,
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.expand_more, color: Colors.white),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
    if (route == '/profile' ||
        route == '/contact' ||
        route == '/notifications' ||
        route == '/request-outing' ||
        route == '/approve-request' ||
        route == "/campus-map" ||
        route == '/chat') {
      var headText = '';

      if (route == '/profile') {
        headText = 'Profile';
      }
      if (route == '/contact') {
        headText = 'Contact';
      }
      if (route == '/request-outing') {
        headText = 'Request For Outing';
      }
      if (route == '/approve-request') {
        headText = 'Approve Outing Request';
      }
      if (route == '/notifications') {
        headText = 'Notifications';
      }
      if (route == '/campus-map') {
        headText = 'Campus Map';
      }
      if (route == '/chat') {
        headText = 'ASK SIMHI';
      }
      return Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              headText,
              style: TextStyle(
                color: Colors.white,
                fontSize: Constants.heading2TextSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ],
      );
    }

    if (route == '/teams') {
      context.watch<TeamsViewModel>();
      return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: BoxBorder.all(color: CustomColors.lightBlue, width: 1),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            padding: EdgeInsets.all(16),
            icon: Icon(Icons.keyboard_arrow_down, color: CustomColors.blue),
            isExpanded: true,
            menuMaxHeight: 400,
            hint: Text(
              "Select a College",
              style: TextStyle(
                color: CustomColors.blue,
                fontSize: Constants.titlesTextSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            items: getAllIITNames().map((val) {
              return DropdownMenuItem(
                value: val,
                child: Row(
                  spacing: 12,
                  children: [
                    Image.asset(getIITImgSrcFromName(val), width: 20),
                    Text('IIT $val'),
                  ],
                ),
              );
            }).toList(),
            dropdownColor: Colors.white,
            value: context.read<TeamsViewModel>().institute,
            onChanged: (value) {
              context.read<TeamsViewModel>().updateInstitute(value!);
            },
          ),
        ),
      );
    }

    if (route == "/schedule") {
      return Align(
        alignment: AlignmentGeometry.centerLeft,
        child: Text(
          "FULL SCHEDULE",
          style: TextStyle(
            fontSize: Constants.heading2TextSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      );
    }
    if (route == '/gallery') {
      return Align(
        alignment: AlignmentGeometry.centerLeft,
        child: Text(
          "GALLERY",
          style: TextStyle(
            fontSize: Constants.heading2TextSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      );
    }

    if (route == '/matches') {
      final matchesVM = context.watch<MatchesViewModel>();

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 18),
        child: Align(
          alignment: Alignment.center,
          child: CustomSlidingSegmentedControl<bool>(
            initialValue: matchesVM.isLiveMatchScreen,
            innerPadding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              border: BoxBorder.all(color: CustomColors.gray, width: 0.5),
              borderRadius: BorderRadius.circular(40),
            ),
            thumbDecoration: BoxDecoration(
              color: CustomColors.orange,
              borderRadius: BorderRadius.circular(40),
            ),
            children: {
              true: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  "LIVE MATCHES",
                  style: TextStyle(
                    color: matchesVM.isLiveMatchScreen
                        ? Colors.white
                        : Colors.black,
                    fontSize: Constants.buttonTextSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              false: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(
                  "RESULTS",
                  style: TextStyle(
                    color: !matchesVM.isLiveMatchScreen
                        ? Colors.white
                        : Colors.black,
                    fontSize: Constants.buttonTextSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            },
            onValueChanged: (v) {
              matchesVM.changeScreen(v);
            },
          ),
        ),
      );
    }

    return SizedBox();
  }
}

class TeamPageState extends ChangeNotifier {
  String? selectedCollege;

  void setCollege(String? value) {
    selectedCollege = value;
    notifyListeners();
  }
}
