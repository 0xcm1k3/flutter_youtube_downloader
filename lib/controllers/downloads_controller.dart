import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'dart:isolate';
import 'dart:ui';

import 'package:youtube_downloader/utils/downloadServices.dart';

class DownloadsController extends GetxController {
  final ReceivePort _receivePort = ReceivePort();
  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort?.send([id, status, progress]);
  }

  void downloadFile(String url, String type) async {
    FlutterDownloader.registerCallback(downloadingCallback);
    await DownloadServices.downloadFile(url, type);
    for (int i = 0; i < 3; i++) {
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  @override
  void onReady() {
    super.onReady();
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");
    _receivePort.listen((message) {});
  }
}
