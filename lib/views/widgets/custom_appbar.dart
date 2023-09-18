import 'package:flutter/material.dart';
import 'package:wave/Constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../main.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({super.key});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  bool _isSearching = false;

  final Color _appbarForegroundColor = Colors.black;
  final Color _appbarBackgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 100,
      alignment: Alignment.bottomCenter,
      color: _appbarBackgroundColor,
      child: _isSearching
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                    });
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
                    child: const TextField(
                      textInputAction: TextInputAction.search,
                      cursorColor: Colors.black,
                      autofocus: true,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search wallpapers',
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 18)),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/cross.svg',
                    width: 16,
                  ),
                  color: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/house-blank.svg',
                    width: 20,
                  ),
                  color: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                const FittedBox(
                    child: Text(
                  'Wave',
                  style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 10),
                )),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 20,
                  ),
                  color: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ],
            ),
    );
  }
}
