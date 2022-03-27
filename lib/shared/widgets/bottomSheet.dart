// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_downloader/controllers/downloads_controller.dart';
import 'package:youtube_downloader/controllers/search_controller.dart';
import 'package:youtube_downloader/shared/constants.dart';
import 'package:youtube_downloader/utils/dimensions.dart';

class Sheet extends StatelessWidget {
  const Sheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      builder: (controllerx) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white,
        ),
        height: (controllerx.video == null) ? 200 : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (controllerx.video == null && controllerx.isLoading)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => controllerx.closeSheet(),
                      icon: Icon(
                        Icons.close_rounded,
                        size: Dimensions.calcH(33),
                        color: kDarkBlueColor,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              )
            else if (controllerx.video == null && !controllerx.isLoading)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => controllerx.closeSheet(),
                      icon: Icon(
                        Icons.close_rounded,
                        size: Dimensions.calcH(33),
                        color: kDarkBlueColor,
                      ),
                    ),
                  ),
                  Text(
                    "VIDEO NOT FOUND!\nplease try again!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      color: kPrimaryColor,
                      fontSize: Dimensions.calcH(17),
                    ),
                  ),
                ],
              )
            else
              SizedBox(
                height: Dimensions.calcH(15),
              ),
            if (controllerx.video != null)
              Container(
                margin: EdgeInsets.only(left: Dimensions.calcW(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        controllerx.video?.title ?? "Video Title",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: Dimensions.calcH(15),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => controllerx.closeSheet(),
                      icon: Icon(
                        Icons.close_rounded,
                        size: Dimensions.calcH(33),
                        color: kDarkBlueColor,
                      ),
                    ),
                  ],
                ),
              ),
            if (controllerx.video != null)
              SizedBox(
                height: Dimensions.calcH(8),
              ),
            if (controllerx.video != null)
              Center(
                child: SizedBox(
                  height: 50,
                  width: 100,
                  child: (controllerx.video?.thumbnailUrl != null)
                      ? Image.network(controllerx.video!.thumbnailUrl)
                      : const Placeholder(),
                ),
              ),
            if (controllerx.video != null)
              ...controllerx.video!.mp3Urls
                  .map(
                    (mp3Url) => GetBuilder<DownloadsController>(
                      init: DownloadsController(),
                      builder: (controller) => ListTile(
                        onTap: () {
                          controller.downloadFile(mp3Url["url"].toString(),
                              mp3Url["type"].toString());
                        },
                        leading: const Icon(
                          Icons.music_note_outlined,
                          color: Color(0xFF172633),
                        ),
                        title: Text(
                          mp3Url["type"].toString(),
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: Dimensions.calcH(18),
                          ),
                        ),
                        subtitle: Text(
                          mp3Url["frequency"].toString() +
                              "\n" +
                              mp3Url["size"].toString(),
                          style: GoogleFonts.nunito(
                            color: Colors.grey,
                            fontSize: Dimensions.calcH(10),
                          ),
                        ),
                        trailing: const Icon(
                          Icons.download,
                          color: Color(0xFF172633),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            if (controllerx.video != null)
              ...controllerx.video!.mp4Urls
                  .map(
                    (mp4Urls) => GetBuilder<DownloadsController>(
                      builder: (controller) => ListTile(
                        onTap: () {
                          controller.downloadFile(mp4Urls["url"].toString(),
                              mp4Urls["type"].toString());
                        },
                        leading: const Icon(
                          Icons.movie_filter_outlined,
                          color: Color(0xFF172633),
                        ),
                        title: Text(
                          "${mp4Urls["type"]}",
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: Dimensions.calcH(18),
                          ),
                        ),
                        subtitle: Text(
                          mp4Urls["frequency"].toString() +
                              "\n" +
                              mp4Urls["size"].toString(),
                          style: GoogleFonts.nunito(
                            color: Colors.grey,
                            fontSize: Dimensions.calcH(10),
                          ),
                        ),
                        trailing: const Icon(
                          Icons.download,
                          color: Color(0xFF172633),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            SizedBox(
              height: Dimensions.calcH(10),
            ),
          ],
        ),
      ),
    );
  }
}
