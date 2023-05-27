import 'package:flutter/material.dart';
import 'package:presence/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';
import '../../profile/views/buttonPrimary.dart';
import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Password'),
          centerTitle: true,
          backgroundColor: ColorConstants.background,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              obscureText: true,
              controller: controller.newPassC,
              decoration: const InputDecoration(
                labelText: "New Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: buttonPrimary,
              onPressed: () {
                controller.newPassword();
              },
              child: const Text("Kirim"),
            ),
          ],
        ));
  }
}
