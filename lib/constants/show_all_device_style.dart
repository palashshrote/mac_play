import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as GF;


Widget viewMoreBtn(String str,void Function()? onPressBtn) {
  return ElevatedButton(
    onPressed: onPressBtn,
    child: Text(
      str,
      style:
      GF.GoogleFonts.leagueSpartan(
        fontSize: 18,
        color: Color(0xFF0C0C0C),
        fontWeight: FontWeight.w600,
      ),
    ),
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
              7.5),
        ),
        backgroundColor:
        Color(0xFFC6DDDB),
        padding: EdgeInsetsDirectional
            .fromSTEB(
            15, 7.5, 15, 7.5)),
  );
}