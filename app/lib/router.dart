import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/screens/campus_map_screen.dart';
import 'package:iism_2025/screens/chat.dart';
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
import 'package:iism_2025/services/auth.dart';
import 'package:iism_2025/widgets/tab_bar.dart';
import 'package:iism_2025/widgets/top_bar.dart';
import 'package:iism_2025/screens/request_outing.dart';
import 'package:iism_2025/screens/approve_request.dart';

GoRouter router({required AuthStatus auth}) => GoRouter(
  refreshListenable: auth,
  redirect: (context, state) {
    if (auth.isLoggedIn && (state.uri.path.contains('/login'))) {
      return '/home';
    } else if (!auth.isLoggedIn && !(state.uri.path.contains('/login'))) {
      return '/login';
    }
    return null;
  },
  initialLocation: "/home",
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: "/login",
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
        ShellRoute(
          builder: (context, state, child) {
            return Stack(
              children: [
                Container(color: CustomColors.darkBlue),
                SafeArea(child: child),
              ],
            );
          },
          routes: [
            GoRoute(
              path: "/splash",
              builder: (BuildContext context, GoRouterState state) {
                return const SplashScreen();
              },
            ),
            GoRoute(
              path: "/logindetails",
              builder: (BuildContext context, GoRouterState state) {
                return const LogindetailsScreen();
              },
            ),
          ],
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

        ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget child) {
            final hideFabScreens = {
              "/chat",
              // add more screens here
            };

            final showFab = !hideFabScreens.contains(state.uri.path.toString());
            return MyTabBar(
              child: Scaffold(
                appBar: TopBar(
                  route: state.uri.path.toString(),
                ), // <— your dynamic top bar
                backgroundColor: Colors.white,
                body: child,
                floatingActionButton: showFab
                    ? Material(
                        elevation: 6,
                        color: CustomColors.orange,
                        borderRadius: BorderRadius.circular(40),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            context.push('/chat');
                          },
                          highlightColor: CustomColors.orange,
                          splashColor: Colors.orange,
                          borderRadius: BorderRadius.circular(40),
                          child: Ink(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/simhi.png"),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                            ),
                            height: 65,
                            width: 65,
                          ),
                        ),
                      )
                    : null,
              ),
            );
          },

          routes: [
            GoRoute(
              path: "/gallery",
              pageBuilder: (_, _) =>
                  const NoTransitionPage(child: GalleryScreen()),
            ),
            GoRoute(
              path: "/home",
              pageBuilder: (_, _) =>
                  const NoTransitionPage(child: HomeScreen()),
            ),
            GoRoute(
              path: "/matches",
              pageBuilder: (_, _) =>
                  const NoTransitionPage(child: MatchesScreen()),
            ),
            GoRoute(
              path: "/schedule",
              pageBuilder: (_, _) =>
                  const NoTransitionPage(child: ScheduleScreen()),
            ),
            GoRoute(
              path: "/teams",
              pageBuilder: (_, _) =>
                  const NoTransitionPage(child: TeamsScreen()),
            ),
            GoRoute(
              path: "/profile",
              pageBuilder: (BuildContext context, GoRouterState state) {
                return NoTransitionPage(child: const ProfileScreen());
              },
            ),
            GoRoute(
              path: "/request-outing",
              pageBuilder: (BuildContext context, GoRouterState state) {
                return NoTransitionPage(child: const RequestOutingScreen());
              },
            ),

            GoRoute(
              path: "/approve-request",
              pageBuilder: (BuildContext context, GoRouterState state) {
                return NoTransitionPage(child: const ApproveRequestScreen());
              },
            ),
            GoRoute(
              path: '/chat',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return NoTransitionPage(child: const AskSimhiScreen());
              },
            ),
            GoRoute(
              path: '/campus-map',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return NoTransitionPage(child: const CampusMapScreen());
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
