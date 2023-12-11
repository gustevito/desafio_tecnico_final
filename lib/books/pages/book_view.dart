import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:desafio_tecnico_final/books/pages/home.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

import '../data/models/book.dart';

class BookView extends StatefulWidget {
  BookModel book;
  BookView({required this.book, super.key});

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  bool loading = false;
  Dio dio = Dio();
  String filePath = "";
  bool isLoaded = false;

  @override
  void initState() {
    download();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (isLoaded) return;
      isLoaded = true;
      VocsyEpub.setConfig(
        themeColor: Theme.of(context).primaryColor,
        identifier: "iosBook",
        scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
        allowSharing: true,
        enableTts: true,
      );
      // get current locator
      VocsyEpub.locatorStream.listen((locator) {
        print('LOCATOR: $locator');
      });
      VocsyEpub.open(
        filePath,
        lastLocation: EpubLocator.fromJson({
          "bookId": "2239",
          "href": "/OEBPS/ch06.xhtml",
          "created": 1539934158390,
          "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
        }),
      );
    });
    super.initState();
  }

  download() async {
    if (Platform.isAndroid || Platform.isIOS) {
      String? firstPart;
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      if (allInfo['version']["release"].toString().contains(".")) {
        int indexOfFirstDot = allInfo['version']["release"].indexOf(".");
        firstPart = allInfo['version']["release"].substring(0, indexOfFirstDot);
      } else {
        firstPart = allInfo['version']["release"];
      }
      int intValue = int.parse(firstPart!);
      if (intValue >= 13) {
        await startDownload();
      } else {
        if (await Permission.storage.isGranted) {
          await Permission.storage.request();
          await startDownload();
        } else {
          await startDownload();
        }
      }
    } else {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyHome();
  }

  startDownload() async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path =
        appDocDir!.path + '/' + 'book' + widget.book.id.toString() + '.epub';
    File file = File(path);
    log(path);

// "https://vocsyinfotech.in/envato/cc/flutter_ebook/uploads/22566_The-Racketeer---John-Grisham.epub"
    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        widget.book.download,
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          setState(() {
            loading = true;
          });
        },
      ).whenComplete(() {
        setState(() {
          loading = false;
          filePath = path;
        });
      });
    } else {
      setState(() {
        loading = false;
        filePath = path;
      });
    }
  }
}
