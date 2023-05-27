import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/login/views/login_view.dart';

class AddPegawaiController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAddPegawai = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();
  TextEditingController jobC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddPegawai() async {
    if (passAdminC.text.isNotEmpty) {
      isLoadingAddPegawai.value = true;
      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential userCredentialAdmin =
            await auth.signInWithEmailAndPassword(
                email: emailAdmin, password: passAdminC.text);

        UserCredential pegawaiCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password",
        );
        if (pegawaiCredential.user != null) {
          String uid = pegawaiCredential.user!.uid;

          firestore.collection("pegawai").doc(uid).set({
            "nip": nipC.text,
            "name": nameC.text,
            "job": jobC.text,
            "email": emailC.text,
            "uid": uid,
            "role": "pegawai",
            "createdAt": DateTime.now().toIso8601String(),
          });

          await pegawaiCredential.user!.sendEmailVerification();

          await auth.signOut();

          UserCredential userCredentialAdmin =
              await auth.signInWithEmailAndPassword(
                  email: emailAdmin, password: passAdminC.text);

          Get.back();
          Get.back();
          Get.snackbar("Berhasil", "Berhasil menambahkan pegawai",
              duration: Duration(seconds: 3), backgroundColor: Colors.white60);
          isLoadingAddPegawai.value = false;
        }
      } on FirebaseAuthException catch (e) {
        isLoadingAddPegawai.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar("Terjadi Kesalahan", "Password terlalu singkat.",
              duration: Duration(seconds: 3), backgroundColor: Colors.white60);
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Terjadi Kesalahan",
              "Pegawai sudah ada. Kamu tidak dapat menambahkan pegawai dengan email ini.",
              duration: Duration(seconds: 3), backgroundColor: Colors.white60);
        } else if (e.code == "wrong-password") {
          Get.snackbar(
              "Terjadi Kesalahan", "Admin tidak dapat menambahkan pegawai, Password salah!",
              duration: Duration(seconds: 3), backgroundColor: Colors.white60);
        } else {
          Get.snackbar("Terjadi Kesalahan", "${e.code}",
              duration: Duration(seconds: 3), backgroundColor: Colors.white60);
        }
      } catch (e) {
        isLoadingAddPegawai.value = false;
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat menambahkan pegawai.",
            duration: Duration(seconds: 3), backgroundColor: Colors.white60);
      }
    } else {
      isLoading.value = false;
      Get.snackbar(
          "Terjadi Kesalahan", "Password wajib diisi untuk melakukan validasi",
          duration: Duration(seconds: 3), backgroundColor: Colors.white60);
    }
  }

  Future<void> addPegawai() async {
    if (nameC.text.isNotEmpty &&
        jobC.text.isNotEmpty &&
        nipC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      Get.defaultDialog(
        contentPadding: EdgeInsets.all(15),
        title: "Validasi Admin",
        content: Column(
          children: [
            const Text(
              "Silahkan masukan password untuk memvalidasi admin !",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: passAdminC,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(

                ),
              ),
            )
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              isLoading.value = false;
              Get.back();
            },
            child: const Text("Cancel", style: TextStyle(color: Colors.redAccent),),
          ),
          Obx(
            () => ElevatedButton.icon(
              onPressed: () async {
                if (isLoadingAddPegawai.isFalse) {
                  await prosesAddPegawai();
                }
                isLoading.value = false;
              },
              icon: Icon(Icons.person_add_alt_1_rounded),
              label: Text(
                  isLoadingAddPegawai.isFalse ? "Add Pegawai" : "LOADING..."),
              style: ElevatedButton.styleFrom(
                elevation: 1,
                primary: ColorConstants.buttonLogout,
              ),
              // child: Text(
              //     isLoadingAddPegawai.isFalse ? "Add Pegawai" : "LOADING..."),
            ),
          ),
        ],
      );
//
    } else {
      Get.snackbar(
          "Terjadi Kesalahan", "NIP, nama, pekerjaan, dan email harus diisi.",
          duration: Duration(seconds: 3), backgroundColor: Colors.white60);
    }
  }
}
