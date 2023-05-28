import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../routes/app_pages.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void changePage(int i) async {
    DateTime now = DateTime.now();

    if (now.weekday == DateTime.saturday || now.weekday == DateTime.sunday) {
      // Hari libur (Sabtu dan Minggu)
      if (i == 1) {
        Get.dialog(
          AlertDialog(
            title: Text("Informasi"),
            content:
                Text("Tidak dapat melakukan presensi karena hari libur kerja."),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text("OK"),
              ),
            ],
          ),
        );
      } else {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Tidak dapat mengakses halaman ini saat hari libur.",
          duration: Duration(seconds: 3),
          backgroundColor: Colors.white60,
        );
      }
      return;
    }
    switch (i) {
      case 1:
        Map<String, dynamic> dataResponse = await determinePosition();
        if (dataResponse["error"] != true) {
          Position position = dataResponse["position"];
          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          String address =
              "${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}";

          // cek jarak distance antara 2 posisi device
          double distance = Geolocator.distanceBetween(
              -6.9142617, 110.57246693, position.latitude, position.longitude);

          const double MAX_DISTANCE = 200;
          if (distance <= MAX_DISTANCE) {
            await updatePosition(position, address);
            await presensi(position, address, distance);
          } else {
            Get.snackbar(
              "Terjadi Kesalahan",
              "Anda berada di luar area presensi.",
              duration: Duration(seconds: 3),
              backgroundColor: Colors.white60,
            );
          }
        } else {
          Get.snackbar(
            "Terjadi Kesalahan",
            dataResponse["message"],
            duration: Duration(seconds: 3),
            backgroundColor: Colors.white60,
          );
        }
        break;
      case 2:
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }

  // melakukan update posisi
  Future<void> updatePosition(Position position, String address) async {
    String uid = await auth.currentUser!.uid;

    firestore.collection("pegawai").doc(uid).update({
      "position": {
        "lat": position.latitude,
        "long": position.longitude,
      },
      "address": address,
    });
  }

  Future<void> presensi(
      Position position, String address, double distance) async {
    String uid = await auth.currentUser!.uid;

    CollectionReference<Map<String, dynamic>> colPresence =
        await firestore.collection("pegawai").doc(uid).collection("presence");
    QuerySnapshot<Map<String, dynamic>> snapPresence = await colPresence.get();
    DateTime now = DateTime.now();
    String todayDocID = DateFormat.yMd().format(now).replaceAll("/", "-");

    // Cek waktu presensi
    int startHour = 8; // Jam mulai presensi (8 pagi)
    int endHour = 17; // Jam akhir presensi (5 sore)
    int currentHour = now.hour;

    if (currentHour < startHour || currentHour >= endHour) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Presensi hanya dapat dilakukan antara jam 8 pagi sampai jam 5 sore.",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.white60,
      );
      return;
    }

    String status = "Di luar area jangkauan";

    // jika jarak kurang dari 200 meter maka di dalam jangkauan
    if (distance <= 200) {
      status = "Di dalam area jangkauan.";
    }

    if (now.weekday == DateTime.saturday || now.weekday == DateTime.sunday) {
      // Hari libur (Sabtu dan Minggu)
      await Get.dialog(
        AlertDialog(
          title: Text("Informasi"),
          content:
              Text("Tidak dapat melakukan presensi karena hari libur kerja."),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    if (snapPresence.docs.length == 0) {
      // belum pernah absen & set absen masuk
      await Get.defaultDialog(
        title: "Validasi Presensi",
        middleText: "Apakah kamu yakin akan absen sekarang?",
        actions: [
          OutlinedButton(
            onPressed: () => Get.back(),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              await colPresence.doc(todayDocID).set({
                "date": now.toIso8601String(),
                "masuk": {
                  "date": now.toIso8601String(),
                  "lat": position.latitude,
                  "long": position.longitude,
                  "address": address,
                  "status": status,
                  "distance": distance,
                }
              });
              Get.back();
              Get.snackbar("Berhasil", "Kamu berhasil absen masuk.",
                  duration: Duration(seconds: 3),
                  backgroundColor: Colors.white60);
            },
            child: Text("OK"),
          ),
        ],
      );
    } else {
      // sudah pernah melakukan absensi -> melakukan cek absensi
      DocumentSnapshot<Map<String, dynamic>> todayDoc =
          await colPresence.doc(todayDocID).get();

      if (todayDoc.exists == true) {
        // tinggal absen keluar / masuk
        Map<String, dynamic>? dataPresenceToday = todayDoc.data();
        if (dataPresenceToday?["keluar"] != null) {
          // sudah masuk dan keluar
          Get.snackbar("Informasi",
              "Kamu telah absen masuk & keluar, Tidak dapat mengubah data kembali.",
              duration: Duration(seconds: 3), backgroundColor: Colors.white60);
        } else {
          // absen keluar
          await Get.defaultDialog(
            title: "Validasi Presensi",
            middleText: "Apakah kamu yakin akan keluar sekarang?",
            actions: [
              OutlinedButton(
                onPressed: () => Get.back(),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await colPresence.doc(todayDocID).update({
                    "keluar": {
                      "date": now.toIso8601String(),
                      "lat": position.latitude,
                      "long": position.longitude,
                      "address": address,
                      "status": status,
                      "distance": distance,
                    }
                  });
                  Get.back();
                  Get.snackbar("Berhasil", "Kamu berhasil absen keluar.",
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.white60);
                },
                child: Text("OK"),
              ),
            ],
          );
        }
      } else {
        await Get.defaultDialog(
          title: "Validasi Presensi",
          middleText: "Apakah kamu yakin akan absen sekarang?",
          actions: [
            OutlinedButton(
              onPressed: () => Get.back(),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await colPresence.doc(todayDocID).set({
                  "date": now.toIso8601String(),
                  "masuk": {
                    "date": now.toIso8601String(),
                    "lat": position.latitude,
                    "long": position.longitude,
                    "address": address,
                    "status": status,
                    "distance": distance,
                  }
                });
                Get.back();
                Get.snackbar("Berhasil", "Kamu berhasil absen masuk.",
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.white60);
              },
              child: Text("OK"),
            ),
          ],
        );
        //  absen masuk
      }
    }
  }

  // melakukan presensi tanpe melakukan pengecekan hari libur
  // Future<void> presensi(
  //     Position position, String address, double distance) async {
  //   String uid = await auth.currentUser!.uid;
  //
  //   CollectionReference<Map<String, dynamic>> colPresence =
  //       await firestore.collection("pegawai").doc(uid).collection("presence");
  //   QuerySnapshot<Map<String, dynamic>> snapPresence = await colPresence.get();
  //   DateTime now = DateTime.now();
  //   String todayDocID = DateFormat.yMd().format(now).replaceAll("/", "-");
  //
  //   String status = "Di luar area jangkauan";
  //
  //   // jika jarak kurang dari 200 meter maka di dalam jangkauan
  //   if (distance <= 200) {
  //     status = "Di dalam area jangkauan.";
  //   }
  //
  //
  //   if (snapPresence.docs.length == 0) {
  //     //  belum pernah absen & set absen masuk
  //     await Get.defaultDialog(
  //         title: "Validasi Presensi",
  //         middleText: "Apakah kamu yakin akan absen sekarang?",
  //         actions: [
  //           OutlinedButton(
  //             onPressed: () => Get.back(),
  //             child: Text("Cancel"),
  //           ),
  //           ElevatedButton(
  //               onPressed: () async {
  //                 await colPresence.doc(todayDocID).set({
  //                   "date": now.toIso8601String(),
  //                   "masuk": {
  //                     "date": now.toIso8601String(),
  //                     "lat": position.latitude,
  //                     "long": position.longitude,
  //                     "address": address,
  //                     "status": status,
  //                     "distance": distance,
  //                   }
  //                 });
  //                 Get.back();
  //                 Get.snackbar("Berhasil", "Kamu berhasil absen masuk.", duration: Duration(seconds: 3), backgroundColor: Colors.white60);
  //               },
  //               child: Text("OK"))
  //         ]);
  //   } else {
  //     // sudah pernah melakukan absensi -> melakukan cek absensi
  //     DocumentSnapshot<Map<String, dynamic>> todayDoc =
  //         await colPresence.doc(todayDocID).get();
  //
  //     if (todayDoc.exists == true) {
  //       //  tinggal absen keluar / masuk
  //       Map<String, dynamic>? dataPresenceToday = todayDoc.data();
  //       if (dataPresenceToday?["keluar"] != null) {
  //         // sudah masuk dan keluar
  //         Get.snackbar("Informasi",
  //             "Kamu telah absen masuk & keluar, Tidak dapat mengubah data kembali.", duration: Duration(seconds: 3), backgroundColor: Colors.white60);
  //       } else {
  //         //  absen keluar
  //         await Get.defaultDialog(
  //             title: "Validasi Presensi",
  //             middleText: "Apakah kamu yakin akan keluar sekarang?",
  //             actions: [
  //               OutlinedButton(
  //                 onPressed: () => Get.back(),
  //                 child: Text("Cancel"),
  //               ),
  //               ElevatedButton(
  //                   onPressed: () async {
  //                     await colPresence.doc(todayDocID).update({
  //                       "keluar": {
  //                         "date": now.toIso8601String(),
  //                         "lat": position.latitude,
  //                         "long": position.longitude,
  //                         "address": address,
  //                         "status": status,
  //                         "distance": distance,
  //                       }
  //                     });
  //                     Get.back();
  //                     Get.snackbar("Berhasil", "Kamu berhasil absen keluar.",duration: Duration(seconds: 3), backgroundColor: Colors.white60);
  //                   },
  //                   child: Text("OK"))
  //             ]);
  //       }
  //     } else {
  //       await Get.defaultDialog(
  //           title: "Validasi Presensi",
  //           middleText: "Apakah kamu yakin akan absen sekarang?",
  //           actions: [
  //             OutlinedButton(
  //               onPressed: () => Get.back(),
  //               child: Text("Cancel"),
  //             ),
  //             ElevatedButton(
  //                 onPressed: () async {
  //                   await colPresence.doc(todayDocID).set(
  //                     {
  //                       "date": now.toIso8601String(),
  //                       "masuk": {
  //                         "date": now.toIso8601String(),
  //                         "lat": position.latitude,
  //                         "long": position.longitude,
  //                         "address": address,
  //                         "status": status,
  //                         "distance": distance,
  //                       }
  //                     },
  //                   );
  //                   Get.back();
  //                   Get.snackbar("Berhasil", "Kamu berhasil absen masuk.", duration: Duration(seconds: 3), backgroundColor: Colors.white60);
  //                 },
  //                 child: Text("OK"))
  //           ]);
  //       //  absen masuk
  //     }
  //   }
  // }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return ({
        "message": "Tidak dapat mengambil GPS device.",
        "error": true,
      });
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return ({
          "message": "Izin menggunakan GPS ditolak.",
          "error": true,
        });
      }
    }

    // akses lokasi ditolak
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return ({
        "message": "Error, Aktifkan GPS.",
        "error": true,
      });
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    return {
      "position": position,
      "message": "Berhasil mendapatkan posisi device",
      "error": false,
    };
  }
}
