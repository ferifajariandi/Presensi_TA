import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  const AddPegawaiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Pegawai'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              children: [
                TextField(
                  controller: controller.nipC,
                  decoration: InputDecoration(
                    labelText: "NIP",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: controller.nameC,
                  decoration: InputDecoration(
                    labelText: "Nama",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller.jobC,
                  decoration: InputDecoration(
                    labelText: "Pekerjaan",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: controller.emailC,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Obx(
                    () => ElevatedButton(
                    onPressed: () async {
                      if(controller.isLoading.isFalse){
                       await controller.addPegawai();
                      }
                    },
                    child: Text(controller.isLoading.isFalse ?
                      "Tambah Pegawai" : "LOADING...",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ))
                ),
              ],
            ),
          ),
        ));
  }
}
