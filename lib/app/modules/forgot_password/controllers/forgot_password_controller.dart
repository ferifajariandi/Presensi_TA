import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailC = TextEditingController();
  RxBool isLoading = false.obs;
  var isLoadingBar = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;



  void sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoadingBar.value = true;
      await Future.delayed(Duration(seconds: 3));
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        Get.snackbar("Berhasil", "Kami telah mengirimkan email reset password, Periksa email kamu.",duration: Duration(seconds: 3),backgroundColor: Colors.white60);
        Get.offAllNamed(Routes.LOGIN);
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat mengirim reset password",duration: Duration(seconds: 3), backgroundColor: Colors.white60);
      } finally {
        isLoadingBar.value = false;
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email wajib diisi.",duration: Duration(seconds: 3),);
    }
  }
}