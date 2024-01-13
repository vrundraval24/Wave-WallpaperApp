import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wave/views/screens/search_screen.dart';


class CustomAppbar extends StatefulWidget {
  const CustomAppbar({super.key});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  // bool _isSearching = false;
  // final TextEditingController _searchController = TextEditingController();


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

                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen()));

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
