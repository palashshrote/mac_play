import 'package:hydrow/constants/k_generalized.dart';

import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'primary_meter_model.dart';
export 'primary_meter_model.dart';

class PrimaryMeterWidget extends StatefulWidget {
  const PrimaryMeterWidget({Key? key}) : super(key: key);

  @override
  _PrimaryMeterWidgetState createState() => _PrimaryMeterWidgetState();
}

class _PrimaryMeterWidgetState extends State<PrimaryMeterWidget>
    with TickerProviderStateMixin {
  late PrimaryMeterModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeIn,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 100.0),
          end: Offset(0.0, 0.0),
        ),
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
    _model = createModel(context, () => PrimaryMeterModel());

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
      appBar: genAppBar('Set Primary Meter', centerTitle: true),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: StreamBuilder<List<MeterRecord>>(
            stream: queryMeterRecord(
              parent: currentUserReference,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 75.0,
                    height: 75.0,
                    child: SpinKitRipple(
                      color: Color.fromARGB(255, 0, 24, 29),
                      size: 75.0,
                    ),
                  ),
                );
              }
              List<MeterRecord> listViewMeterRecordList = snapshot.data!;
              if (listViewMeterRecordList.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      "No device found, Please add devices to select a primary tank.",
                      style: GF.GoogleFonts.leagueSpartan(
                        color: Color(0xFF91D9E9),
                        fontSize: 23,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewMeterRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewMeterRecord =
                          listViewMeterRecordList[listViewIndex];
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 30.0, 20.0, 0.0),
                        child: Container(
                          width: 100.0,
                          decoration: BoxDecoration(
                            color: Color(0x33536765),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: InkWell(
                            onTap: () async {
                              if (!await InternetConnectionCheckerPlus()
                                  .hasConnection) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Please connect to the internet'),
                                  ),
                                );
                              } else {
                                FFAppState().update(() {
                                  FFAppState().meterKey =
                                      listViewMeterRecord.meterKey!;
                                });
                                // context.pushNamed('Dashboard');
                                //TWO TIMES to reach back to the hompage
                                // Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 20.0, 20.0, 20.0),
                                  child: Text(
                                    listViewMeterRecord.meterName!,
                                    style: GF.GoogleFonts.leagueSpartan(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 20, //edited
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation']!),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}
