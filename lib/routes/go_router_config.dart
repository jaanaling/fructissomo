import 'package:fructissimo/src/feature/main/model/recipe.dart';
import 'package:fructissimo/src/feature/main/presentation/create_screen.dart';
import 'package:fructissimo/src/feature/main/presentation/data_screen.dart';
import 'package:fructissimo/src/feature/main/presentation/description_screen.dart';
import 'package:fructissimo/src/feature/main/presentation/recipe_screen.dart';
import 'package:fructissimo/src/feature/main/presentation/recomendation_screen.dart';
import 'package:fructissimo/src/feature/main/presentation/shopping_screen.dart';
import 'package:fructissimo/src/feature/main/presentation/storage_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fructissimo/src/feature/main/presentation/main_screen.dart';

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
              builder: (context, state) => MainScreen(key: UniqueKey()),
              routes: [
                GoRoute(
                  path: RouteValue.recipe.path,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child:
                        RecipeScreen(key: UniqueKey(), id: state.extra as int),
                  ),
                ),
                GoRoute(
                  path: RouteValue.recommendation.path,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: RecomendationScreen(key: UniqueKey()),
                  ),
                ),
                GoRoute(
                  path: RouteValue.shop.path,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: ShoppingScreen(key: UniqueKey()),
                  ),
                ),
                GoRoute(
                  path: RouteValue.storage.path,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: StorageScreen(key: UniqueKey()),
                  ),
                ),
                GoRoute(
                  path: RouteValue.create.path,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: CreateScreen(key: UniqueKey()),
                  ),
                ),
                GoRoute(
                  path: RouteValue.base.path,
                  pageBuilder: (context, state) =>
                      NoTransitionPage(child: DataScreen(key: UniqueKey())),
                  routes: [
                    GoRoute(
                      path: RouteValue.description.path,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: DescriptionScreen(
                          key: UniqueKey(),
                          id: state.extra as int,
                        ),
                      ),
                    ),
                  ],
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
