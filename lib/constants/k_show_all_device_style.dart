import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:hydrow/backend/backend.dart';
import 'package:hydrow/backend/schema/borewell_record.dart';
import 'package:hydrow/borewell_summary/borewell_summary_t2_model.dart';
import 'package:hydrow/constants/k_individual_device_summary.dart';
import 'package:hydrow/flutter_flow/custom_functions.dart';
import 'package:hydrow/flutter_flow/flutter_flow_animations.dart';
import 'package:hydrow/flutter_flow/flutter_flow_util.dart';
import '../borewell_summary/borewell_summary_testing_model.dart';

var activeDeviceDecorationStyle = BoxDecoration(
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.circular(15),
  border: Border.all(color: Color(0xFF686868)),
  // color: Color.fromARGB(88, 212, 249, 0),
);

var inactiveDeviceDecorationStyle = BoxDecoration(
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.circular(15),
  border: Border.all(color: Colors.redAccent),
  color: Color.fromARGB(88, 248, 73, 73),
);

Widget showDeboreCard(List<BorewellRecord> listViewBorewellRecordList,
    BorewellSummaryTestingModel _model, AnimationInfo animationsMap) {
  Future<List<dynamic>> combinedFuture(String borewellKey) {
    return Future.wait([
      checkActivityDebore(borewellKey), // bool
      getWaterLevelfromGround(borewellKey), // String (or any other data type)
    ]);
  }

  return ListView.builder(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: listViewBorewellRecordList.length,
    itemBuilder: (context, listViewIndex) {
      final listViewBorewellRecord = listViewBorewellRecordList[listViewIndex];

      return FutureBuilder<List<dynamic>>(
        future: combinedFuture(listViewBorewellRecord.borewellKey!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a placeholder or loading indicator while the Future is resolving
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 0.0),
              child: Container(
                height: 100,
                decoration:
                    inactiveDeviceDecorationStyle, // Use a default style
                child: Center(
                  child: CircularProgressIndicator(), // Loading indicator
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // Handle any errors that might occur during the Future
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 0.0),
              child: Container(
                height: 100,
                decoration:
                    inactiveDeviceDecorationStyle, // Use a default style
                child: Center(
                  child: Text(
                    'Error loading data',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasData) {
            bool isBorewellActive = snapshot.data![0];
            var ans = snapshot.data![1];
            if (ans == "null")
              ans = "N/A";
            else
              ans = ans.toString() + "m";
            // print("DAta is ${ans}");
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 0.0),
              child: Container(
                height: 160,
                decoration: isBorewellActive
                    ? activeDeviceDecorationStyle
                    : inactiveDeviceDecorationStyle,
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      ans,
                                      style: GF.GoogleFonts.leagueSpartan(
                                        color: Color(0xFFFFFFFF),
                                        // color: Color(0xFF91D9E9),
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                sbox(7, null),
                                Row(
                                  children: [
                                    Text(
                                      'Reading',
                                      style: GF.GoogleFonts.leagueSpartan(
                                        fontSize: 18,
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              listViewBorewellRecord.borewellName!,
                              style: GF.GoogleFonts.leagueSpartan(
                                color: Color(0xFFFFFFFF),
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            viewMoreBtn(
                              "View more",
                              () async {
                                _model.outputIsActive =
                                    await checkActivityPravah(
                                        listViewBorewellRecord.borewellKey!);
                                // print(listViewBorewellRecord.borewellKey!);
                                // print(listViewBorewellRecord.borewellKey!);
                                try {
                                  context.pushNamed(
                                    'TwoIndividualBorewellSummary',
                                    queryParams: {
                                      'docReference': serializeParam(
                                            listViewBorewellRecord,
                                            ParamType.Document,
                                          ) ??
                                          '',
                                      'isActive': serializeParam(
                                            _model.outputIsActive,
                                            ParamType.bool,
                                          ) ??
                                          '',
                                    },
                                    extra: <String, dynamic>{
                                      'docReference': listViewBorewellRecord,
                                    },
                                  );
                                } catch (e) {
                                  print('Navigation failed: $e');
                                }
                                // setState(() {});
                              },
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      );
    },
  );
}

Widget showDeboreCardOptimised(List<BorewellRecord> listViewBorewellRecordList,
    BorewellSummaryT2Model _model, AnimationInfo animationsMap) {
  

  return ListView.builder(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: listViewBorewellRecordList.length,
    itemBuilder: (context, listViewIndex) {
      final listViewBorewellRecord = listViewBorewellRecordList[listViewIndex];

      return FutureBuilder<Map<String, dynamic>?>(
        future: fetchBorewellDataForUser(listViewBorewellRecord.borewellKey!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Error fetching data');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text('No data available');
          }

          var borewellData = snapshot.data!;
          var waterLevel = borewellData['WaterLevelGround'];
          var ts = borewellData['Timestamp'];
          bool isBorewellActive = waterLevel == "N/A" ? false : true;
          return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 0.0),
            child: Container(
              height: 160,
              decoration: isBorewellActive
                  ? activeDeviceDecorationStyle
                  : inactiveDeviceDecorationStyle,
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    waterLevel,
                                    style: GF.GoogleFonts.leagueSpartan(
                                      color: Color(0xFFFFFFFF),
                                      // color: Color(0xFF91D9E9),
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              sbox(7, null),
                              Row(
                                children: [
                                  Text(
                                    'Reading',
                                    style: GF.GoogleFonts.leagueSpartan(
                                      fontSize: 18,
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            listViewBorewellRecord.borewellName!,
                            style: GF.GoogleFonts.leagueSpartan(
                              color: Color(0xFFFFFFFF),
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          viewMoreBtn("View more", () async {
                            try {
                              context.pushNamed(
                                'T2IndividualBorewellSummary',
                                queryParams: {
                                  'docReference': serializeParam(
                                        listViewBorewellRecord,
                                        ParamType.Document,
                                      ) ??
                                      '',
                                  'isActive': serializeParam(
                                        isBorewellActive,
                                        ParamType.bool,
                                      ) ??
                                      '',
                                },
                                extra: <String, dynamic>{
                                  'docReference': listViewBorewellRecord,
                                },
                              );
                            } catch (e) {
                              print('Navigation failed: $e');
                            }
                          }),
                        ],
                      ),
                    ]),
              ),
            ),
          );

          // return Text(
          //   'Water Level: $waterLevel',
          //   style: liveDataStyle,
          // );
        },
      );
    },
  );
}

Widget viewMoreBtn(String str, void Function()? onPressBtn) {
  return ElevatedButton(
    onPressed: onPressBtn,
    child: Text(
      str,
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
        padding: EdgeInsetsDirectional.fromSTEB(15, 7.5, 15, 7.5)),
  );
}
