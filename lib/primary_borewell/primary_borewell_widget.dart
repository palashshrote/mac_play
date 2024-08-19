import 'package:hydrow/backend/schema/borewell_record.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '../backend/schema/borewell_record.dart';
import '/flutter_flow/flutter_flow_animations.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import '../constants/k_primary_widget.dart';
import 'primary_borewell_model.dart';
export 'primary_borewell_model.dart';

class PrimaryBorewellWidget extends StatefulWidget {
  const PrimaryBorewellWidget({super.key});

  @override
  State<PrimaryBorewellWidget> createState() => _PrimaryBorewellWidgetState();
}

class _PrimaryBorewellWidgetState extends State<PrimaryBorewellWidget>
    with TickerProviderStateMixin {
  late PrimaryBorewellModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  final animationsMap = {
    'containerOnPageLoadAnimation':
        AnimationInfo(trigger: AnimationTrigger.onActionTrigger, effects: [
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
    ])
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = createModel(context, () => PrimaryBorewellModel());

    // On page load action.
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
      appBar: AppBar(
        backgroundColor: Color(0xFF112025),
        title: Text(
          'Set primary borewell',
          style: appBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            return FocusScope.of(context).requestFocus(_unfocusNode);
          },
          child: StreamBuilder<List<BorewellRecord>>(
            stream: queryBorewellRecord(
              parent: currentUserReference,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 75,
                    height: 75,
                    child: SpinKitRipple(
                      color: Color.fromARGB(255, 0, 24, 29),
                      size: 75,
                    ),
                  ),
                );
              }

              List<BorewellRecord> listViewBorewellRecordList = snapshot.data!;
              if (listViewBorewellRecordList.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        "No device found, Please add devices to select a primay borewell.",
                        style: noDeviceTextStyle,
                      ),
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewBorewellRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewBorewellRecord =
                          listViewBorewellRecordList[listViewIndex];
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
                                  FFAppState().borewellKey =
                                      listViewBorewellRecord.borewellKey!;
                                });
                                // context.pushNamed('Dashboard');
                                //TWO TIMES to reach back to the hompage
                                Navigator.pop(context);
                                // Navigator.pop(context);
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 20.0, 20.0, 20.0),
                                  child: Text(
                                    listViewBorewellRecord.borewellName!,
                                    style: recordTextStyle,
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
