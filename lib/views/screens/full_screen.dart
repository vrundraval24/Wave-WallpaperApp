import 'package:flutter/material.dart';

import '../../main.dart';

class FullScreen extends StatelessWidget {
  const FullScreen(
      {super.key, required this.imgUrl, required this.imgAvgColor});

  final String imgUrl;
  final int imgAvgColor;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,


        leading: Container(
          color: Colors.white,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black,),
          ),
        ),
        // iconTheme: const IconThemeData(color: Colors.white,),
      ),
      body: Container(
        width: mq.width,
        height: mq.height,
        decoration: BoxDecoration(
          color: Color(imgAvgColor),
          image: DecorationImage(
            image: NetworkImage(imgUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
