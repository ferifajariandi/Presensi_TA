import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/modules/login/views/login_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../routes/app_pages.dart';
import '../controllers/all_presensi_controller.dart';

class AllPresensiView extends GetView<AllPresensiController> {
  const AllPresensiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Semua Presensi'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: ColorConstants.background,
        ),
        body: GetBuilder<AllPresensiController>(
          builder: (c) => FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: controller.getPresence(),
              builder: (context, snap) {
                if(snap.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snap.data?.docs.length == 0 || snap == null) {
                  return const SizedBox(
                    height: 150,
                    child: Center(
                      child: Text("Belum ada history presensi"),
                    ),
                  );
                }
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  itemCount: snap.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = snap.data!.docs[index].data();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200],
                        elevation: 2,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () =>
                              Get.toNamed(Routes.DETAIL_PRESENSI, arguments: data),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Masuk",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${DateFormat.yMMMEd('id_ID').format(DateTime.parse(data['date']))}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  data['masuk']?['date'] == null
                                      ? '-'
                                      : '${DateFormat.jms('id_ID').format(DateTime.parse(data['masuk']!['date']).toLocal())} WIB',
                                ),
                                // Text(
                                //     data['masuk']?['date'] == null
                                //     ? "-"
                                //     : "${DateFormat.jms().format(DateTime.parse(data['masuk']!['date']))}"),
                                const SizedBox(height: 10),
                                const Text(
                                  "Keluar",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  data['keluar']?['date'] == null
                                      ? '-'
                                      : '${DateFormat.jms('id_ID').format(DateTime.parse(data['keluar']!['date']).toLocal())} WIB',
                                ),

                                // Text(data['keluar']?['date'] == null
                                //     ? "-"
                                //     : "${DateFormat.jms().format(DateTime.parse(data['keluar']!['date']))}"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
          ),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.buttonLogout,
        onPressed: (){
        //  syncfunction datepicker
          Get.dialog(
            Dialog(
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 400,
                child: SfDateRangePicker(
                  monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                  selectionMode: DateRangePickerSelectionMode.range,
                  showActionButtons: true,
                  startRangeSelectionColor: ColorConstants.buttonLogout,
                  endRangeSelectionColor: ColorConstants.buttonLogout,
                  rangeSelectionColor: ColorConstants.background,
                  todayHighlightColor: ColorConstants.buttonLogout,
                  onCancel: ()=> Get.back(),
                  onSubmit: (obj){
                    print(obj);
                    if(obj != null){
                    //  jika tanggal null
                      if((obj as PickerDateRange).endDate != null){
                        controller.pickDate(obj.startDate!, obj.endDate!);
                      }
                    }
                  },
                ),
              ),
            )
          );

        },
        child: const Icon(Icons.date_range_outlined),
      ),
            );
  }
}
