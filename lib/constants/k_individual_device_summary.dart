import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:hydrow/constants/k_dashboard_container.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:intl/intl.dart';

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

String calculateHeadSpace(String ans, String height) {
  return (double.parse(height) - double.parse(ans)).toString();
}

Widget dataSubCardStarr(
    bool isDeviceActive,
    Future<dynamic>? futureFunction,
    bool? tellStatus,
    String? unit,
    String? subFunction,
    List<dynamic>? subdata) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [],
  );
}

Widget dataCardImproved(
    bool isDeviceActive,
    Future<dynamic>? futureFunction,
    bool? tellStatus,
    String? unit,
    String? subFunction,
    List<dynamic>? subdata) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      isDeviceActive
          ? FutureBuilder<dynamic>(
              future: futureFunction,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // print("Entered waiting state");
                  return CircularProgressIndicator(
                    color: Colors.white,
                  ); // Display a loading indicator while waiting for the result
                } else if (snapshot.hasError) {
                  // print("Error in ${snapshot.error}");
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  if (snapshot.data == null) {
                    return NAText();
                  }
                  // print("ACtive status : ${isDeviceActive}");
                  var value = snapshot.data;
                  if (value == true) value = "Active";
                  String ans = "";
                  if (value == false) value = "Inactive";
                  if (value.toString() == "null") value = "N/A";
                  if (unit == null)
                    ans = value;
                  else {
                    ans = value.toString();
                    if (ans != "N/A") {
                      if (subFunction == "headSpace") {
                        ans = calculateHeadSpace(ans, subdata![0]);
                      }
                      if (subFunction == "availForUse") {
                        String waterLevel = ans;
                        ans = functions.shortenNumber(
                            functions.calculateWaterAvailable(
                                subdata![0],
                                subdata[1],
                                subdata[2],
                                subdata[3],
                                double.parse(waterLevel),
                                subdata[4]));
                      }
                      if (subFunction == "tankFilled") {
                        String waterLevel = ans;
                        ans = functions
                            .convertToInt(functions.tankAPI(
                                functions.calculateWaterAvailable(
                                    subdata![0],
                                    subdata[1],
                                    subdata[2],
                                    subdata[3],
                                    double.parse(waterLevel),
                                    subdata[4]),
                                subdata[5]))
                            .toString();
                      }
                    }
                    if (ans != "N/A") ans = ans + " " + unit;
                  }
                  return Text(ans,
                      textAlign: TextAlign.center,
                      style: tellStatus == null
                          ? liveDataStyle
                          : (tellStatus && value == "Active")
                              ? activeDeviceStatusStyle
                              : inactiveDeviceStatusStyle);
                } else {
                  return NAText();
                  // return Padding(
                  //   padding:
                  //       EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 0.0),
                  //   child: Container(
                  //     child: Center(
                  //       child: Text('No data available'),
                  //     ),
                  //   ),
                  // );
                }
              },
            )
          : tellStatus == null
              ? Text(
                  "N/A",
                  style: liveDataStyle,
                )
              : Text(
                  "Inactive",
                  style: inactiveDeviceStatusStyle,
                ),
    ],
  );
}

Widget dataContainer(String heading, String data, [double? c_width]) {
  return Container(
    width: c_width == null ? 140 : c_width,
    height: 90,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Color(0xFF686868)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
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
        ),
        sbox(9, null),
        Text(
          data,
          style: data == "Active"
              ? activeDeviceStatusStyle
              : data == "Inactive"
                  ? inactiveDeviceStatusStyle
                  : liveDataStyle,
        ),
      ],
    ),
  );
}

Widget dataContainerUpdatedAt(String heading, DateTime data,
    [double? c_width]) {
  String formattedDate = DateFormat('dd-MM-yyyy').format(data);
  String formattedTime = DateFormat('hh:mm a').format(data);

  return Container(
    width: c_width == null ? 190 : c_width,
    height: 130,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Color(0xFF686868)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
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
        ),
        sbox(9, null),
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Date: ",
                  style: liveDataStyle,
                ),
                Text(
                  formattedDate,
                  style: data == "Active"
                      ? activeDeviceStatusStyle
                      : data == "Inactive"
                          ? inactiveDeviceStatusStyle
                          : liveDataStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Time: ",
                  style: liveDataStyle,
                ),
                Text(
                  formattedTime,
                  style: data == "Active"
                      ? activeDeviceStatusStyle
                      : data == "Inactive"
                          ? inactiveDeviceStatusStyle
                          : liveDataStyle,
                ),
              ],
            ),
          ],
        )
      ],
    ),
  );
}
