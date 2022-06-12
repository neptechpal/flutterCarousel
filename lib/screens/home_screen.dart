import 'dart:async';

import 'package:flutter/material.dart';

import '../datas/carousel_image.dart';

List<Widget> carouselItems = images
    .map((cimage) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                cimage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ))
    .toList();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;
  late Timer timer;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (currentPage < images.length) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      _pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    //  TODO make a separate file inside widgets folder and write the following code in stateless widget
    Widget dot(bool isactive) {
      return Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(
                50, // set this value to 0 if you want rectangular indicator
              )),
          child: CircleAvatar(
              radius: 4, // size of the dot
              backgroundColor: isactive
                  ? Colors.red
                  : Colors.transparent), // change dot colors here
        ),
      );
    }

    List<Widget> dotlist() {
      List<Widget> list = [];

      for (int i = 0; i < images.length; i++) {
        list.add(i == selectedIndex ? dot(true) : dot(false));
      }
      return list;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Tech101 Carousel"), centerTitle: true),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  children: carouselItems,
                  onPageChanged: (int page) {
                    setState(() {
                      selectedIndex = page;
                    });
                  },
                ),

                //  Position the dot in the place you prefer by chnaging the top, bottom, left right values
                Positioned(
                    bottom: 20, right: 150, child: Row(children: dotlist()))
              ],
            ),
          )
        ],
      ),
    );
  }
}
