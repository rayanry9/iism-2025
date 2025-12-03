import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: widget.child,
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: [
          Tab(
            text: "Home",
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              height: 24,
              width: 24,
            ),
          ),
          Tab(
            text: "Matches",
            icon: SvgPicture.asset(
              "assets/icons/matches.svg",
              height: 24,
              width: 24,
            ),
          ),
          Tab(
            text: "Schedule",
            icon: SvgPicture.asset(
              "assets/icons/schedule.svg",
              height: 24,
              width: 24,
            ),
          ),
          Tab(
            text: "Teams",
            icon: SvgPicture.asset(
              "assets/icons/teams.svg",
              height: 24,
              width: 24,
            ),
          ),
          Tab(
            text: "Gallery",
            icon: SvgPicture.asset(
              "assets/icons/gallery.svg",
              height: 24,
              width: 24,
            ),
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              context.go("/home");
            case 1:
              context.go("/matches");
            case 2:
              context.go("/schedule");
            case 3:
              context.go("/teams");
            case 4:
              context.go("/gallery");
          }
        },
      ),
    );
  }
}
