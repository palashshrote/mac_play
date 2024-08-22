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
import '../constants/k_generalized.dart';
import 'individual_summary_model.dart';
export 'individual_summary_model.dart';

class TwoIndividualSummaryWidget extends StatefulWidget {
  final TankRecord? docReference;
  final bool? isActive;
  const TwoIndividualSummaryWidget(
      {super.key, this.docReference, this.isActive});

  @override
  State<TwoIndividualSummaryWidget> createState() =>
      _TwoIndividualSummaryWidgetState();
}

class _TwoIndividualSummaryWidgetState extends State<TwoIndividualSummaryWidget>
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
      appBar: genAppBar("Testing starr details", centerTitle: true),
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 12.5, 30, 12.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      dataCardDecoration([
                        cardHeading("Tank Filled"),
                        sbox(9, null),
                        dataCardImproved(
                            isDeviceActive,
                            // functions
                            //     .getReading(widget.docReference!.meterKey!),

                            null,
                            null,
                            "%"),
                      ]),
                      dataCardDecoration([
                        cardHeading("Available for use"),
                        sbox(9, null),
                        dataCardImproved(
                            isDeviceActive,
                            // functions
                            //     .getFlowRate(widget.docReference!.meterKey!),
                            null,
                            null,
                            "ml/s"),
                      ]),
                    ],
                  ),
                ),
                //Total Volume and Temperature
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 12.5, 30, 12.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      dataCardDecoration([
                        cardHeading("Total Volume"),
                        sbox(9, null),
                        dataCardImproved(
                            isDeviceActive,
                            // functions
                            //     .getReading(widget.docReference!.meterKey!),
                            null,
                            null,
                            "L"),
                      ]),
                      dataCardDecoration([
                        cardHeading("Temperature"),
                        sbox(9, null),
                        dataCardImproved(
                            isDeviceActive,
                            functions.getTemp(widget.docReference!.tankKey!),
                            // null,
                            null,
                            "ml/s"),
                      ]),
                    ],
                  ),
                ),
                //Head space and water level
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 12.5, 30, 12.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      dataCardDecoration([
                        cardHeading("Head space"),
                        sbox(9, null),
                        dataCardImproved(
                            isDeviceActive,
                            // functions
                            //     .getReading(widget.docReference!.meterKey!),
                            null,
                            null,
                            "m"),
                      ]),
                      dataCardDecoration([
                        cardHeading("Water level"),
                        sbox(9, null),
                        dataCardImproved(
                            isDeviceActive,
                            functions.getStarrWaterLevel(
                                widget.docReference!.tankKey!),
                            null,
                            "ml/s"),
                      ]),
                    ],
                  ),
                ),

                //Device status
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 12.5, 30, 12.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      dataCardDecoration([
                        cardHeading("Device status"),
                        sbox(9, null),
                        dataCardImproved(
                            isDeviceActive,
                            functions
                                .checkActivity(widget.docReference!.tankKey!),
                            true,
                            null),
                      ]),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    refreshButton(() async {
                      isDeviceActive = await functions
                          .checkActivity(widget.docReference!.tankKey!);

                      isDeviceActive = true;
                      print("Check status : ${isDeviceActive}");
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
                                  dropdownValue = newValue!;
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
                          widget.docReference!.tankKey!,
                          dropdownValue),
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
