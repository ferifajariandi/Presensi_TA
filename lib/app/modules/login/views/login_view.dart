import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    bool obscureText = true;
    return Scaffold(
      backgroundColor: Colors.white60,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Container(
                height: height / 2,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                      child: Image.asset("assets/images/logoputih.png"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: height / 1.7,
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 20),
                          decoration: BoxDecoration(
                            color: ColorConstants.inputHintColor,
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xffe8e8e8),
                                blurRadius: 2.0,
                                offset: Offset(0,5)
                              ),
                              BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-5,0)
                              ),
                              BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(5,0)
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Login Account',
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: controller.emailC,
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Obx(
                                () => TextField(
                                  controller: controller.passC,
                                  obscureText:
                                      controller.isPasswordHidden.value,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(15),
                                      labelText: "Password",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      suffix: InkWell(
                                        child: Icon(
                                          controller.isPasswordHidden.value
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                        onTap: () {
                                          controller.isPasswordHidden.value =
                                              !controller
                                                  .isPasswordHidden.value;
                                        },
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Obx(
                                () => ElevatedButton.icon(
                                  onPressed: () async {
                                    if (controller.isLoadingBar.isFalse) {
                                      await controller.login();
                                    }
                                  },
                                  icon: controller.isLoadingBar.value
                                      ? Transform.scale(
                                          scale: 0.5,
                                          child: const CircularProgressIndicator(
                                            backgroundColor:
                                                Colors.white,
                                          ),
                                        )
                                      : const Icon(Icons.login_rounded),
                                  label: Text(
                                    controller.isLoadingBar.value
                                        ? "LOADING..."
                                        : "LOGIN",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: ColorConstants.buttonColor,
                                      elevation: 5,
                                      minimumSize: const Size(400, 40),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: const [
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text("or"),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextButton(
                                onPressed: () =>
                                    Get.toNamed(Routes.FORGOT_PASSWORD),
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: ColorConstants.buttonColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// warna background login
class ColorConstants {
  static Color primaryColor = hexToColor('#8b9ce8');
  static Color inputHintColor = hexToColor('#FFFFFF');
  static Color buttonColor = hexToColor('#5c74de');
  static Color tulisan = hexToColor('#1d1a25');
  static Color pembatas = hexToColor('#e2e2e2');
  static Color warnaButton = hexToColor('#584d77');
  static Color background = hexToColor('#b5a9eb');
  static Color buttonLogout = hexToColor('#5f33ba');





}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex));

  return Color(int.parse(hex.substring(1), radix: 16) +
      (hex.length == 7 ? 0xFF000000 : 0x00000000));
}
