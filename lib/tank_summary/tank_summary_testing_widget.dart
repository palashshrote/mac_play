import 'package:hydrow/constants/k_dashboard_container.dart';
import 'package:hydrow/constants/k_show_all_device_style.dart';
import 'package:hydrow/flutter_flow/custom_functions.dart';
import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:hydrow/flutter_flow/flutter_flow_model.dart';
import 'package:provider/provider.dart';
import 'tank_summary_testing_model.dart';
import '../constants/k_generalized.dart';
export 'tank_summary_testing_model.dart';

class TankSummaryTestingWidget extends StatefulWidget {
  const TankSummaryTestingWidget({super.key});

  @override
  State<TankSummaryTestingWidget> createState() =>
      _TankSummaryTestingWidgetState();
}

class _TankSummaryTestingWidgetState extends State<TankSummaryTestingWidget>
    with TickerProviderStateMixin {
  late TankSummaryTestingModel _model;
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
    // TODO: implement initState
    super.initState();
    _model = createModel(context, () => TankSummaryTestingModel());
    //On page load action
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.lockOrientation();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
      appBar: genAppBar("All Starr testing", centerTitle: true),
      body: SafeArea(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: StreamBuilder<List<TankRecord>>(
          stream: queryTankRecord(
            parent: currentUserReference,
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return spinKit();
            }
            List<TankRecord> listViewTankRecordList = snapshot.data!;
            if (listViewTankRecordList.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Text(
                    "No Starr devices has been added.",
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
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: listViewTankRecordList.length,
                itemBuilder: (context, listViewIndex) {
                  final listViewTankRecord =
                      listViewTankRecordList[listViewIndex];

                  return FutureBuilder<bool>(
                    future: checkActivity(listViewTankRecord.tankKey!),
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
                        bool isTankActive = snapshot.data!;

                        // Display the result once the Future has resolved
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 20.0, 15.0, 0.0),
                          child: Container(
                            height: 100,
                            decoration: isTankActive
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
                                    listViewTankRecord.tankName!,
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
                                    _model.outputIsActive = await checkActivity(
                                        listViewTankRecord.tankKey!);
                                    print(listViewTankRecord.tankKey);

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
                                        },
                                        extra: <String, dynamic>{
                                          'docReference': listViewTankRecord,
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
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 20.0, 15.0, 0.0),
                          child: Container(
                            height: 100,
                            decoration:
                                inactiveDeviceDecorationStyle, // Use a default style
                            child: Center(
                              child: Text('No data available'),
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              );
            }
          },
        ),
      )),
    );
  }
}
