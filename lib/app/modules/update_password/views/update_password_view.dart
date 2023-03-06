import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence/app/modules/login/views/login_view.dart';
import 'package:presence/app/modules/profile/views/buttonPrimary.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  const UpdatePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kata Sandi'),
        centerTitle: true,
        backgroundColor: ColorConstants.background,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                height:80,
                child: const Padding(
                  padding: EdgeInsets.only(left: 10, right: 20, top: 20),
                  child: Text(
                    "Kata sandi Anda harus lebih dari enam karakter dan\nberisi angka, huruf, dan karakter khusus '(!'@%).'",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 16
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  obscureText: true,
                  controller: controller.currC,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: "Kata sandi saat ini",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstants.buttonLogout,
                      )
                    ),
                    labelStyle: TextStyle(
                      color: ColorConstants.buttonLogout,
                      fontSize: 16,
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: TextField(
                  obscureText: true,
                  controller: controller.newC,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: "Kata sandi baru",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.buttonLogout,
                          )
                      ),
                      labelStyle: TextStyle(
                        color: ColorConstants.buttonLogout,
                      )
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  obscureText: true,
                  controller: controller.confirmC,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: "Konfirmasi kata sandi",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.buttonLogout,
                          )
                      ),
                      labelStyle: TextStyle(
                        color: ColorConstants.buttonLogout,
                      )
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: ElevatedButton(
                    style: buttonPrimary,
                    onPressed: () {
                      if (controller.isLoading.isFalse) {
                        controller.updatePass();
                      }
                    },
                    child: Text((controller.isLoading.isFalse)
                        ? "CHANGE PASSWORD"
                        : "LOADING..."),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
