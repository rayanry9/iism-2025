import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/widgets/dynamic_bar.dart';
import 'package:iism_2025/services/user_cache.dart';
import 'package:iism_2025/services/user_loader.dart';
import 'package:go_router/go_router.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final String route;

  const TopBar({super.key, required this.route});

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(350);
}

// --------------------------------------------------------
// 🔥 This MUST be outside TopBar class
// --------------------------------------------------------
class _TopBarState extends State<TopBar> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await loadUserData();
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DynamicNavbar(
      background: CustomColors.darkBlue,
      child: _buildChild(widget.route),
    );
  }

  Widget? _buildChild(String route) {
    if (route.contains("/home")) {
      return Padding(
        padding: EdgeInsets.all(0.0),
        child: Row(
          spacing: 12,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: UserCache().profilePic != null
                  ? NetworkImage(UserCache().profilePic!)
                  : null,
              child: UserCache().profilePic == null
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
                    color: Colors.white,
                    height: 0.9,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.push('/profile');
                  },
                  child: Row(
                    children: [
                      Text(
                        UserCache().firstName ?? "",
                        style: TextStyle(
                          fontSize: Constants.heading2TextSize,
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.expand_more, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    if (route == '/profile' ||
        route == '/contact' ||
        route == 'notifications') {
      var headText = '';

      if (route == '/profile') {
        headText = 'Profile';
      }
      if (route == '/contact') {
        headText = 'Contact';
      }
      if (route == '/notifications') {
        headText = 'Notifications';
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

    return SizedBox();
  }

  Widget _buildCenter(String route) {
    // print("TopBar route = $route");
    if (route == "/home") {
      return Padding(padding: EdgeInsets.all(10.0));
    }
    if (route == "/gallery") {
      return Text(
        "Gallery",
        style: TextStyle(fontSize: 20, color: Colors.white),
      );
    }
    if (route.contains("/profile")) {
      return Text(
        "PROFILE",
        style: TextStyle(fontSize: 20, color: Colors.white),
      );
    }
    if (route == "/request-outing" || route == "/approve-request") {
      // print("you");
      return Row(
        children: [
          GestureDetector(
            onTap: () => context.replace('/profile'),
            child: const Icon(Icons.arrow_back, size: 26, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Text(
            "REQUEST FOR OUTING",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      );
    }
    return const SizedBox(width: 0);
  }
}
