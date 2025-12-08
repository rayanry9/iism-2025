import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iism_2025/constants/colors.dart';

class MyTabBar extends StatefulWidget {
  final Widget child;
  const MyTabBar({super.key, required this.child});

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildIcon(String path, int index) {
    final bool selected = _tabController.index == index;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SvgPicture.asset(
        path,
        height: 22,
        width: 22,

        // 👇 This tints ONLY the drawn SVG paths, NOT the background box
        colorFilter: ColorFilter.mode(
          selected ? CustomColors.orange : Colors.black,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,

      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 0),
        decoration: const BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(28),
          //   topRight: Radius.circular(28),
          // ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black12,
          //     blurRadius: 8,
          //     offset: Offset(0, -2),
          //   ),
          // ],
        ),

        child: TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelPadding: const EdgeInsets.only(bottom: 4),

          tabs: [
            Tab(icon: buildIcon("assets/icons/home.svg", 0), text: "Home"),
            Tab(
              icon: buildIcon("assets/icons/matches.svg", 1),
              text: "Matches",
            ),
            Tab(
              icon: buildIcon("assets/icons/schedule.svg", 2),
              text: "Schedule",
            ),
            Tab(icon: buildIcon("assets/icons/teams.svg", 3), text: "Teams"),
            Tab(
              icon: buildIcon("assets/icons/gallery.svg", 4),
              text: "Gallery",
            ),
          ],

          labelColor: CustomColors.orange,
          unselectedLabelColor: Colors.black,

          onTap: (index) {
            switch (index) {
              case 0:
                context.go("/home");
                break;
              case 1:
                context.go("/matches");
                break;
              case 2:
                context.go("/schedule");
                break;
              case 3:
                context.go("/teams");
                break;
              case 4:
                context.go("/gallery");
                break;
            }
          },
        ),
      ),
    );
  }
}
