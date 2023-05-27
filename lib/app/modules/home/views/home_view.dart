import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/modules/login/views/login_view.dart';
import '../../../controllers/page_index_controller.dart';
import '../../../routes/app_pages.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  final double _borderRadius = 24;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting(); // Inisialisasi paket intl untuk pengaturan bahasa dan format tanggal

    // Variabel data waktu
    DateTime currentDateTime =
        DateTime.now(); // Contoh data waktu yang ingin diformat

    // Mengubah zona waktu menjadi WIB (Waktu Indonesia Barat)
    DateTime wibDateTime = currentDateTime.toLocal();

    // Format jam dengan WIB
    String formattedTime = DateFormat.jm('id_ID').format(wibDateTime);

    // Menambahkan tulisan "WIB"
    String formattedTimeWithWIB = '$formattedTime WIB';

    final pageC = Get.find<PageIndexController>();
    late TabController tabController;

    return DefaultTabController(
      length: 3,
      initialIndex: pageC.pageIndex.value,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: RichText(
            text: const TextSpan(
                text: "Hi, ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                children: [TextSpan(text: "WERMES BPRWM")]),
          ),
          backgroundColor: ColorConstants.background,
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                Map<String, dynamic> user = snapshot.data!.data()!;
                String defaultImage =
                    "https://ui-avatars.com/api/?name=${user['name']}";
                return Stack(
                  children: [
                    ClipPath(
                      clipper: ClipPathClass(),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3.5,
                        width: Get.width,
                        color: ColorConstants.background,
                      ),
                    ),

                    // Reset ui semula poin sini

                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: 100,
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: Container(
                                          width: 75,
                                          height: 75,
                                          color: Colors.grey[200],
                                          child: Image.network(
                                            user["profile"] != null
                                                ? user["profile"]
                                                : defaultImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25, left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Selamat Datang",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                user["address"] != null
                                                    ? "${user['address']}"
                                                    : "Belum ada lokasi.",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  width: Get.width / 1.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        const BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.grey,
                                        )
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${user["job"]}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "${user["nip"]}",
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${user["name"]}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: Get.width / 1.1,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  const BoxShadow(
                                    blurRadius: 2,
                                    color: Colors.grey,
                                  )
                                ]),
                            child: StreamBuilder<
                                    DocumentSnapshot<Map<String, dynamic>>>(
                                stream: controller.streamTodayPresence(),
                                builder: (context, snapToday) {
                                  if (snapToday.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  Map<String, dynamic>? dataToday =
                                      snapToday.data?.data();
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            child: Image.asset(
                                                'assets/images/login.png',
                                                width: 55),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Check In",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            dataToday?['masuk']?['date'] == null
                                                ? '-'
                                                : '$formattedTime WIB',
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.timer_outlined,
                                                color: Colors.blue,
                                                size: 15,
                                              ),
                                              Text(
                                                " 08.00 WIB",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 50,
                                          width: 2,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            child: Image.asset(
                                                'assets/images/logout.png',
                                                width: 55),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Check Out",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            dataToday?['keluar']?['date'] ==
                                                    null
                                                ? '-'
                                                : '$formattedTime WIB',
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.timer_outlined,
                                                color: Colors.orange,
                                                size: 15,
                                              ),
                                              Text(
                                                " 17.00 WIB",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 7,
                            color: Colors.grey[200],
                          ),
                          Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Terakhir 5 hari",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Get.toNamed(Routes.ALL_PRESENSI);
                                          },
                                          child: Text(
                                            "Lihat lebih",
                                            style: TextStyle(
                                              color:
                                                  ColorConstants.buttonLogout,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                StreamBuilder<
                                    QuerySnapshot<Map<String, dynamic>>>(
                                  stream: controller.streamLastPresence(),
                                  builder: (context, snapPresence) {
                                    if (snapPresence.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    // print(snapPresence.data?.docs);
                                    if (snapPresence.data?.docs.length == 0 ||
                                        snapPresence == null) {
                                      return const SizedBox(
                                        height: 150,
                                        child: Center(
                                          child: Text(
                                              "Belum ada history presensi"),
                                        ),
                                      );
                                    }
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: snapPresence.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        Map<String, dynamic> data = snapPresence
                                            .data!.docs.reversed
                                            .toList()[index]
                                            .data();
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20, left: 20, right: 20),
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                            shadowColor: Colors.grey[800],
                                            elevation: 3,
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              onTap: () => Get.toNamed(
                                                  Routes.DETAIL_PRESENSI,
                                                  arguments: data),
                                              child: Container(
                                                height: Get.height / 5.5,
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          "Masuk",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${DateFormat.yMMMEd('id_ID').format(DateTime.parse(data['date']))}",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      data['masuk']?['date'] ==
                                                              null
                                                          ? '-'
                                                          : '${DateFormat.jms('id_ID').format(DateTime.parse(data['masuk']!['date']).toLocal())} WIB',
                                                    ),

                                                    // Text(data['masuk']?['date'] ==
                                                    //     null
                                                    //     ? "-"
                                                    //     : "${DateFormat.jm(
                                                    //     'id_ID').format(
                                                    //     DateTime.parse(
                                                    //         data['masuk']!['date']))}"),
                                                    const SizedBox(height: 10),
                                                    const Text(
                                                      "Keluar",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      data['keluar']?['date'] ==
                                                              null
                                                          ? '-'
                                                          : '${DateFormat.jms('id_ID').format(DateTime.parse(data['keluar']!['date']).toLocal())} WIB',
                                                    ),

                                                    // Text(
                                                    //     data['keluar']
                                                    // ?['date'] ==
                                                    //     null
                                                    //     ? "-"
                                                    //     : "${DateFormat.jm(
                                                    //     'id_ID').format(
                                                    //     DateTime.parse(
                                                    //         data['masuk']!['date']))}"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text("Tidak dapat memuat database user"),
                );
              }
            }),
        bottomNavigationBar: Builder(
          builder: (BuildContext context) {
            tabController = DefaultTabController.of(context)!;
            return ConvexAppBar(
              backgroundColor: ColorConstants.background,
              elevation: 2,
              style: TabStyle.fixedCircle,
              items: const [
                TabItem(icon: Icons.home, title: 'Home'),
                TabItem(icon: Icons.fingerprint, title: 'Add'),
                TabItem(icon: Icons.people, title: 'Profile'),
              ],
              controller: tabController,
              onTap: (int index) {
                // Tangani pemilihan tab
                tabController.animateTo(index);
              },
            );
          },
        ),
      ),
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
