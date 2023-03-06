import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence/app/modules/login/views/login_view.dart';
import 'package:presence/app/modules/profile/views/buttonPrimary.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  UpdateProfileView({Key? key}) : super(key: key);

  final Map<String, dynamic> user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.nipC.text = user["nip"];
    controller.nameC.text = user["name"];
    controller.emailC.text = user["email"];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Pribadi'),
        backgroundColor: ColorConstants.background,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                height: 60,
                child: const Text(
                  "Silahkan lakukan update informasi pribadi anda, pastikan untuk menjaga keamanan akun Anda.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              TextField(
                readOnly: true,
                controller: controller.nipC,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: ColorConstants.buttonLogout,
                    )),
                    labelText: "NIP",
                    labelStyle: TextStyle(
                      color: ColorConstants.buttonLogout,
                      fontSize: 18,
                    )),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: controller.nameC,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: ColorConstants.buttonLogout,
                    )),
                    labelText: "Nama",
                    labelStyle: TextStyle(
                      color: ColorConstants.buttonLogout,
                      fontSize: 18,
                    )),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                readOnly: true,
                controller: controller.emailC,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorConstants.buttonLogout),
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.buttonLogout,
                    )),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Photo Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GetBuilder<UpdateProfileController>(builder: (c) {
                    if (c.image != null) {
                      return ClipOval(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.file(
                            File(c.image!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      if (user["profile"] != null) {
                        return Column(
                          children: [
                            ClipOval(
                              child: Container(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  user["profile"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.deleteProfile(user["uid"]);
                              },
                              child: Text("delete"),
                            ),
                          ],
                        );
                      } else {
                        return Text("no image choosen");
                      }
                    }
                  }),
                  TextButton(
                    onPressed: () {
                      controller.pickImage();
                    },
                    child: Text("choose"),
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              Obx(() => ElevatedButton(
                  style: buttonPrimary,
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.updateProfile(user["uid"]);
                    }
                  },
                  child: Text(
                    controller.isLoading.isFalse
                        ? "Update Profile"
                        : "LOADING...",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ))),
            ],
          ),
        ),
      ),
    );
  }
}
