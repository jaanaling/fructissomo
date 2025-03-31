import 'package:flutter/cupertino.dart';
import 'package:fructissimo/src/feature/main/presentation/article_screen.dart';
import 'package:fructissimo/src/feature/main/presentation/articles_screen.dart';
import 'package:fructissimo/src/feature/main/presentation/diary_screen.dart';
import 'package:fructissimo/src/feature/main/presentation/edit_screen.dart';
import 'package:fructissimo/src/feature/main/presentation/profile_screen.dart';
import 'package:fructissimo/src/feature/main/presentation/statistic_screen.dart';
import 'package:go_router/go_router.dart';
import '../src/feature/splash/presentation/screens/splash_screen.dart';
import 'root_navigation_screen.dart';
import 'route_value.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();

GoRouter buildGoRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteValue.splash.path,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) {
        return NoTransitionPage(
          child: RootNavigationScreen(navigationShell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: RouteValue.home.path,
              builder: (context, state) => ProfileScreen(key: UniqueKey()),
              routes: [
                GoRoute(
                    path: RouteValue.diary.path,
                    pageBuilder: (context, state) => NoTransitionPage(
                          child: DiaryScreen(key: UniqueKey()),
                        ),
                    routes: [
                      GoRoute(
                          path: RouteValue.articles.path,
                          pageBuilder: (context, state) => NoTransitionPage(
                                child: ArticlesScreen(
                                  key: UniqueKey(),
                                  id: state.extra as String,
                                ),
                              ),
                          routes: [
                            GoRoute(
                              path: RouteValue.article.path,
                              pageBuilder: (context, state) => NoTransitionPage(
                                child: ArticleScreen(
                                  key: UniqueKey(),
                                  id: state.extra as String,
                                ),
                              ),
                            ),
                          ]),
                    ]),
                GoRoute(
                  path: RouteValue.edit.path,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: EditScreen(key: UniqueKey(),     id: state.extra as String?,),
                  ),
                ),
                GoRoute(
                  path: RouteValue.statistic.path,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: StatisticScreen(key: UniqueKey()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: CupertinoPageScaffold(
            backgroundColor: CupertinoColors.black,
            child: child,
          ),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: RouteValue.splash.path,
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          },
        ),
      ],
    ),
  ],
);
