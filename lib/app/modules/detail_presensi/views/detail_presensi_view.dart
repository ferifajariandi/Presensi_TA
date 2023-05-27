import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/modules/login/views/login_view.dart';

import '../controllers/detail_presensi_controller.dart';

class DetailPresensiView extends GetView<DetailPresensiController> {
  final Map<String, dynamic> data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Presensi'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: ColorConstants.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0.1,
                      blurRadius: 1,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "${DateFormat.yMMMMEEEEd('id_ID').format(DateTime.parse(data['date']))}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Masuk",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const SizedBox(width: 0),
                          // Menambahkan jarak horizontal antara teks dan isi
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "Jam :",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "${DateFormat.jms('id_ID').format(DateTime.parse(data['masuk']!['date']).toLocal())} WIB",
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Menambahkan jarak vertikal antara baris
                      Row(
                        children: [
                          const Text(
                            "Posisi :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${data['masuk']!['lat']}, ${data['masuk']!['long']}",
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            "Status :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${data['masuk']!['status']}",
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            "Jarak Lokasi :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${data['masuk']!['distance'].toString().split(".").first} meter",
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Keluar",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const SizedBox(width: 0),
                              // Menambahkan jarak horizontal antara teks dan isi
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  "Jam :",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "${DateFormat.jms('id_ID').format(DateTime.parse(data['keluar']!['date']).toLocal())} WIB",
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Menambahkan jarak vertikal antara baris
                          Row(
                            children: [
                              const Text(
                                "Posisi :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "${data['keluar']!['lat']}, ${data['keluar']!['long']}",
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text(
                                "Status :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "${data['keluar']!['status']}",
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text(
                                "Jarak Lokasi :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "${data['keluar']!['distance'].toString().split(".").first} meter",
                              ),
                            ],
                          ),
                          //     const Text(
                          //       "Keluar",
                          //       style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     Text(
                          //       "Jam : ${DateFormat.jms('id_ID').format(DateTime.parse(data['keluar']!['date']).toLocal())} WIB",
                          //     ),
                          //     Text(
                          //       data['keluar']?['lat'] == null &&
                          //               data['keluar']?['long'] == null
                          //           ? "Posisi : -"
                          //           : "Posisi : ${data['keluar']!['lat']}, ${data['keluar']!['long']}",
                          //     ),
                          //     Text(
                          //       data['keluar']?['status'] == null
                          //           ? "Status : -"
                          //           : "Status : ${data['keluar']!['status']}",
                          //     ),
                          //     Text(
                          //       data['keluar']?['distance'] == null
                          //           ? "Jarak Lokasi : -"
                          //           : "Jarak Lokasi : ${data['keluar']!['distance'].toString().split(".").first} meter",
                          //     ),
                          //     Text(
                          //       data['keluar']?['address'] == null
                          //           ? "Alamat : -"
                          //           : "Alamat : ${data['keluar']!['address']}",
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
