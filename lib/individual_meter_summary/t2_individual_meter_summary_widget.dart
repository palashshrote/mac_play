import 'package:hydrow/constants/k_dashboard_container.dart';
import 'package:hydrow/constants/k_individual_device_summary.dart';

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
import 'individual_meter_summary_model.dart';
export 'individual_meter_summary_model.dart';

class T2IndividualMeterSummaryWidget extends StatefulWidget {
  final MeterRecord? docReference;
  final bool? isActive;
  const T2IndividualMeterSummaryWidget(
      {super.key, this.docReference, this.isActive});

  @override
  State<T2IndividualMeterSummaryWidget> createState() =>
      _T2IndividualMeterSummaryWidgetState();
}

class _T2IndividualMeterSummaryWidgetState
    extends State<T2IndividualMeterSummaryWidget>
    with TickerProviderStateMixin {
  late IndividualMeterSummaryModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  String dropdownValueDeboreTotal = 'Daily';
  bool isDeviceActive = false;
  final animationsMap = {
    'columnOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IndividualMeterSummaryModel());
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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF0C0C0C),
      appBar: AppBar(
        backgroundColor: Color(0xFF112025),
        title: Text(
          'Borewell Details (Testing)',
          style: GF.GoogleFonts.leagueSpartan(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.normal,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Device name
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 12.5),
                      child: Text(
                        widget.docReference!.meterName!,
                        style: GF.GoogleFonts.leagueSpartan(
                          fontSize: 30,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                FutureBuilder<Map<String, dynamic>?>(
                  future: fetchMeterDataForUser(listViewMeterRecord.meterKey!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error fetching data');
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Text('No data available');
                    }

                    var meterData = snapshot.data!;
                    var reading = meterData['Reading'] + " kL";
                    var flowRate = meterData['FlowRate'] + " ml/s";
                    bool isMeterActive = reading == "N/A" ? false : true;
                    return Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(30, 12.5, 30, 12.5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              dataContainer("Reading", waterLevel),
                              dataContainer("Device status",
                                  isBorewellActive ? "Active" : "Inactive"),
                            ],
                          ),
                          sbox(10, null),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              dataContainer("Updated at", dt.toString(), 200),
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

                /*Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Borewell Summary',
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
                            value: dropdownValueDeboreTotal,
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
                                dropdownValueDeboreTotal = newValue!;
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
                      future: functions.getChartDebore(
                          widget.docReference!.borewellKey!,
                          dropdownValueDeboreTotal),
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
                */
                summaryDropDownBtnGeneralized(
                  "Borewell Summary",
                  dropdownValueDeboreTotal,
                  (String? newValue) {
                    setState(() {
                      dropdownValueDeboreTotal = newValue!;
                    });
                  },
                ),
                generalizedGraph(
                  functions.getChartDebore(widget.docReference!.borewellKey!,
                      dropdownValueDeboreTotal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
