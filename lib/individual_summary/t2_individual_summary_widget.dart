import 'package:hydrow/constants/k_dashboard_container.dart';
import 'package:hydrow/constants/k_individual_device_summary.dart';
import 'package:hydrow/constants/k_show_all_device_style.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../constants/k_generalized.dart';
import 'individual_summary_model.dart';
export 'individual_summary_model.dart';

class T2IndividualSummaryWidget extends StatefulWidget {
  final TankRecord? docReference;
  final bool? isActive;
  final double? capacity;
  final String? height;
  final String? length;
  final String? breadth;
  final String? radius;
  final bool? isCuboid;

  const T2IndividualSummaryWidget(
      {super.key,
      this.docReference,
      this.isActive,
      this.capacity,
      this.height,
      this.length,
      this.breadth,
      this.radius,
      this.isCuboid});

  @override
  State<T2IndividualSummaryWidget> createState() =>
      _T2IndividualSummaryWidgetState();
}

class _T2IndividualSummaryWidgetState extends State<T2IndividualSummaryWidget>
    with TickerProviderStateMixin {
  late IndividualSummaryModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  String dropdownValue = 'Daily';
  bool isDeviceActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = createModel(context, () => IndividualSummaryModel());
    isDeviceActive = widget.isActive!;
    // _initializeHelper();

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.lockOrientation();
    });
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF0C0C0C),
      appBar: genAppBar("Tank Details", centerTitle: true),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Device name
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 12.5),
                      child: Text(
                        widget.docReference!.tankName!,
                        style: GF.GoogleFonts.leagueSpartan(
                          fontSize: 30,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                //Tank filled and available for use

                FutureBuilder<Map<String, dynamic>?>(
                  future: fetchTankDataForUser(widget.docReference!.tankKey!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error fetching data');
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Text('No data available');
                    }

                    var tankData = snapshot.data!;
                    var waterLevel = tankData['WaterLevel'];
                    String waterLevelStr =
                        waterLevel == "N/A" ? "N/A" : waterLevel + " m";
                    var temp = tankData['Temperature'];
                    temp = temp == "N/A" ? "N/A" : temp + " °C";
                    double capacityC = widget.docReference!.capacity!;
                    if (waterLevel != "N/A")
                      waterLevel = double.parse(waterLevel);
                    bool isTankActive = waterLevel == "N/A" ? false : true;
                    var tankFilled = waterLevel == "N/A"
                        ? "N/A"
                        : functions
                                .convertToInt(
                                  functions.tankAPI(
                                      functions.calculateWaterAvailable(
                                        widget.docReference!.length!,
                                        widget.docReference!.breadth!,
                                        widget.docReference!.height!,
                                        widget.docReference!.radius!,
                                        waterLevel,
                                        widget.docReference!.isCuboid!,
                                      ),
                                      capacityC),
                                )
                                .toString() +
                            " %";
                    var availForUse = waterLevel == "N/A"
                        ? "N/A"
                        : functions
                                .calculateWaterAvailable(
                                  widget.docReference!.length!,
                                  widget.docReference!.breadth!,
                                  widget.docReference!.height!,
                                  widget.docReference!.radius!,
                                  waterLevel,
                                  widget.docReference!.isCuboid!,
                                )
                                .toString() +
                            " L";
                    var totalVol = capacityC.toString() + " L";
                    var headSpace = waterLevel == "N/A"
                        ? "N/A"
                        : calculateHeadSpace(waterLevel.toString(),
                                widget.docReference!.height!) +
                            " m";

                    Timestamp ts = tankData['Timestamp'];
                    DateTime dt = ts.toDate();
                    return Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(30, 12.5, 30, 12.5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              dataContainer("Tank Filled", tankFilled),
                              dataContainer("Available for use", availForUse),
                            ],
                          ),
                          sbox(10, null),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              dataContainer("Total Volume", totalVol),
                              dataContainer("Temperature", temp),
                            ],
                          ),
                          sbox(10, null),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              dataContainer("Head space", headSpace),
                              dataContainer("Water level", waterLevelStr),
                            ],
                          ),
                          sbox(10, null),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              dataContainer("Device status",
                                  isTankActive ? "Active" : "Inactive"),
                            ],
                          ),
                          sbox(10, null),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              dataContainerUpdatedAt("Updated at", dt, 300),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    refreshButton(() async {
                      setState(() {});
                    })
                  ],
                ),

                // Total Flow Chart
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tank Summary',
                        style: GF.GoogleFonts.leagueSpartan(
                          fontSize: 24,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color(0xFF656565),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            // borderRadius: BorderRadius.circular(5),
                            dropdownColor: Color(0xFF1A1A1A),
                            focusColor: Color(0xFF1A1A1A),

                            icon: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(
                                  CupertinoIcons.arrow_turn_right_down,
                                  size: 14,
                                )),
                            iconEnabledColor: Color(0xFF656565), //Icon color
                            underline: Container(),
                            items: <String>['Daily', 'Weekly', 'Monthly']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: GF.GoogleFonts.leagueSpartan(
                                      fontSize: 14,
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.normal,
                                    )),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // graph - library to be updated as per the data
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                  child: Container(
                    height: 200,
                    child: FutureBuilder<SfCartesianChart>(
                      future: functions.getChartStarr(
                          widget.docReference!.tankKey!,
                          dropdownValue,
                          widget.docReference!.length!,
                          widget.docReference!.breadth!,
                          widget.docReference!.height!,
                          widget.docReference!.radius!,
                          widget.docReference!.capacity!,
                          widget.docReference!.isCuboid!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error occured in loading graph.');
                        } else {
                          return snapshot.data ??
                              SizedBox(); // Render the chart or an empty SizedBox if data is null
                        }
                      },
                    ),
                  ),
                ),

                //Insights
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                  child: Text(
                    'Tank Insights',
                    style: GF.GoogleFonts.leagueSpartan(
                      fontSize: 24,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                //today h20 consumption
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFF686868)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // width: double.infinity * 0.4,
                            width:
                                (MediaQuery.of(context).size.width - 70) * 0.3,
                            child: FutureBuilder<dynamic>(
                                future: functions.getTodayUse(
                                    widget.docReference!.tankKey!,
                                    widget.docReference!.length!,
                                    widget.docReference!.breadth!,
                                    widget.docReference!.radius!,
                                    widget.docReference!.isCuboid!),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator(); // Display a loading indicator while waiting for the result
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    var value = snapshot.data;
                                    return Text(
                                        value.toString() +
                                            'L', //replace with original data
                                        textAlign: TextAlign.left,
                                        style: GF.GoogleFonts.leagueSpartan(
                                          fontSize: 24,
                                          color: Color(0xFF91D9E9),
                                          fontWeight: FontWeight.w600,
                                        ));
                                  }
                                }),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text('Today\'s Water Consumption',
                                textAlign: TextAlign.left,
                                style: GF.GoogleFonts.leagueSpartan(
                                  fontSize: 20,
                                  height: 1.5,
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.normal,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //av daily h20 consumption
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFF686868)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // width: double.infinity * 0.4,
                            width:
                                (MediaQuery.of(context).size.width - 70) * 0.3,
                            child: FutureBuilder<dynamic>(
                                future: functions.getAverageUse(
                                    widget.docReference!.tankKey!,
                                    widget.docReference!.length!,
                                    widget.docReference!.breadth!,
                                    widget.docReference!.radius!,
                                    widget.docReference!.isCuboid!),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator(); // Display a loading indicator while waiting for the result
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    var value = snapshot.data;
                                    return Text(
                                        value.toString() +
                                            'L', //replace with original data
                                        textAlign: TextAlign.left,
                                        style: GF.GoogleFonts.leagueSpartan(
                                          fontSize: 24,
                                          color: Color(0xFF91D9E9),
                                          fontWeight: FontWeight.w600,
                                        ));
                                  }
                                }),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text('Average Daily Water Consumption',
                                textAlign: TextAlign.left,
                                style: GF.GoogleFonts.leagueSpartan(
                                  fontSize: 20,
                                  height: 1.5,
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.normal,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
