import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../login/views/login_view.dart';
import '../controllers/permohonan_izin_controller.dart';

class SavedPermissionsPage extends StatelessWidget {
  final PermohonanIzinController controller = Get.put(PermohonanIzinController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Permohonan Izin'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorConstants.background,
      ),
      body: ScrollConfiguration(
        behavior: BouncingScrollBehavior(),
        child: Obx(
              () {
            if (controller.permissions.isEmpty) {
              return Center(
                child: Text('Data Izin Kosong'),
              );
            } else {
              return ListView.builder(
                itemCount: controller.permissions.length,
                itemBuilder: (context, index) {
                  final permission = controller.permissions[index];
                  final tanggalCuti = permission['tanggal_Cuti'] != null
                      ? (permission['tanggal_Cuti'] as Timestamp).toDate()
                      : null;
                  final formattedDate = tanggalCuti != null
                      ? "${tanggalCuti.day}/${tanggalCuti.month}/${tanggalCuti.year}"
                      : "Tanggal Cuti Tidak Tersedia";

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  permission['name'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(permission['alasan_Cuti']),
                            SizedBox(height: 8),
                            Text(
                              "Tanggal Izin: $formattedDate",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          child: Icon(Icons.delete),
                            onTap: () {
                              final permissionId = permission['id'];
                              if (permissionId != null && permissionId is String) {
                                controller.deletePermission(permissionId);
                                controller.permissions.remove(permission);
                              } else {
                                Get.snackbar('Error', 'Gagal menghapus data izin');
                              }
                            },
                          ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class BouncingScrollBehavior  extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return BouncingScrollPhysics();
  }
}