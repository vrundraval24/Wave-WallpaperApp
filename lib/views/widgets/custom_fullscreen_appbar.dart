import 'package:flutter/material.dart';

class CustomFullScreenAppbar extends StatelessWidget {
  const CustomFullScreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: Colors.black12,

              borderRadius: BorderRadius.circular(50),
            ),

            child: IconButton(icon: const Icon(Icons.arrow_back,), onPressed: () {

              Navigator.pop(context);

            },
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
