import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:flutter/src/cupertino/icons.dart';

var notSelectedStyle = GF.GoogleFonts.leagueSpartan(
  height: 1.5,
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

var defaultDeviceNADataStyle = GF.GoogleFonts.leagueSpartan(
  fontSize: 24,
  color: Color(0xFF91D9E9),
  fontWeight: FontWeight.w600,
);

var defaultDeviceNameStyle = GF.GoogleFonts.leagueSpartan(
  fontSize: 30,
  color: Color(0xFFFFFFFF),
  fontWeight: FontWeight.w600,
);

var defaultDeviceDataStyle = GF.GoogleFonts.leagueSpartan(
  fontSize: 24,
  color: Color(0xFF91D9E9),
  fontWeight: FontWeight.w600,
);

var showAllDeviceButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius:
      BorderRadius.circular(7.5),
    ),
    backgroundColor: Color(0xFFC6DDDB),
    padding:
    EdgeInsetsDirectional.fromSTEB(
        20, 17, 20, 17));



Widget defaultDeviceName(String str) {
  return Text(
    str,
    style: defaultDeviceNameStyle,
    overflow: TextOverflow.ellipsis,
  );
}

Widget defaultDeviceSpecsHeading(String str) {
  return Text(
    str,
    textAlign: TextAlign.center,
    style: GF.GoogleFonts.leagueSpartan(
      fontSize: 16,
      color: Color(0xFFFFFFFF),
      fontWeight: FontWeight.normal,
    ),
  );
}
Widget showAllDevicesButton(String str, void Function()? onPressFunction) {
  return ElevatedButton(
    onPressed: onPressFunction,
    child: Text(str, style: GF.GoogleFonts.leagueSpartan(
      fontSize: 18,
      color: Color(0xFF0C0C0C),
      fontWeight: FontWeight.w600,
    )),
    style: showAllDeviceButtonStyle,
  );

}
Widget refreshButton(String str, void Function()? onPressFunction) {
  return ElevatedButton.icon(
    // <-- ElevatedButton

    // onPressed: () async {
    //   // isActiveDebore = await functions
    //   //     .checkActivity(
    //   //         FFAppState()
    //   //             .borewellKey);
    //   _model.waterLevelFromGround =
    //   await functions
    //       .getWaterLevelfromGround(
    //       containerBorewellRecord
    //           .borewellKey!);
    //   setState(() {});
    // },
    onPressed: onPressFunction,

    // onPressed: () {},
    icon: Icon(
      CupertinoIcons
          .arrow_2_squarepath,
      size: 16.0,
      color:
      Color(0xFF0C0C0C),
    ),
    label: Text(
      'Refresh',
      style: GF.GoogleFonts
          .leagueSpartan(
        fontSize: 16,
        color:
        Color(0xFF0C0C0C),
        fontWeight:
        FontWeight.w500,
      ),
    ),
    style: ElevatedButton
        .styleFrom(
      shape:
      RoundedRectangleBorder(
        borderRadius:
        BorderRadius
            .circular(
            7.5),
      ),
      backgroundColor:
      Color(0xFFC6DDDB),
    ),
  );

}
