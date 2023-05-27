import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PermohonanIzinController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> permissions = <Map<String, dynamic>>[].obs;
  RxBool isLoadingAddPegawai = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController alasanCuti = TextEditingController();
  TextEditingController jobC = TextEditingController();
  TextEditingController dateController = TextEditingController();
  var selectedDate = DateTime.now().obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  // Hanya Menambah data tanpa loading dan get snackbar
  Future<void> addIzin() async {
    if (nameC.text.isNotEmpty &&
        nipC.text.isNotEmpty &&
        jobC.text.isNotEmpty &&
        alasanCuti.text.isNotEmpty) {
      final newPermissionDoc = firestore.collection("izin").doc();
      final newPermissionId = newPermissionDoc.id;

      await newPermissionDoc.set({
        "id": newPermissionId,
        "nip": nipC.text,
        "name": nameC.text,
        "job": jobC.text,
        "alasan_Cuti": alasanCuti.text,
        "tanggal_Cuti": selectedDate.value,
      });

      Get.back();
      Get.back();
      Get.snackbar("Berhasil", "Berhasil mengajukan cuti",
          duration: Duration(seconds: 3), backgroundColor: Colors.white60);
      isLoadingAddPegawai.value = false;
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Alasan Cuti harus diisi',
          duration: Duration(seconds: 3), backgroundColor: Colors.white60);
    }
  }

  chooseData() async {
    DateTime? pickedData = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      // initialDatePickerMode: DatePickerMode.year,
      errorFormatText: 'Masukan tanggal dengan benar',
      errorInvalidText: 'Masukan tanggal dengan benar.',
      helpText: 'Tanggal Cuti',
      fieldLabelText: 'Ajukan Tanggal Cuti',
      fieldHintText: 'Bulan/Hari/Tahun',
      selectableDayPredicate: disableDate,
    );
    if(pickedData!=null && pickedData != selectedDate.value) {
      selectedDate.value = pickedData;
    }
  }

  bool disableDate(DateTime day) {
    if((day.isAfter(DateTime.now().subtract(Duration(days: 1))) && day.isBefore(DateTime.now().add(Duration(days: 5))))) {
      return true;
    }
    return false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchPermissions();
  }

  // Mengambil data presensi
  void fetchPermissions() async {
    try {
      final querySnapshot = await firestore.collection("izin").get();
      permissions.value = querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching permissions: $e");
    }
  }

  // Hapus data history presensi
  Future<void> deletePermission(String permissionId) async {
    try {
      // Hapus data izin dari Firestore berdasarkan ID
      await firestore.collection('izin').doc(permissionId).delete();
      // Tampilkan snackbar atau pesan sukses
      Get.snackbar('Berhasil', 'Data izin berhasil dihapus');
    } catch (error) {
      // Tampilkan snackbar atau pesan error
      Get.snackbar('Error', 'Gagal menghapus data izin');
    }
  }
}

