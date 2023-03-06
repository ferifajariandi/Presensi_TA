import 'package:flutter/material.dart';

import '../../login/views/login_view.dart';


final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize: Size(327, 50),
  primary: ColorConstants.buttonLogout,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
);