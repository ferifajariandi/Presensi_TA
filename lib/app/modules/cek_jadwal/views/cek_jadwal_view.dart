import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence/app/modules/login/views/login_view.dart';
import 'package:presence/app/modules/profile/views/buttonPrimary.dart';

import '../controllers/cek_jadwal_controller.dart';

class CekJadwalView extends GetView<CekJadwalController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstants.background,
        title: const Text(
          "Jadwal Presensi",
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: Material(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              shadowColor: Colors.black54,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.5,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "SENIN",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 32, right: 33, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Dijadwalkan Check In : ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.timer_outlined,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                Text(
                                  " 08.00",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.green),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Dijadwalkan Check Out : ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.timer_outlined,
                                size: 20,
                                color: Colors.orange,
                              ),
                              Text(
                                " 17.00",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.red),
                              )
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Range Area Presensi : ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 20,
                                  color: Colors.purple,
                                ),
                                Text(
                                  "25 Meter",
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.purple),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Lokasi Area Presensi : ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.apartment_rounded,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                Text(
                                  " BPRWM",
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.redAccent),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Material(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              shadowColor: Colors.grey,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.5,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "SELASA",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 32, right: 33, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Dijadwalkan Check In : ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.timer_outlined,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                Text(
                                  " 08.00",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.green),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Dijadwalkan Check Out : ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.timer_outlined,
                                size: 20,
                                color: Colors.orange,
                              ),
                              Text(
                                " 17.00",
                                style:
                                TextStyle(fontSize: 16, color: Colors.red),
                              )
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Range Area Presensi : ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 20,
                                  color: Colors.purple,
                                ),
                                Text(
                                  "25 Meter",
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.purple),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Lokasi Area Presensi : ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.apartment_rounded,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                Text(
                                  " BPRWM",
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.redAccent),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Material(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              shadowColor: Colors.grey,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.5,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "RABU",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 32, right: 33, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Dijadwalkan Check In : ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.timer_outlined,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                Text(
                                  " 08.00",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.green),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Dijadwalkan Check Out : ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.timer_outlined,
                                size: 20,
                                color: Colors.orange,
                              ),
                              Text(
                                " 17.00",
                                style:
                                TextStyle(fontSize: 16, color: Colors.red),
                              )
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Range Area Presensi : ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 20,
                                  color: Colors.purple,
                                ),
                                Text(
                                  "25 Meter",
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.purple),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Lokasi Area Presensi : ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.apartment_rounded,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                Text(
                                  " BPRWM",
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.redAccent),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              shadowColor: Colors.grey,
              color: Colors.grey[200],
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.5,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "KAMIS",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 32, right: 33, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Dijadwalkan Check In : ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.timer_outlined,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                Text(
                                  " 08.00",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.green),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Dijadwalkan Check Out : ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.timer_outlined,
                                size: 20,
                                color: Colors.orange,
                              ),
                              Text(
                                " 17.00",
                                style:
                                TextStyle(fontSize: 16, color: Colors.red),
                              )
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Range Area Presensi : ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 20,
                                  color: Colors.purple,
                                ),
                                Text(
                                  "25 Meter",
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.purple),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Lokasi Area Presensi : ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.apartment_rounded,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                Text(
                                  " BPRWM",
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.redAccent),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Material(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              shadowColor: Colors.grey,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.5,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "JUM'AT",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 32, right: 33, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Dijadwalkan Check In : ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.timer_outlined,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                Text(
                                  " 08.00",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.green),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Dijadwalkan Check Out : ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.timer_outlined,
                                size: 20,
                                color: Colors.orange,
                              ),
                              Text(
                                " 17.00",
                                style:
                                TextStyle(fontSize: 16, color: Colors.red),
                              )
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Range Area Presensi : ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 20,
                                  color: Colors.purple,
                                ),
                                Text(
                                  "25 Meter",
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.purple),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Lokasi Area Presensi : ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.apartment_rounded,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                Text(
                                  " BPRWM",
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.redAccent),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
