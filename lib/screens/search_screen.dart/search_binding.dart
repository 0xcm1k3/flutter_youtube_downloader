import 'package:get/get.dart';
import 'package:youtube_downloader/controllers/youtubeSearch_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(YoutubeSearchController());
  }
}
