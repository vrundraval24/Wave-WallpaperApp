import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wave/views/screens/search_screen.dart';

import '../../controller/api.dart';
import '../../main.dart';
import '../../model/photo_model.dart';


class CustomSearchAppbar extends StatefulWidget {
  const CustomSearchAppbar({super.key, required this.onSearchSubmitted});

  final Function(String) onSearchSubmitted; // Define a callback function

  @override
  State<CustomSearchAppbar> createState() => _CustomSearchAppbarState();
}

class _CustomSearchAppbarState extends State<CustomSearchAppbar> {

  List<PhotoModel> searchedWallpapers = [];

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  final Color _appbarForegroundColor = Colors.black;
  final Color _appbarBackgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {


    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 100,
      alignment: Alignment.bottomCenter,
      color: _appbarBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {

              Navigator.pop(context);

            },
            icon: SvgPicture.asset(
              'assets/icons/arrow-left.svg',
            ),
            color: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                onSubmitted: (value) async {

                  widget.onSearchSubmitted(value);


                  // searchedWallpapers = await API.searchedWallpapers(value);


                },

                controller: _searchController,
                focusNode: _searchFocusNode,
                textInputAction: TextInputAction.search,
                cursorColor: Colors.black,
                autofocus: true,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search wallpapers',
                    hintStyle:
                    TextStyle(color: Colors.black26, fontSize: 18)),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _searchController.text = '';
              FocusScope.of(context).requestFocus(_searchFocusNode);

              // here i want to invoke onscreen keyboard

            },
            icon: SvgPicture.asset(
              'assets/icons/cross.svg',
              width: 16,
            ),
            color: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ],
      )
    );
  }
}
