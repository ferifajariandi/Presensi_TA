import 'package:get/get.dart';

import '../controllers/permohonan_izin_controller.dart';

class PermohonanIzinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PermohonanIzinController>(
      () => PermohonanIzinController(),
    );
  }
}
