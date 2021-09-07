import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:final_year_project/constants.dart';
import 'package:final_year_project/firebase_services/product.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ProductService().getCarouselImage(),
        builder: (ctx, dynamic snapShot) {
          return snapShot.data == null
              ? const Center(
                  child: LinearProgressIndicator(),
                )
              : CarouselSlider.builder(
                  itemCount: snapShot.data.length,
                  itemBuilder: (ctx, index, _) {
                    DocumentSnapshot<Map<String, dynamic>> sliderImage =
                        snapShot.data![index];
                    Map<String, dynamic>? getImage = sliderImage.data();
                    return Stack(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              getImage!['imageUrl'],
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            )),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            color: Colors.black54,
                            child: Text(
                              '${getImage['productName']}',
                              style: Constants.boldHeadingWhite,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  options: CarouselOptions(
                      autoPlay: true,
                      height: 180.0,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      viewportFraction: 0.85,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      onPageChanged: (i, _) => {
                            setState(() {
                              activeIndex == i;
                            })
                          }),
                );
        });
  }
}
