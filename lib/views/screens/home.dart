import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wave/views/widgets/categories.dart';
import 'package:wave/views/widgets/custom_appbar.dart';

import '../../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  List listImage = [
    'https://images.pexels.com/photos/6899924/pexels-photo-6899924.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/663487/pexels-photo-663487.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/6899782/pexels-photo-6899782.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/17977593/pexels-photo-17977593/free-photo-of-young-woman-standing-on-the-meadow-stretching-her-arms-towards-rising-sun.jpeg',
    'https://images.pexels.com/photos/818593/pexels-photo-818593.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/2449600/pexels-photo-2449600.png?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/11468739/pexels-photo-11468739.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/8537303/pexels-photo-8537303.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/3408353/pexels-photo-3408353.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/18193597/pexels-photo-18193597/free-photo-of-lying-woman-leaning-on-tree-and-holding-apple.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',


  ];

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
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
              child: MasonryGridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                itemCount: listImage.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(10),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                          listImage[index],
                          fit: BoxFit.cover,
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
