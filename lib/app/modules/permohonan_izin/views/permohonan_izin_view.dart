import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/modules/login/views/login_view.dart';
import 'package:presence/app/modules/permohonan_izin/views/data_izin.dart';

import '../../profile/views/buttonPrimary.dart';
import '../controllers/permohonan_izin_controller.dart';

class PermohonanIzinView extends GetView<PermohonanIzinController> {
  PermohonanIzinView({Key? key}) : super(key: key);
  final Map<String, dynamic> user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.nipC.text = user["nip"];
    controller.nameC.text = user["name"];
    controller.jobC.text = user["job"];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permohonan Izin'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorConstants.background,
        actions: [
          if (user["role"] == "admin")
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigasi ke halaman pengajuan izin yang tersimpan
              Get.to(SavedPermissionsPage()); // Ganti dengan halaman yang sesuai
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Silahkan ajukan permohonan izin cuti anda. Harap menunggu surat resmi dari direksi untuk pengambilan cuti karyawan",
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
                      ),
                    ),
                    labelText: "NIP",
                    labelStyle: TextStyle(
                      color: ColorConstants.buttonLogout,
                      fontSize: 16,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                readOnly: true,
                controller: controller.nameC,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstants.buttonLogout,
                      ),
                    ),
                    labelText: "Nama",
                    labelStyle: TextStyle(
                      color: ColorConstants.buttonLogout,
                      fontSize: 16,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                readOnly: true,
                controller: controller.jobC,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstants.buttonLogout,
                      ),
                    ),
                    labelText: "Pekerjaan",
                    labelStyle: TextStyle(
                      color: ColorConstants.buttonLogout,
                      fontSize: 16,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: controller.alasanCuti,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstants.buttonLogout,
                      ),
                    ),
                    labelText: "Alasan Cuti",
                    labelStyle: TextStyle(
                      color: ColorConstants.buttonLogout,
                      fontSize: 16,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tanggal Cuti",
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorConstants.buttonLogout,
                      ),),
                      ElevatedButton.icon(
                        onPressed: () {
                          controller.chooseData();
                        },
                        style: buttonDate, icon: Icon(Icons.date_range), label: Text('Pilih Tanggal'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 220),
                    child: Obx(() => Text(
                      DateFormat("dd-MM-yyyy")
                          .format(controller.selectedDate.value)
                          .toString(),
                      style: TextStyle(fontSize: 16, color: Colors.redAccent, fontWeight: FontWeight.w500),
                    )),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => ElevatedButton(
                  style: buttonPrimary,
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.addIzin();
                    }
                  },
                  child: Text(
                    controller.isLoading.isFalse ? "Ajukan Cuti" : "LOADING...",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ))),
            ],
          ),
        ),
      ),
    );
  }
}
