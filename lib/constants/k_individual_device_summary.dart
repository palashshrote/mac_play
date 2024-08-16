import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as GF;

var liveDataStyle = GF.GoogleFonts.leagueSpartan(
  fontSize: 24,
  color: Color(0xFF91D9E9),
  fontWeight: FontWeight.w600,
);
var activeDeviceStatusStyle = GF.GoogleFonts.leagueSpartan(
  fontSize: 24,
  color: Color(0xFF91E995),
  fontWeight: FontWeight.w600,
);
var inactiveDeviceStatusStyle = GF.GoogleFonts.leagueSpartan(
  fontSize: 24,
  color: Color(0xFFFB7070),
  fontWeight: FontWeight.w600,
);
Widget cardHeading(String heading) {
  return Row(
    //container1 //row1
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        heading,
        textAlign: TextAlign.center,
        style: GF.GoogleFonts.leagueSpartan(
          fontSize: 16,
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.normal,
        ),
      ),
    ],
  );
}

Widget sbox(double? ht, double? wt) {
  return SizedBox(
    height: ht,
    width: wt,
  );
}

Widget dataCardDecoration(List<Widget> colChildren) {
  return Container(
    width: 140,
    height: 90,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Color(0xFF686868)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: colChildren,
    ),
  );
}

Widget dataCard(String data, bool isDeviceActive) {
  return Row(
    //container1 row2
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      isDeviceActive
          ? Text(
              data + 'L',
              textAlign: TextAlign.center,
              style: GF.GoogleFonts.leagueSpartan(
                fontSize: 24,
                color: Color(0xFF91D9E9),
                fontWeight: FontWeight.w600,
              ),
            )
          : CircularProgressIndicator(),
    ],
  );
}

Widget dataCardImproved(bool isDeviceActive, Future<dynamic>? futureFunction,
    bool? tellStatus, String? unit) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      isDeviceActive
          ? FutureBuilder<dynamic>(
              future: futureFunction,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print("Entered waiting state");
                  return CircularProgressIndicator(
                    color: Colors.white,
                  ); // Display a loading indicator while waiting for the result
                } else if (snapshot.hasError) {
                  print("Error in ${snapshot.error}");
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  var value = snapshot.data;
                  if (value == true) value = "Active";
                  if (value == false) value = "Inactive";
                  String ans = "";
                  if (unit == null)
                    ans = value;
                  else {
                    ans = value.toString();
                    if (ans != "N/A") ans = ans + " " + unit;
                  }
                  return Text(ans,
                      textAlign: TextAlign.center,
                      style: tellStatus == null
                          ? liveDataStyle
                          : tellStatus
                              ? activeDeviceStatusStyle
                              : inactiveDeviceStatusStyle);
                } else {
                  return Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 0.0),
                    child: Container(
                      child: Center(
                        child: Text('No data available'),
                      ),
                    ),
                  );
                }
              },
            )
          : tellStatus == null
              ? Text(
                  "N/A",
                  style: activeDeviceStatusStyle,
                )
              : Text(
                  "Inactive",
                  style: inactiveDeviceStatusStyle,
                ),
    ],
  );
}
