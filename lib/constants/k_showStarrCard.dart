import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:hydrow/backend/backend.dart';
import 'package:hydrow/constants/k_individual_device_summary.dart';
import 'package:hydrow/constants/k_show_all_device_style.dart';
import 'package:hydrow/flutter_flow/custom_functions.dart';
import 'package:hydrow/flutter_flow/flutter_flow_animations.dart';
import 'package:hydrow/flutter_flow/flutter_flow_util.dart';
import 'package:hydrow/meter_summary/meter_summary_testing_model.dart';
import 'package:hydrow/tank_summary/tank_summary_testing_model.dart';
import '../borewell_summary/borewell_summary_testing_model.dart';
import '/flutter_flow/custom_functions.dart' as functions;

Widget showStarrCard(List<TankRecord> listViewTankRecordList,
    TankSummaryTestingModel _model, AnimationInfo animationsMap) {
  Future<List<dynamic>> combinedFuture(String tankKey) {
    return Future.wait([
      checkActivity(tankKey), // bool
      getTemp(tankKey),
      getStarrWaterLevel(tankKey), // String (or any other data type)
    ]);
  }

  return ListView.builder(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: listViewTankRecordList.length,
    itemBuilder: (context, listViewIndex) {
      final listViewTankRecord = listViewTankRecordList[listViewIndex];

      return FutureBuilder<List<dynamic>>(
        future: combinedFuture(listViewTankRecord.tankKey!),
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
            print("Item count: ${listViewTankRecordList.length}");
            print(snapshot.data);
            bool isTankActive = snapshot.data![0];
            var ansWaterLevel = double.parse(snapshot.data![2]);
            var ansTemp = snapshot.data![1];
            // double ansFilled = calculateWaterAvailable(
            //     listViewTankRecord.length!,
            //     listViewTankRecord.breadth!,
            //     listViewTankRecord.height!,
            //     listViewTankRecord.radius!,
            //     ansWaterLevel,
            //     listViewTankRecord.isCuboid!);
            // double ansCapacity = listViewTankRecord.capacity!;
            // double ansPercentage = tankAPI(ansFilled, ansCapacity);
            // print("TAnk filled : ${ansFilled}");
            // print("Capacity : ${ansCapacity}");
            // print("Ans Percentage : ${ansPercentage}");
            // if (ansReading == "null") ansReading = "N/A";
            // if (ansFlowRate == "null") ansFlowRate = "N/A";
            // print("DAta is ${ansReading}");

            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 0.0),
              child: Container(
                height: 160,
                decoration: isTankActive
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
                                      isTankActive
                                          ? functions
                                                  .convertToInt(functions.tankAPI(
                                                      functions
                                                          .calculateWaterAvailable(
                                                              listViewTankRecord
                                                                  .length!,
                                                              listViewTankRecord
                                                                  .breadth!,
                                                              listViewTankRecord
                                                                  .height!,
                                                              listViewTankRecord
                                                                  .radius!,
                                                              ansWaterLevel,
                                                              listViewTankRecord
                                                                  .isCuboid!),
                                                      listViewTankRecord
                                                          .capacity))
                                                  .toString() +
                                              ' %'
                                          : 'N/A',
                                      style: GF.GoogleFonts.leagueSpartan(
                                        fontSize: 28,
                                        color: Color(0xFF91D9E9),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                sbox(7, null),
                                Row(
                                  children: [
                                    Text(
                                      'Tank Filled',
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
                              listViewTankRecord.tankName!,
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
                                      isTankActive
                                          ? shortenNumber(functions
                                                  .calculateWaterAvailable(
                                                      listViewTankRecord
                                                          .length!,
                                                      listViewTankRecord
                                                          .breadth!,
                                                      listViewTankRecord
                                                          .height!,
                                                      listViewTankRecord
                                                          .radius!,
                                                      ansWaterLevel,
                                                      listViewTankRecord
                                                          .isCuboid!)) +
                                              ' L'
                                          : 'N/A',
                                      style: GF.GoogleFonts.leagueSpartan(
                                        fontSize: 28,
                                        color: Color(0xFF91D9E9),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                sbox(7, null),
                                Row(
                                  children: [
                                    Text(
                                      'Available for use',
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
                                _model.outputIsActive = await checkActivity(
                                    listViewTankRecord.tankKey!);
                                print(listViewTankRecord.tankKey!);
                                // print(listViewTankRecord.borewellKey!);
                                try {
                                  context.pushNamed(
                                    'TwoIndividualSummary',
                                    queryParams: {
                                      'docReference': serializeParam(
                                            listViewTankRecord,
                                            ParamType.Document,
                                          ) ??
                                          '',
                                      'isActive': serializeParam(
                                            _model.outputIsActive,
                                            ParamType.bool,
                                          ) ??
                                          '',
                                      'capacity': serializeParam(
                                              listViewTankRecord.capacity!,
                                              ParamType.String) ??
                                          '',
                                      'height': serializeParam(
                                              listViewTankRecord.height!,
                                              ParamType.String) ??
                                          '',
                                      'length': serializeParam(
                                              listViewTankRecord.length!,
                                              ParamType.String) ??
                                          '',
                                      'breadth': serializeParam(
                                              listViewTankRecord.breadth!,
                                              ParamType.String) ??
                                          '',
                                      'radius': serializeParam(
                                              listViewTankRecord.radius!,
                                              ParamType.String) ??
                                          '',
                                      'isCuboid': serializeParam(
                                              listViewTankRecord.isCuboid!,
                                              ParamType.bool) ??
                                          '',
                                    },
                                    extra: <String, dynamic>{
                                      'docReference': listViewTankRecord,
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
