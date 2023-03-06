import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../login/views/login_view.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: ColorConstants.background,
        body: Center(
            child: Container(
              width: Get.width * 0.5,
              height: Get.height * 0.5,
              child: Image.asset("assets/images/logoputih.png"),
            )
        ),
      ),
    );
  }
}
