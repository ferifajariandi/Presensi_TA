import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  TextEditingController currC = TextEditingController();
  TextEditingController newC = TextEditingController();
  TextEditingController confirmC = TextEditingController();
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePass() async {
    if (currC.text.isNotEmpty && confirmC.text.isNotEmpty &&
        newC.text.isNotEmpty) {
      if (newC.text == confirmC.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;

          UserCredential? userCredential = await auth.signInWithEmailAndPassword(email: emailUser, password: currC.text);

          await auth.currentUser!.updatePassword(newC.text);

          // await auth.signOut();

          Get.back();
          Get.snackbar("Berhasil", "Berhasil update password", duration: Duration(seconds: 3), backgroundColor: Colors.white60);



        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar("Terjadi Kesalahan",
                "Password yang dimasukan salah. Tidak dapat update password", duration: Duration(seconds: 3), backgroundColor: Colors.white60);
          } else {
            Get.snackbar("Terjadi Kesalahan", "${e.code.toLowerCase()}");
          }
        } catch (e) {
          Get.snackbar("Terjadi Kesalahan", "Tidak dapat update password", duration: Duration(seconds: 3), backgroundColor: Colors.white60);
        } finally {
          isLoading.value = false;
        }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Confirm password tidak cocok", duration: Duration(seconds: 3), backgroundColor: Colors.white60);
    }
  } else {
      Get.snackbar("Terjadi Kesalahan", "Semua input wajib diisi", duration: Duration(seconds: 3), backgroundColor: Colors.white60);
    }
}}
