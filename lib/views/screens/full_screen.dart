import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:wave/views/widgets/custom_fullscreen_appbar.dart';

import '../../main.dart';

class FullScreen extends StatelessWidget {
  const FullScreen(
      {super.key, required this.imgUrl, required this.imgAvgColor});

  final String imgUrl;
  final int imgAvgColor;

  // old - working
  Future<void> setWallpaper() async {


    try {
      int location = WallpaperManager.BOTH_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(imgUrl);
      bool result =
      await WallpaperManager.setWallpaperFromFile(file.path, location);

      print("Wallpaper set $result");
    }on PlatformException {
      print('Failed to get wallpaper.');
    }



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
          Container(
            width: mq.width,
            height: mq.height,
            decoration: BoxDecoration(
              color: Color(imgAvgColor),
              image: DecorationImage(
                image: NetworkImage(imgUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            width: 200,
            left: mq.width/2 - 100,
            height: 50,

            child: ElevatedButton(
                onPressed: () {
                  setWallpaper();
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black12,
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.transparent
              ),
                child: const Text(
                  'Set wallpaper',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),

            ),
          ),
        ],
      ),
    );
  }
}
