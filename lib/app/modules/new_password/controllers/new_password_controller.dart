import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;


  void newPassword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "password") {
        try{
          await auth.currentUser!.updatePassword(newPassC.text);
          String email = auth.currentUser!.email!;

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
            email: email,
            password: newPassC.text,
          );

          Get.offAllNamed(Routes.HOME);

        } on FirebaseAuthException catch (e) {
          if (e.code == "weak-password") {
            Get.snackbar("Terjadi Kesalahan", "Password terlalu lemah, wajib 6 karakter.");
          }
          } catch (e) {
          Get.snackbar("Terjadi Kesalahan", "Tidak dapat membuat password baru.");
        }




      } else {
        Get.snackbar("Terjadi Kesalahan", "Password baru harus diubah");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Password baru wajib diisi");
    }
  }
}
