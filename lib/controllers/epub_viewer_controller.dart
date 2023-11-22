import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

const platform = MethodChannel('my_channel');

Future<void> fetchAndroidVersion(Function startDownload) async {
  final String? version = await getAndroidVersion();
  if (version != null) {
    String? firstPart;
    if (version.toString().contains(".")) {
      int indexOfFirstDot = version.indexOf(".");
      firstPart = version.substring(0, indexOfFirstDot);
    } else {
      firstPart = version;
    }
    int intValue = int.parse(firstPart);
    if (intValue >= 13) {
      await startDownload();
    } else {
      final PermissionStatus status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        await startDownload();
      } else {
        await Permission.storage.request();
      }
    }
    print("ANDROID VERSION: $intValue");
  }
}

Future<String?> getAndroidVersion() async {
  try {
    print("TESTANDO");
    final String version = await platform.invokeMethod('getAndroidVersion');
    return version;
  } on PlatformException catch (e) {
    print("FAILED TO GET ANDROID VERSION: ${e.message}");
    return null;
  }
}

download(Function startDownload) async {
  if (Platform.isIOS) {
    final PermissionStatus status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      await startDownload();
    } else {
      await Permission.storage.request();
    }
  } else if (Platform.isAndroid) {
    await fetchAndroidVersion(startDownload);
  } else {
    PlatformException(code: '500');
  }
}

openBook(dynamic context, String filePath, bookId) {
  VocsyEpub.setConfig(
    themeColor: Theme.of(context).primaryColor,
    identifier: "iosBook",
    scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
    allowSharing: true,
    enableTts: true,
    nightMode: true,
  );

  // get current locator
  VocsyEpub.locatorStream.listen((locator) {
    print('LOCATOR: $locator');
  });

  VocsyEpub.open(
    filePath,
    lastLocation: EpubLocator.fromJson({
      "bookId": "${bookId}",
      "href": "/OEBPS/ch06.xhtml",
      "created": 1539934158390,
      "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
    }),
  );
}
