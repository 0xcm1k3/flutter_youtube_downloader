import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_downloader/controllers/search_controller.dart';
import 'package:youtube_downloader/controllers/youtubeSearch_controller.dart';
import 'package:youtube_downloader/shared/widgets/bottomSheet.dart';
import 'package:youtube_downloader/shared/widgets/elementCard.dart';
import 'package:youtube_downloader/shared/constants.dart';
import 'package:youtube_downloader/utils/dimensions.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        toolbarHeight: Dimensions.calcH(130),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: Dimensions.calcH(40),
                color: kDarkBlueColor,
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Youtube Downloader",
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: Dimensions.calcH(25),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.calcH(20),
                  ),
                  GetBuilder<YoutubeSearchController>(
                      init: YoutubeSearchController(),
                      builder: (controller) {
                        controller.youtubeInputSearchController.text =
                            Get.arguments["searchValue"] ?? "";
                        return Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: TextField(
                                  controller:
                                      controller.youtubeInputSearchController,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.search_sharp,
                                      color: Colors.white,
                                    ),
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: kDarkBlueColor.withOpacity(0.3),
                                    hintText: "Search for video",
                                    hintStyle: GoogleFonts.nunito(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 0,
                              child: SizedBox(
                                width: Dimensions.calcW(10),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: MaterialButton(
                                onPressed: () => controller.searchItem(),
                                child: Text(
                                  "Search",
                                  style: GoogleFonts.nunito(
                                    fontSize: Dimensions.calcW(17),
                                  ),
                                ),
                                color: kDarkBlueColor,
                              ),
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned.fill(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (scroll) {
                  scroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    width: double.maxFinite,
                    margin:
                        EdgeInsets.symmetric(horizontal: Dimensions.calcW(5)),
                    child: GetX<YoutubeSearchController>(
                      builder: (controller) => Column(
                        crossAxisAlignment:
                            (MediaQuery.of(context).orientation ==
                                    Orientation.landscape)
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Dimensions.calcH(20),
                          ),
                          if (controller.searchResults.isEmpty &&
                              !controller.isLoading.value)
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: Dimensions.calcH(50)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "No search results yet!",
                                      style: GoogleFonts.nunito(
                                        color: Colors.white,
                                        fontSize: Dimensions.calcH(20),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else if (controller.isLoading.value &&
                              controller.searchResults.isEmpty)
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 80,
                                width: 80,
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              ),
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Search results",
                                  style: GoogleFonts.nunito(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: Dimensions.calcH(18),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () => controller.goToPrev(),
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: Dimensions.calcH(37),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      padding: EdgeInsets.symmetric(
                                          vertical: Dimensions.calcH(5),
                                          horizontal: Dimensions.calcW(13)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        controller.currentPage.value.toString(),
                                        style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => controller.goToNext(),
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: Dimensions.calcH(37),
                                      ),
                                    ),
                                  ],
                                ),
                                ...controller.searchResults
                                    .map((searchResults) => ElementCard(
                                          origin: searchResults.videoID,
                                          thumbnail: searchResults.thumbnail,
                                          title: searchResults.title,
                                          showIcon: true,
                                        ))
                                    .toList()
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: GetBuilder<SearchController>(
                init: SearchController(),
                builder: (controller) => Visibility(
                  visible: controller.isSheetOpen,
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GetBuilder<SearchController>(
                builder: (controller) => Visibility(
                  visible: controller.isSheetOpen,
                  child: SingleChildScrollView(
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 350),
                      offset: (controller.isSheetOpen)
                          ? const Offset(0, 0)
                          : const Offset(0, 1),
                      child: const Sheet(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
