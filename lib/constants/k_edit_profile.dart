import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:hydrow/backend/schema/users_record.dart';
import 'package:hydrow/edit_profile/edit_profile_model.dart';
import 'package:hydrow/auth/auth_util.dart';
import 'package:google_fonts/google_fonts.dart' as GF;

Widget udBtn(void Function()? onPressFunction, String btnText) {
  return ElevatedButton(
    onPressed: onPressFunction,
    child: Text(
      btnText,
      style: GF.GoogleFonts.leagueSpartan(
        fontSize: 18,
        color: Color(0xFF0C0C0C),
        fontWeight: FontWeight.w600,
      ),
    ),
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
        ),
        backgroundColor: Color(0xFFC6DDDB),
        padding: EdgeInsetsDirectional.fromSTEB(20, 17, 20, 17)),
  );
}
