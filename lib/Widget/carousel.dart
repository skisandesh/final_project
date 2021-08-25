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
        future: ProductService().getImage(),
        builder: (ctx, dynamic snapShot) {
          return snapShot.data == null
              ? const Center(
                  child: CircularProgressIndicator(),
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
                          child: getImage!.isNotEmpty
                              ? Image.network(
                                  getImage['imgUrl'],
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                        color: Colors.amber,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Whoops!',
                                          style: TextStyle(fontSize: 30),
                                        ));
                                  },
                                  filterQuality: FilterQuality.high,
                                )
                              : Image.asset('assets/images/welcome.png'),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              '${getImage['title']}',
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
