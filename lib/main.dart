// @dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:youtube_downloader/env_config/routes.dart';
import 'package:youtube_downloader/shared/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await FlutterDownloader.initialize(
        debug: false // optional: set false to disable printing logs to console
        );
  }
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kDarkBlueColor,
      ),
      initialRoute: "/home",
      getPages: AppRoutes.ROUTES,
    ),
  );
}
