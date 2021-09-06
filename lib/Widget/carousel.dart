import 'package:final_year_project/constants.dart';
import 'package:final_year_project/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        child: Consumer(
          builder: (context, ref, child) {
            final images = ref(carouselProvider);
            return images.when(
                data: (value) => CarouselSlider.builder(
                      itemCount: value.length,
                      itemBuilder: (ctx, index, _) {
                        final getImage = value[index];
                        return Stack(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  getImage['imageUrl'],
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
                    ),
                loading: () => const CircularProgressIndicator(),
                error: (_, e) => const CircularProgressIndicator());
          },
        ));
  }
}
