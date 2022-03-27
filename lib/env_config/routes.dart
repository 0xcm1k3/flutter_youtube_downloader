// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:youtube_downloader/env_config/route_links.dart';
import 'package:youtube_downloader/screens/home_screen/home_binding.dart';
import 'package:youtube_downloader/screens/home_screen/home_screen.dart';
import 'package:youtube_downloader/screens/search_screen.dart/search_binding.dart';
import 'package:youtube_downloader/screens/search_screen.dart/search_screen.dart';
import 'package:youtube_downloader/screens/splash_screen/splash_screen.dart';

class AppRoutes {
  static List<GetPage> ROUTES = [
    GetPage(
      name: Links.SPLASH_SCREEN,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Links.HOME_SCREEN,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Links.SEARCH_SCREEN,
      page: () => const SearchScreen(),
      binding: SearchBinding(),
    ),
  ];
}
