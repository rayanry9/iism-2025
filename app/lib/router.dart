import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iism_2025/screens/contact.dart';
import 'package:iism_2025/screens/gallery.dart';
import 'package:iism_2025/screens/home.dart';
import 'package:iism_2025/screens/login.dart';
import 'package:iism_2025/screens/matches.dart';
import 'package:iism_2025/screens/notification.dart';
import 'package:iism_2025/screens/profile.dart';
import 'package:iism_2025/screens/schedule.dart';
import 'package:iism_2025/screens/teams.dart';
import 'package:iism_2025/screens/splash.dart';
import 'package:iism_2025/screens/logindetails.dart';
import 'package:iism_2025/widgets/global_fab.dart';
import 'package:iism_2025/widgets/tab_bar.dart';
import 'package:iism_2025/widgets/top_bar.dart';

final GoRouter router = GoRouter(
  initialLocation: "/splash",
  routes: [
    GoRoute(
      path: "/splash",
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: "/login",
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: "/logindetails",
      builder: (BuildContext context, GoRouterState state) {
        return const LogindetailsScreen();
      },
    ),
    GoRoute(
      path: "/contact",
      pageBuilder: (BuildContext context, GoRouterState state) {
        return NoTransitionPage(child: const ContactScreen());
      },
    ),
    GoRoute(
      path: "/notification",
      builder: (BuildContext context, GoRouterState state) {
        return const NotificationScreen();
      },
    ),
    GoRoute(
      path: "/profile",
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileScreen();
      },
    ),
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return MyTabBar(
          child: Scaffold(
            appBar: TopBar(route: state.uri.toString()),  // <— your dynamic top bar
            body: child,
            floatingActionButton: GlobalFAB(
              onPressed: () {
                print("FAB clicked");
              },
              icon: Icons.add,
              background: Colors.orange,
            ),
          ),
        );
      },

      routes: [
        GoRoute(
          path: "/gallery",
          pageBuilder: (_, __) =>
              const NoTransitionPage(child: GalleryScreen()),
        ),
        GoRoute(
          path: "/home",
          pageBuilder: (_, __) =>
              const NoTransitionPage(child: HomeScreen()),
        ),
        GoRoute(
          path: "/matches",
          pageBuilder: (_, __) =>
              const NoTransitionPage(child: MatchesScreen()),
        ),
        GoRoute(
          path: "/schedule",
          pageBuilder: (_, __) =>
              const NoTransitionPage(child: ScheduleScreen()),
        ),
        GoRoute(
          path: "/teams",
          pageBuilder: (_, __) =>
              const NoTransitionPage(child: TeamsScreen()),
        ),
      ],
    ),

  ],
);
