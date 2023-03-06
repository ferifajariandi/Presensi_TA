import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence/app/modules/login/views/login_view.dart';
import 'package:presence/app/modules/profile/views/buttonPrimary.dart';
import '../../../controllers/page_index_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final pageC = Get.find<PageIndexController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.background,
          elevation: 0,
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasData) {
              Map<String, dynamic> user = snap.data!.data()!;
              String defaultImage =
                  "https://ui-avatars.com/api/?name=${user['name']}";
              return Container(
                color: ColorConstants.pembatas,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  children: [
                    Container(
                      height: Get.height * 0.4,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          greenIntroWidgetWithoutLogos(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipOval(
                              child: Container(
                                width: 100,
                                height: 100,
                                child: Image.network(
                                  user["profile"] != null
                                      ? user["profile"] != ""
                                          ? user["profile"]
                                          : defaultImage
                                      : defaultImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 35,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "${user['name'].toString().toUpperCase()}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      child: Text(
                        "${user['email']}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    //
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {
                          Get.toNamed(
                            Routes.UPDATE_PROFILE,
                            arguments: user,
                          );
                        },
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: ColorConstants.warnaButton,
                          ),
                        ),
                        // iconColor: ColorConstants.primaryColor,
                        trailing: const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            // size: 28,
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            "Informasi Pribadi",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: ColorConstants.tulisan,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(3),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Divider(
                        color: ColorConstants.pembatas,
                        height: 1,
                        thickness: 1,
                      ),
                    ),
                    if (user["role"] == "admin")
                      Container(
                        color: Colors.white,
                        child: ListTile(
                          onTap: () {
                            Get.toNamed(Routes.ADD_PEGAWAI);
                          },
                          leading: Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.person_add,
                              size: 30,
                              color: ColorConstants.warnaButton,
                            ),
                          ),
                          // iconColor: ColorConstants.primaryColor,
                          trailing: const Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              // size: 28,
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              "Add Pegawai",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                color: ColorConstants.tulisan,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(3),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Divider(
                        color: ColorConstants.pembatas,
                        height: 1,
                        thickness: 1,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {
                          Get.toNamed(Routes.UPDATE_PASSWORD);
                        },
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Icon(
                            Icons.vpn_key,
                            color: ColorConstants.warnaButton,
                            size: 30,
                          ),
                        ),
                        // iconColor: ColorConstants.primaryColor,
                        trailing: const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            // size: 28,
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            "Update Password",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: ColorConstants.tulisan,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Divider(
                        color: ColorConstants.pembatas,
                        height: 1,
                        thickness: 1,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {
                          Get.toNamed(Routes.UPDATE_PASSWORD);
                        },
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Icon(
                            Icons.date_range,
                            color: ColorConstants.warnaButton,
                            size: 30,
                          ),
                        ),
                        // iconColor: ColorConstants.primaryColor,
                        trailing: const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            // size: 28,
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            "Cek Jadwal Presensi",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: ColorConstants.tulisan,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(3),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {},
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Icon(
                            Icons.post_add_outlined,
                            color: ColorConstants.warnaButton,
                            size: 30,
                          ),
                        ),
                        // iconColor: ColorConstants.primaryColor,
                        trailing: const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            // size: 28,
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            "Permohonan Izin",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: ColorConstants.tulisan,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Divider(
                        color: ColorConstants.pembatas,
                        height: 1,
                        thickness: 1,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {},
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Icon(
                            Icons.help,
                            color: ColorConstants.warnaButton,
                            size: 30,
                          ),
                        ),

                        // iconColor: ColorConstants.primaryColor,
                        trailing: const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            // size: 28,
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            "Help & Support",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: ColorConstants.tulisan,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(3),
                      ),
                    ),
                    Container(
                      color: ColorConstants.pembatas,
                      child: const SizedBox(
                        height: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 15, right: 15, bottom: 8),
                      child: ElevatedButton(
                          style: buttonPrimary,
                          onPressed: () {
                            controller.logout();
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 45),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Version 3.0.0",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("Tidak dapat memuat data."),
              );
            }
          },
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.fixedCircle,
          backgroundColor: ColorConstants.background,
          items: const [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.fingerprint, title: 'Add'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: pageC.pageIndex.value,
          onTap: (int i) => pageC.changePage(i),
        ));
  }
}

Widget greenIntroWidgetWithoutLogos() {
  return Container(
    width: Get.width,
    decoration: const BoxDecoration(
        image: DecorationImage(
      image: AssetImage("assets/images/masking.png"),
      fit: BoxFit.fill,
    )),
    height: Get.height * 0.35,
    child: Container(
      height: Get.height * 0.1,
      width: Get.width,
      margin: EdgeInsets.only(bottom: Get.height * 0.05),
      child: const Center(
        child: Text(
          "Account Profile",
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
