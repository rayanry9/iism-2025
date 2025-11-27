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

import 'package:iism_2025/widgets/tab_bar.dart';

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
        return MyTabBar(child: child);
      },
      routes: [
        GoRoute(
          path: "/gallery",
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(child: const GalleryScreen());
          },
        ),
        GoRoute(
          path: "/home",
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(child: const HomeScreen());
          },
        ),
        GoRoute(
          path: "/matches",
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(child: const MatchesScreen());
          },
        ),
        GoRoute(
          path: "/schedule",
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(child: const ScheduleScreen());
          },
        ),
        GoRoute(
          path: "/teams",
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(child: const TeamsScreen());
          },
        ),
      ],
    ),
  ],
);
