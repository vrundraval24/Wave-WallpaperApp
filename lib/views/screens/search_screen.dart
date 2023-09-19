import 'package:flutter/material.dart';
import 'package:wave/model/photo_model.dart';
import 'package:wave/views/screens/full_screen.dart';
import 'package:wave/views/widgets/custom_search_appbar.dart';

import '../../controller/api.dart';
import '../../main.dart';
import '../widgets/custom_appbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<PhotoModel> searchedWallpapers = [];

  final ScrollController _scrollController = ScrollController();

  getSearchedResults(String query) async {
    searchedWallpapers = await API.searchedWallpapers(query);
    setState(() {
      // Update the UI with the search results
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.jumpTo(0);
    });
  }

  int hexToColor(String hex) {
    hex = hex.replaceFirst('#', '0xff');
    int a = int.parse(hex);
    return a;
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomSearchAppbar(onSearchSubmitted: (value) {
          // Call the getSearchedResults method with the search query
          getSearchedResults(value);
        }),
      ),
      body: Column(
        children: [
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //   height: 50,
          //   width: mq.width,
          //   child: ListView.builder(
          //     itemBuilder: (context, index) {
          //       return index == 0
          //           ? Categories(
          //         categoryName: list[index],
          //         isSelected: true,
          //       )
          //           : Categories(
          //         categoryName: list[index],
          //         isSelected: false,
          //       );
          //     },
          //     itemCount: list.length,
          //     scrollDirection: Axis.horizontal,
          //   ),
          // ),

          const SizedBox(
            height: 10,
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
                itemCount: searchedWallpapers.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreen(
                              imgUrl: searchedWallpapers[index].imageSrc,
                              imgAvgColor: hexToColor(
                                  searchedWallpapers[index].imageAvgColor),
                            ),
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(hexToColor(
                              searchedWallpapers[index].imageAvgColor)),
                          borderRadius: BorderRadius.circular(12)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          searchedWallpapers[index].imageSrc,
                          fit: BoxFit.cover,
                          width: 100,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
