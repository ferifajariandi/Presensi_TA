import 'package:flutter/material.dart';

import '../../login/views/login_view.dart';

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize: Size(327, 50),
  primary: ColorConstants.buttonLogout,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
);

final ButtonStyle buttonReminder = ElevatedButton.styleFrom(
  primary: ColorConstants.buttonLogout,
  minimumSize: Size(200,30),
  shadowColor: ColorConstants.background,
  elevation: 0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
);

final ButtonStyle buttonDate = ElevatedButton.styleFrom(
  primary: ColorConstants.buttonLogout,
  minimumSize: Size(150,35),
  shadowColor: ColorConstants.background,
  elevation: 0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
);
