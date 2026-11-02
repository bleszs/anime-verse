import 'package:anime_verse/screens/favorite_screen.dart';
import 'package:anime_verse/screens/home_screen.dart';
import 'package:anime_verse/screens/profile_screen.dart';
import 'package:anime_verse/screens/signin_screen.dart';
import 'package:anime_verse/screens/signup_screen.dart';
import 'package:anime_verse/widgets/bottom_navigation_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/detail_screen.dart';
import '../data/dummy_data.dart';

class AppRoutes {
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String home = '/home';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String details = '/details';
}

GoRouter createRouter() {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  // routes.dart
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.signIn,
    routes: [
      // 1. Auth Routes
      GoRoute(
        path: AppRoutes.signIn,
        name: 'sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        name: 'sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),

      // 2. Detail Route
      GoRoute(
        path: '${AppRoutes.details}/:id',
        name: 'detail',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final animeId = state.pathParameters['id'] ?? '';
          final matches = DummyData.animeList.where(
            (anime) => anime.id == animeId,
          );
          if (matches.isEmpty) {
            return const Scaffold(body: Center(child: Text('Anime not found')));
          }
          final anime = matches.first;
          return DetailScreen(
            animeId: anime.id,
            title: anime.title,
            imagePath: anime.imagePath,
            genre: anime.genre,
            rating: anime.rating,
            totalEpisodes: anime.totalEpisodes,
            description: anime.description,
          );
        },
      ),

      // 3. ShellRoute (Untuk Halaman yang menggunakan Bottom Navigation Bar)
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) {
          return BottomNavigationShell(navigationShell: child);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.favorites,
                name: 'favorite',
                builder: (context, state) => const FavoriteScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: 'profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
