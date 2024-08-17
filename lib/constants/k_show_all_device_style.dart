import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:hydrow/backend/schema/borewell_record.dart';
import 'package:hydrow/constants/k_individual_device_summary.dart';
import 'package:hydrow/flutter_flow/custom_functions.dart';
import 'package:hydrow/flutter_flow/flutter_flow_animations.dart';
import 'package:hydrow/flutter_flow/flutter_flow_util.dart';
import '../borewell_summary/borewell_summary_testing_model.dart';

var activeDeviceDecorationStyle = BoxDecoration(
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.circular(15),
  border: Border.all(color: Color(0xFF686868)),
  color: Color.fromARGB(153, 230, 246, 135),
);

var inactiveDeviceDecorationStyle = BoxDecoration(
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.circular(15),
  border: Border.all(color: Colors.redAccent),
  color: Color.fromARGB(88, 248, 73, 73),
);

Widget showAllDeviceBtnTesting(List<BorewellRecord> listViewBorewellRecordList,
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
            if (ans == "null") ans = "N/A";
            print("DAta is ${ans}");
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 0.0),
              child: Container(
                height: 100,
                decoration: isBorewellActive
                    ? activeDeviceDecorationStyle
                    : inactiveDeviceDecorationStyle,
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
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
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          /*
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 16.0),
                        //   child: Text(
                        //     ans,
                        //     style: GF.GoogleFonts.leagueSpartan(
                        //       color: Color(0xFFFFFFFF),
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.w500,
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            listViewBorewellRecord.borewellName!,
                            style: GF.GoogleFonts.leagueSpartan(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Reading',
                      style: GF.GoogleFonts.leagueSpartan(
                        fontSize: 18,
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    // Spacer(),
                    viewMoreBtn(
                      "View more",
                      () async {
                        _model.outputIsActive = await checkActivityPravah(
                            listViewBorewellRecord.borewellKey!);
                        print(listViewBorewellRecord.borewellKey!);
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
                    SizedBox(width: 20.0),*/
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
                                  print(listViewBorewellRecord.borewellKey!);
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
                        ],
                      ),
                    ]),
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

/*return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: listViewBorewellRecordList.length,
                itemBuilder: (context, listViewIndex) {
                  final listViewBorewellRecord =
                      listViewBorewellRecordList[listViewIndex];
                  
                  

                  return FutureBuilder<bool>(
                    future: checkActivityDebore(
                        listViewBorewellRecord.borewellKey!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Show a placeholder or loading indicator while the Future is resolving
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 20.0, 15.0, 0.0),
                          child: Container(
                            height: 100,
                            decoration:
                                inactiveDeviceDecorationStyle, // Use a default style
                            child: Center(
                              child:
                                  CircularProgressIndicator(), // Loading indicator
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        // Handle any errors that might occur during the Future
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 20.0, 15.0, 0.0),
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
                        bool isBorewellActive = snapshot.data!;

                        // Display the result once the Future has resolved
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 20.0, 15.0, 0.0),
                          child: Container(
                            height: 100,
                            decoration: isBorewellActive
                                ? activeDeviceDecorationStyle
                                : inactiveDeviceDecorationStyle,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    listViewBorewellRecord.borewellName!,
                                    style: GF.GoogleFonts.leagueSpartan(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                
                                Spacer(),
                                viewMoreBtn(
                                  "View more",
                                  () async {
                                    _model.outputIsActive =
                                        await checkActivityPravah(
                                            listViewBorewellRecord
                                                .borewellKey!);
                                    print(listViewBorewellRecord.borewellKey!);
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
                                    setState(() {});
                                  },
                                ),
                                SizedBox(width: 20.0),
                              ],
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation']!),
                        );
                      } else {
                        // Optional: Handle cases where snapshot has no data
                        return Center(
                          child: Text('No data available'),
                        );
                      }
                    },
                  );
                
                },
              );*/
