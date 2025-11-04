import 'package:IISM/main.dart';
import 'package:IISM/screens/contact.dart';
import 'package:IISM/screens/gallery.dart';
import 'package:IISM/screens/login.dart';
import 'package:IISM/screens/matches.dart';
import 'package:IISM/screens/notification.dart';
import 'package:IISM/screens/profile.dart';
import 'package:IISM/screens/schedule.dart';
import 'package:IISM/screens/teams.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(title: "Home Page");
      },
      routes: [
        GoRoute(
          path: "/login",
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          path: "/contact",
          builder: (BuildContext context, GoRouterState state) {
            return const ContactScreen();
          },
        ),
        GoRoute(
          path: "/gallery",
          builder: (BuildContext context, GoRouterState state) {
            return const GalleryScreen();
          },
        ),
        GoRoute(
          path: "/matches",
          builder: (BuildContext context, GoRouterState state) {
            return const MatchesScreen();
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
        GoRoute(
          path: "/schedule",
          builder: (BuildContext context, GoRouterState state) {
            return const ScheduleScreen();
          },
        ),
        GoRoute(
          path: "/teams",
          builder: (BuildContext context, GoRouterState state) {
            return const TeamsScreen();
          },
        ),
      ],
    ),
  ],
);
