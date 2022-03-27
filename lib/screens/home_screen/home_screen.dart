import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_downloader/controllers/search_controller.dart';
import 'package:youtube_downloader/shared/widgets/bottomSheet.dart';
import 'package:youtube_downloader/shared/constants.dart';
import 'package:youtube_downloader/utils/dimensions.dart';
import 'package:youtube_downloader/utils/videos_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int inprogress = 0;
  SearchController controller = Get.find<SearchController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        toolbarHeight: Dimensions.calcH(130),
        title: Column(
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
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: TextField(
                      controller: controller.searchInputController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search_sharp,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey[20],
                        hintText: "search or paste link!",
                        hintStyle: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 17,
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
                    onPressed: () => controller.validate(),
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
                  // scroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Container(
                    width: double.maxFinite,
                    margin:
                        EdgeInsets.symmetric(horizontal: Dimensions.calcW(5)),
                    child: Column(
                      crossAxisAlignment: (MediaQuery.of(context).orientation ==
                              Orientation.landscape)
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Dimensions.calcH(20),
                        ),
                        Obx(() {
                          if (Get.find<VideosDatabase>().history.isEmpty) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: Dimensions.calcH(50)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "No recent activites to show !",
                                    style: GoogleFonts.nunito(
                                      color: Colors.white,
                                      fontSize: Dimensions.calcH(20),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SvgPicture.asset("assets/women_bg.svg"),
                                ],
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Recent Activites",
                                      style: GoogleFonts.nunito(
                                        color: Colors.white,
                                        fontSize: Dimensions.calcH(20),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.find<VideosDatabase>()
                                            .clearHistory();
                                      },
                                      icon: Icon(
                                        Icons.delete_forever_rounded,
                                        size: Dimensions.calcH(27),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                ...Get.find<VideosDatabase>().history,
                                SvgPicture.asset(
                                  "assets/bg_2.svg",
                                )
                              ],
                            );
                          }
                        })
                      ],
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
