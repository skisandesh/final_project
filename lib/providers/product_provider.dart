import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/firebase_services/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider = FutureProvider((ref) async {
  return ProductService().getProduct();
});

final carouselProvider = FutureProvider((ref) async {
  return ProductService().getCarouselImage();
});
