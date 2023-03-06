import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  var isLoadingBar = false.obs;
  var isPasswordHidden = true.obs;
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;


  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      // isLoading.value = true;
      isLoadingBar.value = true;
      //eksekusi
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );

        print(userCredential);

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoadingBar.value = false;
            if (passC.text == "password") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
                title: "Belum Verifikasi",
                middleText:
                    "Kamu belum verifikasi akun ini. Lakukan verifikasi di email kamu.",
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      //isloading
                      isLoadingBar.value = false;
                      Get.back();
                    },
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await userCredential.user!.sendEmailVerification();
                        Get.back();
                        Get.snackbar("Berhasil",
                            "Kami telah mengirim email verifikasi ke akun kamu",
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.white60);
                        isLoadingBar.value = false;
                        // isLoading.value = false;
                      } catch (e) {
                        isLoadingBar.value = false;
                        // isLoading.value = false;
                        Get.snackbar("Terjadi Kesalahan",
                            "Tidak dapat mengirim email verifikasi",
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.white60);
                      }
                    },
                    child: Text(
                      "Kirim Ulang",
                    ),
                  ),
                ]);
          }
        }
        isLoadingBar.value = false;
        // isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoadingBar.value = false;
        // isLoading.value = false;
        if (e.code == "user-not-found") {
          Get.snackbar("Terjadi Kesalahan", "Email tidak terdaftar",
              duration: Duration(seconds: 3), backgroundColor: Colors.white60);
        } else if (e.code == "wrong-password") {
          Get.snackbar("Terjadi Kesalahan", "Password tidak sesuai",
              duration: Duration(seconds: 3), backgroundColor: Colors.white60);
        }
      } catch (e) {
        isLoadingBar.value = false;
        // isLoading.value = false;
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat login.",
            duration: Duration(seconds: 3), backgroundColor: Colors.white60);
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email dan password wajib diisi.",
          duration: Duration(seconds: 3), backgroundColor: Colors.white60);
    }
  }
}
