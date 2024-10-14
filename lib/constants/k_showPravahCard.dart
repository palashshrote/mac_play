import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:hydrow/backend/backend.dart';
import 'package:hydrow/constants/k_individual_device_summary.dart';
import 'package:hydrow/constants/k_show_all_device_style.dart';
import 'package:hydrow/flutter_flow/custom_functions.dart';
import 'package:hydrow/flutter_flow/flutter_flow_animations.dart';
import 'package:hydrow/flutter_flow/flutter_flow_util.dart';
import 'package:hydrow/meter_summary/meter_summary_t2_model.dart';
import 'package:hydrow/meter_summary/meter_summary_testing_model.dart';
import 'package:hydrow/tank_summary/tank_summary_t2_model.dart';
import 'package:hydrow/tank_summary/tank_summary_testing_model.dart';
import '../borewell_summary/borewell_summary_testing_model.dart';
import 'package:hydrow/flutter_flow/custom_functions.dart' as functions;

/*Widget showStarrCard(List<TankRecord> listViewTankRecordList,
    TankSummaryTestingModel _model, AnimationInfo animationsMap) {
  Future<List<dynamic>> combinedFuture(String tankKey) {
    return Future.wait([
      checkActivityPravah(tankKey), // bool
      getTemp(tankKey),
      getStarrWaterLevel(tankKey), // String (or any other data type)
    ]);
  }

  return ListView.builder(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: listViewMeterRecordList.length,
    itemBuilder: (context, listViewIndex) {
      final listViewMeterRecord = listViewMeterRecordList[listViewIndex];

      return FutureBuilder<List<dynamic>>(
        future: combinedFuture(listViewMeterRecord.meterKey!),
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
            print("Item count: ${listViewMeterRecordList.length}");
            print(snapshot.data);
            bool isMeterActive = snapshot.data![0];
            var ansFlowRate = snapshot.data![2];
            var ansReading = snapshot.data![1];
            if (ansReading == "null") ansReading = "N/A";
            if (ansFlowRate == "null") ansFlowRate = "N/A";
            print("DAta is ${ansReading}");
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 0.0),
              child: Container(
                height: 160,
                decoration: isMeterActive
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
                                      ansReading,
                                      style: GF.GoogleFonts.leagueSpartan(
                                        color: Color(0xFFFFFFFF),
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
                              listViewMeterRecord.meterName!,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      ansFlowRate,
                                      style: GF.GoogleFonts.leagueSpartan(
                                        color: Color(0xFFFFFFFF),
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
                                      'Flow Rate',
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
                            viewMoreBtn(
                              "View more",
                              () async {
                                _model.outputIsActive =
                                    await checkActivityPravah(
                                        listViewMeterRecord.meterKey!);
                                print(listViewMeterRecord.meterKey!);
                                // print(listViewMeterRecord.borewellKey!);
                                try {
                                  context.pushNamed(
                                    'TwoIndividualMeterSummary',
                                    queryParams: {
                                      'docReference': serializeParam(
                                            listViewMeterRecord,
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
                                      'docReference': listViewMeterRecord,
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

*/
Widget showPravahCard(List<MeterRecord> listViewMeterRecordList,
    MeterSummaryTestingModel _model, AnimationInfo animationsMap) {
  Future<List<dynamic>> combinedFuture(String meterKey) {
    return Future.wait([
      checkActivityPravah(meterKey), // bool
      getReadingStr(meterKey),
      getFlowRateStr(meterKey), // String (or any other data type)
    ]);
  }

  return ListView.builder(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: listViewMeterRecordList.length,
    itemBuilder: (context, listViewIndex) {
      final listViewMeterRecord = listViewMeterRecordList[listViewIndex];

      return FutureBuilder<List<dynamic>>(
        future: combinedFuture(listViewMeterRecord.meterKey!),
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
            print("Item count: ${listViewMeterRecordList.length}");
            print(snapshot.data);
            bool isMeterActive = snapshot.data![0];
            var ansFlowRate = snapshot.data![2];
            var ansReading = snapshot.data![1];
            if (ansReading == "null") {
              ansReading = "N/A";
            } else {
              if (double.parse(ansReading) > 1000) {
                ansReading = shortenNumber(double.parse(ansReading)).toString();
              }
              ansReading += " L";
            }
            if (ansFlowRate == "null")
              ansFlowRate = "N/A";
            else {
              ansFlowRate += " ml/s";
            }

            print("DAta is ${ansReading} , Type: ${ansReading.runtimeType}");
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 0.0),
              child: Container(
                height: 180,
                decoration: isMeterActive
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
                                      ansReading,
                                      style: GF.GoogleFonts.leagueSpartan(
                                        color: Color(0xFFFFFFFF),
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
                              listViewMeterRecord.meterName!,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      ansFlowRate,
                                      style: GF.GoogleFonts.leagueSpartan(
                                        color: Color(0xFFFFFFFF),
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
                                      'Flow Rate',
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
                            viewMoreBtn(
                              "View more",
                              () async {
                                _model.outputIsActive =
                                    await checkActivityPravah(
                                        listViewMeterRecord.meterKey!);
                                print(listViewMeterRecord.meterKey!);
                                // print(listViewMeterRecord.borewellKey!);
                                try {
                                  context.pushNamed(
                                    'TwoIndividualMeterSummary',
                                    queryParams: {
                                      'docReference': serializeParam(
                                            listViewMeterRecord,
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
                                      'docReference': listViewMeterRecord,
                                    },
                                  );
                                } catch (e) {
                                  // print('Navigation failed: $e');
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

Widget showPravahCardOptimised(List<MeterRecord> listViewMeterRecordList,
    MeterSummaryT2Model _model, AnimationInfo animationsMap) {
  return ListView.builder(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: listViewMeterRecordList.length,
    itemBuilder: (context, listViewIndex) {
      final listViewMeterRecord = listViewMeterRecordList[listViewIndex];

      return FutureBuilder<Map<String, dynamic>?>(
        future: fetchMeterDataForUser(listViewMeterRecord.meterKey!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Error fetching data');
          } else if (!snapshot.hasData || snapshot.data == null) {
            // return const Text('No data available');
            return NADeviceCardWidget(listViewMeterRecord.meterName!);
          }

          var meterData = snapshot.data!;
          var reading = meterData['Reading'];

          String unit = "";

          if (reading != "N/A") {
            reading = functions.shortenNumber(double.parse(reading));

            List<String> parts = reading.split(' ');
            // "2.13"
            reading = parts[0];
            unit = parts[1] + "L"; // "kL"
          }

          var flowRate = meterData['FlowRate'];
          var flowRateUnit = flowRate != "N/A" ? " kL/h" : "";

          bool isMeterActive = reading == "N/A" ? false : true;
          return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 0.0),
            child: Container(
              height: 180,
              decoration: isMeterActive
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
                                    reading + " " + unit,
                                    style: GF.GoogleFonts.leagueSpartan(
                                      color: Color(0xFFFFFFFF),
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
                            listViewMeterRecord.meterName!,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    flowRate + flowRateUnit,
                                    style: GF.GoogleFonts.leagueSpartan(
                                      color: Color(0xFFFFFFFF),
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
                                    'Flow Rate',
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
                          viewMoreBtn(
                            "View more",
                            () async {
                              try {
                                context.pushNamed(
                                  'T2IndividualMeterSummary',
                                  queryParams: {
                                    'docReference': serializeParam(
                                          listViewMeterRecord,
                                          ParamType.Document,
                                        ) ??
                                        '',
                                    'isActive': serializeParam(
                                          isMeterActive,
                                          ParamType.bool,
                                        ) ??
                                        '',
                                  },
                                  extra: <String, dynamic>{
                                    'docReference': listViewMeterRecord,
                                  },
                                );
                              } catch (e) {
                                print('Navigation failed: $e');
                              }
                            },
                          ),
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
