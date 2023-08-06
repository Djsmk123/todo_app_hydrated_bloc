import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> fakeLoading() async {
  EasyLoading.show(status: "Please wait...");
  await Future.delayed(const Duration(seconds: 2));
  EasyLoading.dismiss();
}
