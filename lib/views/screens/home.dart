import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wave/controller/api.dart';
import 'package:wave/model/photo_model.dart';
import 'package:wave/views/screens/full_screen.dart';
import 'package:wave/views/widgets/categories.dart';
import 'package:wave/views/widgets/custom_appbar.dart';
import 'package:move_to_background/move_to_background.dart';

import '../../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  // List of categories
  List list = [
    'All',
    'Nature',
    'Gaming',
    'K-Drama',
    'Anime',
    'Aesthetic',
    'Korean',
    'Hot',
    'Japanese',
    'Girls',
    'Coding',
    'School',
    'Minimalistic',
  ];

  List<PhotoModel> listImage = [];

  loadWallpapers(int pageNumber) async {
    listImage = await API.loadMoreWallpapers(pageNumber);
    setState(() {});
  }

  getWallpapers() async {
    // print("I was called");
    listImage = await API.getTrendingWallpapers();
    setState(() {});
  }
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   getWallpapers();
  // }

  int hexToColor(String hex) {
    hex = hex.replaceFirst('#', '0xff');
    int a = int.parse(hex);
    return a;
  }

  int pageNumber = 1;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 700) {
        pageNumber += 1;
        // print(pageNumber);
        loadWallpapers(pageNumber);
        // getWallpapers();
      }
    });

    getWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          flexibleSpace: const CustomAppbar(),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 50,
              width: mq.width,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return index == 0
                      ? Categories(
                          categoryName: list[index],
                          isSelected: true,
                        )
                      : Categories(
                          categoryName: list[index],
                          isSelected: false,
                        );
                },
                itemCount: list.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: ((mq.width / 2) * 1200) / 800,
                  ),
                  itemCount: listImage.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreen(
                                imgUrl: listImage[index]
                                    .highQualityFullScreenImages,
                                imgAvgColor:
                                    hexToColor(listImage[index].imageAvgColor),
                                imgWidth: listImage[index].imgWidth, imgHeight: listImage[index].imgHeight,
                              ),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(
                                hexToColor(listImage[index].imageAvgColor)),
                            borderRadius: BorderRadius.circular(12)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            listImage[index].imageSrc,
                            fit: BoxFit.cover,
                            width: 100,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
