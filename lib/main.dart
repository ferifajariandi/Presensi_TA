import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';


import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  await initializeDateFormatting("id_ID", null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  final pageC = Get.put(PageIndexController(), permanent: true);

  runApp(
    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return GetMaterialApp(
          title: "Application",
          initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
          // snapshot.data != null ? Routes.HOME : Routes.LOGIN
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
        );
      }
    ),
  );
}
