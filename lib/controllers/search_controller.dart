// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_downloader/models/video_model.dart';
import 'package:youtube_downloader/utils/downloadServices.dart';

class SearchController extends GetxController {
  final TextEditingController _searchInputController = TextEditingController();
  Video? video;
  bool isSheetOpen = false;
  bool isLoading = true;
  RxDouble downloadPercentage = 0.0.obs;
  get searchInputController => _searchInputController;

  // validate input
  void validate([String url = ""]) async {
    String searchInputText = _searchInputController.text.toLowerCase();
    if (url != "") {
      searchInputText = url;
    }
    print(searchInputText);
    if (searchInputText.isNotEmpty) {
      if (searchInputText.contains("https://") ||
          searchInputText.contains("http://")) {
        if (searchInputText.contains("youtube.com")) {
          String videoID = (url != "")
              ? url.split("youtube.com/watch?v=").last
              : _searchInputController.text.split("youtube.com/watch?v=").last;
          isSheetOpen = true;
          update();
          await Future.delayed(const Duration(seconds: 2));
          video = await DownloadServices.getDownloadLinks(videoID);
          isLoading = false;
          _searchInputController.clear();
          update();
        } else if (searchInputText.contains("youtu.be")) {
          String videoID = (url != "")
              ? url.split("youtu.be").last
              : _searchInputController.text.split("youtu.be").last;
          isSheetOpen = true;
          update();
          await Future.delayed(const Duration(seconds: 2));
          video = await DownloadServices.getDownloadLinks(videoID);
          isLoading = false;
          _searchInputController.clear();
          update();
        } else {
          Get.snackbar("Error", "we currently support youtube downloads only!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundGradient: const LinearGradient(
                  colors: [Colors.red, Colors.orange, Colors.yellow]));
        }
      } else {
        Get.toNamed("/search", arguments: {
          "searchValue": searchInputText,
        });
      }
    } else {
      Get.snackbar("Error", "Input can not be emtpy!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundGradient: const LinearGradient(
              colors: [Colors.red, Colors.orange, Colors.yellow]));
    }
  }

  void closeSheet() {
    isSheetOpen = false;
    isLoading = true;
    video = null;
    _searchInputController.clear();
    update();
  }
}
