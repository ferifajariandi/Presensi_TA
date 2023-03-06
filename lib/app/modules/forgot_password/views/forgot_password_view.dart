import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../login/views/login_view.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return true;
          },
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 15),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Text(
                        "Forgot Your Password?",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 24),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 25, left: 15, right: 15),
                  child: Text(
                    "Enter your registered email below\nto recive password reset instruction",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Image.asset(
                  "assets/images/reset.jpg",
                  width: MediaQuery.of(context).size.width,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: controller.emailC,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.email_outlined),
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => ElevatedButton.icon(
                    onPressed: (controller.isLoadingBar.value
                        ? null
                        : () => controller.sendEmail()),
                    icon: controller.isLoadingBar.value
                        ? Transform.scale(
                            scale: 0.5,
                            child: CircularProgressIndicator(
                              backgroundColor: ColorConstants.buttonColor,
                            ),
                          )
                        : Icon(Icons.send_rounded),
                    label: Text(
                      controller.isLoadingBar.value ? "LOADING..." : "SEND",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: ColorConstants.buttonColor,
                        shadowColor: Colors.grey,
                        elevation: 5,
                        minimumSize: Size(400, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
