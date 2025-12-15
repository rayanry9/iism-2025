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
import 'package:iism_2025/viewmodel/common_data_view_model.dart';
import 'package:iism_2025/viewmodel/matches_view_model.dart';
import 'package:iism_2025/viewmodel/teams_view_model.dart';
import 'package:iism_2025/viewmodel/user.dart';
import 'package:iism_2025/widgets/tab_bar.dart';
import 'package:iism_2025/widgets/top_bar.dart';
import 'package:iism_2025/screens/request_outing.dart';
import 'package:iism_2025/screens/approve_request.dart';
import 'package:provider/provider.dart';

GoRouter router({required AuthStatus auth}) => GoRouter(
  refreshListenable: auth,
  redirect: (context, state) {
    if (auth.isLoggedIn && (state.uri.path.contains('/login'))) {
      context.read<UserViewModel>().refetchData();
      return '/home';
    } else if (!auth.isLoggedIn && !(state.uri.path.contains('/login'))) {
      context.read<UserViewModel>().refetchData();
      return '/login';
    }
    return null;
  },
  initialLocation: "/matches",
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
                return LogindetailsScreen(
                  apiService: context.read(),
                  auth: context.read(),
                );
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
              "/campus-map",
              // add more screens here
            };

            final showFab = !hideFabScreens.contains(state.uri.path.toString());
            return MultiProvider(
              providers: [
                ChangeNotifierProxyProvider<UserViewModel, TeamsViewModel>(
                  create: (_) =>
                      TeamsViewModel(user: context.read(), api: context.read()),
                  update: (context, user, teams) {
                    teams!.updateUserViewModel(user);
                    return teams;
                  },
                ),
                FutureProvider(
                  create: (context) async {
                    return CommonDataViewModel.init(context.read());
                  },
                  initialData: CommonDataViewModel.base(context.read()),
                ),
                ChangeNotifierProvider(create: (_) => MatchesViewModel()),
              ],
              child: MyTabBar(
                child: Scaffold(
                  appBar: TopBar(
                    route: state.uri.path.toString(),
                    user: context.read(),
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
              path: "/matches",
              pageBuilder: (_, _) =>
                  const NoTransitionPage(child: MatchesScreen()),
            ),
            GoRoute(
              path: "/home",
              pageBuilder: (_, _) =>
                  const NoTransitionPage(child: HomeScreen()),
            ),
            GoRoute(
              path: "/schedule",
              pageBuilder: (context, _) =>
                  const NoTransitionPage(child: ScheduleScreen()),
            ),
            GoRoute(
              path: "/teams",
              pageBuilder: (context, _) {
                return NoTransitionPage(
                  child: TeamsScreen(user: context.read()),
                );
              },
            ),
            GoRoute(
              path: "/profile",
              pageBuilder: (context, _) {
                return NoTransitionPage(
                  child: ProfileScreen(userViewModel: context.read()),
                );
              },
            ),
            GoRoute(
              path: "/request-outing",
              pageBuilder: (BuildContext context, GoRouterState state) {
                return NoTransitionPage(
                  child: RequestOutingScreen(
                    api: context.read(),
                    user: context.read(),
                  ),
                );
              },
            ),

            GoRoute(
              path: "/approve-request",
              pageBuilder: (BuildContext context, GoRouterState state) {
                return NoTransitionPage(
                  child: ApproveRequestScreen(
                    api: context.read(),
                    user: context.read(),
                  ),
                );
              },
            ),
            GoRoute(
              path: '/chat',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return NoTransitionPage(
                  child: AskSimhiScreen(user: context.read()),
                );
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
