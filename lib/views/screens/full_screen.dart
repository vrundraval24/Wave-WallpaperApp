import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:wave/views/widgets/custom_fullscreen_appbar.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';


import '../../main.dart';

class FullScreen extends StatefulWidget {
  const FullScreen(
      {super.key,
      required this.imgUrl,
      required this.imgAvgColor,
      required this.imgWidth,
      required this.imgHeight});

  final String imgUrl;
  final int imgAvgColor;
  final int imgWidth;
  final int imgHeight;

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  // late Uint8List _imageFile;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  bool loading = false;
  int progress = 0;
  final Dio dio = Dio();

  // Future<bool> saveFile(String url, String fileName) async {
  //   Directory directory;
  //
  //   try {
  //     directory = (await getExternalStorageDirectory())!;
  //     print(directory.path);
  //
  //     String newPath = "";
  //     List<String> folders = directory.path.split('/');
  //
  //     for (int i = 1; i < folders.length; i++) {
  //       if (folders[i] != 'Android') {
  //         newPath += '/${folders[i]}';
  //       } else {
  //         break;
  //       }
  //     }
  //
  //     newPath = '$newPath/Wave - Wallpaper';
  //     directory = Directory(newPath);
  //     print(directory);
  //
  //     if (!await directory.exists()) {
  //       await directory.create(recursive: true);
  //     }
  //
  //     if (await directory.exists()) {
  //       File saveFile = File(directory.path + '/$fileName');
  //       await dio.download(widget.imgUrl, saveFile.path,
  //           onReceiveProgress: (downloaded, totalSize) {
  //         setState(() {
  //           progress = downloaded ~/ totalSize;
  //         });
  //       });
  //       return true;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //
  //   return false;
  // }

  // Future<bool> _requestPermission(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     var result = await permission.request();
  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  // }

  // downloadFile() async {
  //   setState(() {
  //     loading = true;
  //   });
  //
  //   bool downloaded = await saveFile(widget.imgUrl, 'img');
  //
  //   if (downloaded) {
  //     print("download success");
  //   } else {
  //     print("download Failed");
  //   }
  //
  //   setState(() {
  //     loading = false;
  //   });
  // }

  late bool isDownloaded;

  downloadImage() async {
    setState(() {
      loading = true;
    });

    try {
      var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);

      isDownloaded = await _saveFile(file);

      print("Wallpaper downloaded");
    } on PlatformException {
      print('Failed to download wallpaper.');
    }

    setState(() {
      loading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: isDownloaded
          ? const Text(
              "Image downloaded.",
              style: TextStyle(fontSize: 16),
            )
          : const Text(
              "Downloading failed.",
              style: TextStyle(fontSize: 16),
            ),
      backgroundColor: Colors.black12,
      elevation: 0,
      duration: const Duration(seconds: 2),
    ));
    // : ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("Downloading failed.", style: TextStyle(fontSize: 16),),
    //       backgroundColor: Colors.black12,
    //       elevation: 0,
    //       duration: Duration(seconds: 2),
    //
    //     ));
  }

  // old - working
  Future<void> setWallpaper() async {
    setState(() {
      loading = true;
    });

    try {

      int location = WallpaperManager.BOTH_SCREEN;



      final ss = await screenshotController.capture();

      if(ss != null){

        final file = await DefaultCacheManager().putFile('url', ss);

        final result = await WallpaperManager.setWallpaperFromFile(
            file.path, location);

        log("Wallpaper set $result");

      }

      // var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
      //
      //
      // var croppedImage = await ImageCropper().cropImage(
      //   sourcePath: file.path,
      //   aspectRatio: CropAspectRatio(ratioX: mq.width, ratioY: mq.height),
      //
      //   uiSettings: [
      //     AndroidUiSettings(
      //
      //       hideBottomControls: true,
      //       statusBarColor: Colors.black,
      //       toolbarTitle: 'Crop Wallpaper'
      //
      //     ),
      //   ]
      // );
      //
      //
      // if (croppedImage != null) {
      //   bool result = await WallpaperManager.setWallpaperFromFile(
      //       croppedImage.path, location);
      //
      //   print("Wallpaper set $result");
      // }


    } on PlatformException {
      log('Failed to get wallpaper.');
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: const CustomFullScreenAppbar(),
      ),
      body: Stack(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Container(
              width: mq.width,
              color: Colors.red,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: (mq.height * widget.imgWidth) / widget.imgHeight,
                  height: mq.height,
                  decoration: BoxDecoration(
                    color: Color(widget.imgAvgColor),
                    image: DecorationImage(
                      image: NetworkImage(widget.imgUrl),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // screenshotController
                      //     .capture(delay: const Duration(milliseconds: 10))
                      //     .then((capturedImage) async {
                      //   DefaultCacheManager().putFile('ggf', capturedImage!);
                      //   DefaultCacheManager().
                      //   ShowCapturedWidget(context, capturedImage);
                      // }).catchError((onError) {
                      //   print(onError);
                      // });



                      // DefaultCacheManager().getFileFromMemory('key');
                      //
                      //
                      //






                      // screenshotController
                      //     .capture(delay: const Duration(milliseconds: 10))
                      //     .then((capturedImage) {
                      //   _saveNetworkImage(capturedImage!);
                      // }).catchError((onError) {
                      //   print(onError);
                      // });

                      setWallpaper();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black12,
                        surfaceTintColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.transparent),
                    child: const Text(
                      'Set wallpaper',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Positioned(
          //   bottom: 100,
          //   width: 200,
          //   left: mq.width / 2 - 100,
          //   height: 50,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       // downloadFile();
          //     },
          //     style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.black12,
          //         surfaceTintColor: Colors.transparent,
          //         shadowColor: Colors.transparent,
          //         foregroundColor: Colors.transparent),
          //     child: const Text(
          //       'Download',
          //       style: TextStyle(color: Colors.white, fontSize: 18),
          //     ),
          //   ),
          // ),

          loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.black12,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("Captured widget screenshot"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }

  Future<bool> _saveFile(File image) async {
    final result = await ImageGallerySaver.saveFile(image.path);
    print("result: ${result['isSuccess']}");

    return result['isSuccess'];
  }

  // _saveNetworkImage(Uint8List capturedImage) async {
  //   await ImageGallerySaver.saveImage(capturedImage, quality: 100);
  // }
}
