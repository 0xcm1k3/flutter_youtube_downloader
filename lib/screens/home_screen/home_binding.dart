import 'package:get/get.dart';
import 'package:youtube_downloader/controllers/ads_controller.dart';
import 'package:youtube_downloader/controllers/search_controller.dart';
import 'package:youtube_downloader/utils/videos_database.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchController());
    Get.put(VideosDatabase(), permanent: true);
    Get.lazyPut(() => AdsController(), fenix: true);
  }
}
