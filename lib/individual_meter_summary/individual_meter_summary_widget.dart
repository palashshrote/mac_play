import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'individual_meter_summary_model.dart';
export 'individual_meter_summary_model.dart';

class IndividualMeterSummaryWidget extends StatefulWidget {
  const IndividualMeterSummaryWidget({
    Key? key,
    this.docReference,
    this.totalFlow,
    this.flowRate,
  }) : super(key: key);

  final MeterRecord? docReference;
  final double? totalFlow;
  final double? flowRate;

  @override
  _IndividualMeterSummaryWidgetState createState() =>
      _IndividualMeterSummaryWidgetState();
}

class _IndividualMeterSummaryWidgetState
    extends State<IndividualMeterSummaryWidget> with TickerProviderStateMixin {
  late IndividualMeterSummaryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  String dropdownValuePravahTotal = 'Daily';
  String dropdownValuePravahRate = 'Daily';
  bool isActive = false;
  

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
    _initializeHelper();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.lockOrientation();
    });
  }

  void _initializeHelper() async {
    bool fetchIsActive = await functions.checkActivityPravah(widget.docReference!.meterKey!);
    setState(() {
      isActive = fetchIsActive;
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
      appBar: AppBar(
        backgroundColor: Color(0xFF112025),
        title: Text(
          'Meter Details',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 12.5, 30, 12.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 140,
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
                                Text('Reading',
                                    textAlign: TextAlign.center,
                                    style: GF.GoogleFonts.leagueSpartan(
                                      fontSize: 16,
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.normal,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            Row(
                              //container1 row2
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isActive ?
                                    functions.shortenNumber(widget.totalFlow!) +
                                        'L' : 'N/A',
                                    textAlign: TextAlign.center,
                                    style: GF.GoogleFonts.leagueSpartan(
                                      fontSize: 24,
                                      color: Color(0xFF91D9E9),
                                      fontWeight: FontWeight.w600,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 140,
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
                                Text('Flow Rate',
                                    textAlign: TextAlign.center,
                                    style: GF.GoogleFonts.leagueSpartan(
                                      fontSize: 16,
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.normal,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            Row(
                              //container1 row2
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isActive ?
                                  widget.flowRate.toString() + ' kL/s' : 'N/A',
                                    textAlign: TextAlign.center,
                                    style: GF.GoogleFonts.leagueSpartan(
                                      fontSize: 24,
                                      color: Color(0xFF91D9E9),
                                      fontWeight: FontWeight.w600,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 12.5, 30, 12.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 140,
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
                                Text('Device Status',
                                    textAlign: TextAlign.center,
                                    style: GF.GoogleFonts.leagueSpartan(
                                      fontSize: 16,
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.normal,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            Row(
                              //container1 row2
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isActive ? 'Active' : 'Inactive',
                                    textAlign: TextAlign.center,
                                    style: GF.GoogleFonts.leagueSpartan(
                                      fontSize: 24,
                                      color: isActive? Color(0xFF91E995) : Color(0xFFFB7070),
                                      fontWeight: FontWeight.w600,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                      ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        
                        setState(() {});
                      },
                      icon: Icon(
                        CupertinoIcons.arrow_2_squarepath,
                        size: 16.0,
                        color: Color(0xFF0C0C0C),
                      ),
                      label: Text(
                        'Refresh',
                        style: GF.GoogleFonts.leagueSpartan(
                          fontSize: 16,
                          color: Color(0xFF0C0C0C),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        backgroundColor: Color(0xFFC6DDDB),
                        padding: EdgeInsetsDirectional.fromSTEB(20, 17, 20, 17),
                      ),
                    )
                  ],
                ),
                // Total Flow Chart
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Flow Summary',
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                            child: DropdownButton<String>(
                              value: dropdownValuePravahTotal,
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
                              items: <String>[
                                'Daily',
                                'Weekly',
                                'Monthly'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                                  dropdownValuePravahTotal = newValue!;
                                });
                              },
                            ),
                          )),
                    ],
                  ),
                ),
                // graph - library to be updated as per the data
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                  child: Container(
                    height: 200,
                    child: FutureBuilder<SfCartesianChart>(
                      future: functions.getChartPravahTotal(
                          widget.docReference!.meterKey!,
                          dropdownValuePravahTotal),
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

                // Flow Rate Chart
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Flow Rate Summary',
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                            child: DropdownButton<String>(
                              value: dropdownValuePravahRate,
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
                              items: <String>[
                                'Daily',
                                'Weekly',
                                'Monthly'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                                  dropdownValuePravahRate = newValue!;
                                });
                              },
                            ),
                          )),
                    ],
                  ),
                ),
                // graph - library to be updated as per the data
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                  child: Container(
                    height: 200,
                    child: FutureBuilder<SfCartesianChart>(
                      future: functions.getChartPravahRate(
                          widget.docReference!.meterKey!,
                          dropdownValuePravahRate),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
