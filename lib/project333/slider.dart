import 'dart:async';

import 'package:flutter/material.dart';

class SliderInfo extends StatelessWidget {
  final String img;

  const SliderInfo({
    super.key,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  final List<SliderInfo> boxList = [
    SliderInfo(
      img: 'assets/images/ugstimg.jpg',
    ),
    SliderInfo(
      img: 'assets/images/uglect1.jpg',
    ),
    SliderInfo(
      img: 'assets/images/2.jpg',
    ),

    SliderInfo(
      img: 'assets/images/1.jpg',
    ),
    SliderInfo(
      img: 'assets/images/3.jpg',
    ),
    SliderInfo(
      img: 'assets/images/ugstimg.jpg',
    ),
  ];

  late final PageController pageController;
  final int totalBoxes = 6;
  int pageNo = 0;
  late final Timer carouselTimer;
  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 5) {
        pageNo = 0; //restart when page num is
      }
      pageController.animateToPage(pageNo,
          duration: const Duration(seconds: 1), curve: Curves.easeInOutCirc);
      pageNo++;
      if (pageNo > totalBoxes) {
        pageNo = 0;
      }
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.75);
    carouselTimer = getTimer();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            
            // a container will work too
            height:
                250, // here the height is representing the size of the actual box since the ziebox here is like the container
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                pageNo = index;
                setState(() {});
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: pageController,
                  builder: (context, child) {
                    return child!;
                    //line abv to return the child widget
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(
                        6.0), // if padding no dey sauce just use margin
                    height: 200,
                    decoration: BoxDecoration(
                      
                      image: DecorationImage(
                        
                        image: AssetImage(boxList[index].img, ),
                        
                        fit:BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                      // color: Colors.black
                    ),

                  ),
                );
              },
              itemCount: totalBoxes,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                6,
                (index) => Container(
                      margin: const EdgeInsets.all(5),
                      child: Icon(
                        Icons.circle,
                        size: 12,
                        color: pageNo == index
                            ? Color.fromARGB(255, 128, 115, 2)
                            : Color.fromARGB(255, 36, 2, 94),
                      ),
                    )).toList(),
          )
        ],
      ),
    ));
  }
}
