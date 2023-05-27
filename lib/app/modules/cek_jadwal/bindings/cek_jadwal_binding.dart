import 'package:get/get.dart';

import '../controllers/cek_jadwal_controller.dart';

class CekJadwalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CekJadwalController>(
      () => CekJadwalController(),
    );
  }
}
