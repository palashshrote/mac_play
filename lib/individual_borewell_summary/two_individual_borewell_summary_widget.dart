import 'package:hydrow/constants/k_dashboard_container.dart';
import 'package:hydrow/constants/k_individual_device_summary.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:hydrow/backend/schema/borewell_record.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'individual_borewell_summary_model.dart';
export 'individual_borewell_summary_model.dart';

class TwoIndividualBorewellSummaryWidget extends StatefulWidget {
  final BorewellRecord? docReference;
  final bool? isActive;
  const TwoIndividualBorewellSummaryWidget(
      {super.key, this.docReference, this.isActive});

  @override
  State<TwoIndividualBorewellSummaryWidget> createState() =>
      _TwoIndividualBorewellSummaryWidgetState();
}

class _TwoIndividualBorewellSummaryWidgetState
    extends State<TwoIndividualBorewellSummaryWidget>
    with TickerProviderStateMixin {
  late IndividualBorewellSummaryModel _model;
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
    _model = createModel(context, () => IndividualBorewellSummaryModel());
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
          'Borewell Details',
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
                //Device name
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 12.5),
                      child: Text(
                        widget.docReference!.borewellName!,
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
                      dataCardDecoration([
                        cardHeading("Reading"),
                        sbox(9, null),
                        dataCardImproved(
                            isDeviceActive,
                            functions.getWaterLevelfromGround(
                                widget.docReference!.borewellKey!),
                            null,
                            "m",
                            null,
                            null),
                      ]),
                      dataCardDecoration([
                        cardHeading("Device status"),
                        sbox(9, null),
                        dataCardImproved(
                            isDeviceActive,
                            functions.checkActivityDebore(
                                widget.docReference!.borewellKey!),
                            true,
                            null,
                            null,
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
                      isDeviceActive = await functions.checkActivityDebore(
                          widget.docReference!.borewellKey!);

                      isDeviceActive = true;
                      // print("Check status : ${isDeviceActive}");
                      setState(() {});
                    })
                  ],
                ),

                Padding(
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
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
                                  dropdownValueDeboreTotal = newValue!;
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
