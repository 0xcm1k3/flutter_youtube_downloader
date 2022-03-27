// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_downloader/controllers/search_controller.dart';
import 'package:youtube_downloader/shared/constants.dart';
import 'package:youtube_downloader/utils/dimensions.dart';

class ElementCard extends GetView<SearchController> {
  final String title, thumbnail, origin;
  final bool showIcon;
  final String desc;
  const ElementCard({
    required this.title,
    required this.thumbnail,
    required this.origin,
    this.desc = "https://youtube.com/watch?v=",
    this.showIcon = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.validate("https://youtube.com/watch?v=$origin");
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Dimensions.calcH(8)),
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.calcW(8), vertical: Dimensions.calcH(8)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: ListTile(
          leading: SizedBox(
            height: 80,
            width: 80,
            child: Image.network(thumbnail),
          ),
          title: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            (desc != "https://youtube.com/watch?v=")
                ? desc
                : "https://youtube.com/watch?v=$origin",
            style: const TextStyle(color: Colors.grey, fontSize: 15),
          ),
          trailing: SizedBox(
            height: 50,
            child: Icon(
              Icons.download,
              color: kDarkBlueColor,
            ),
          ),
        ),
      ),
    );
  }
}
