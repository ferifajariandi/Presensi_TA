import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence/app/modules/login/views/login_view.dart';
import 'package:presence/app/modules/profile/views/buttonPrimary.dart';

import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  const AddPegawaiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Pegawai'),
          centerTitle: true,
          backgroundColor: ColorConstants.background,
          elevation: 0,
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
                  child: Text("Silahkan tambahkan data pegawai, Hanya admin yang dapat menambah user.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextField(
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
                    )
                  ),
                ),
                const SizedBox(height: 20,),
                TextField(
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
                      )
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
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
                      )
                  ),
                ),
                const SizedBox(height: 20,),
                TextField(
                  controller: controller.emailC,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstants.buttonLogout,
                      ),
                    ),
                    labelText: "Email",
                      labelStyle: TextStyle(
                        color: ColorConstants.buttonLogout,
                        fontSize: 16,
                      )
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(
                    () => ElevatedButton(
                      style: buttonPrimary,
                    onPressed: () async {
                      if(controller.isLoading.isFalse){
                       await controller.addPegawai();
                      }
                    },
                    child: Text(
                      controller.isLoading.isFalse
                          ? "Add Pegawai"
                          : "LOADING...",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ))
                ),
              ],
            ),
          ),
        ),
    );
  }
}
