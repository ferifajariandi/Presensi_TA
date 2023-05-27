import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/login/views/login_view.dart';
import '../controllers/help_support_controller.dart';

class HelpSupportView extends GetView<HelpSupportController> {
  const HelpSupportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Aplikasi '),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorConstants.background,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              color: Colors.redAccent,
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/logo.png', height: 200, width: 200,),
            )
          ],
        ),
      )
    );
  }
}
