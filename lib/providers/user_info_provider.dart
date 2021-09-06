import 'package:final_year_project/firebase_services/userinfo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = FutureProvider((ref) async {
  return UserService().getUserInfo();
});
