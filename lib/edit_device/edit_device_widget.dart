import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'edit_device_model.dart';
export 'edit_device_model.dart';

class EditDeviceWidget extends StatefulWidget {
  const EditDeviceWidget({Key? key}) : super(key: key);

  @override
  _EditDeviceWidgetState createState() => _EditDeviceWidgetState();
}

class _EditDeviceWidgetState extends State<EditDeviceWidget>
    with TickerProviderStateMixin {
  late EditDeviceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

// Fade effect while opening the page.
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
    _model = createModel(context, () => EditDeviceModel());

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

// Main designing block of the page.
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF0C0C0C),
      appBar: AppBar(
        backgroundColor: Color(0xFF112025),
        title: Text(
          'Edit Devices',
          style: GF.GoogleFonts.leagueSpartan(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.normal,
            fontSize: 22, //edited
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: StreamBuilder<List<TankRecord>>(
            stream: queryTankRecord(
              parent: currentUserReference,
            ),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 75.0,
                    height: 75.0,
                    child: SpinKitRipple(
                      color: Color(0xFF7E8083),
                      size: 75.0,
                    ),
                  ),
                );
              }

              // Fetching the list of all the tanks(devices) connected with edit and delete options.
              List<TankRecord> listViewTankRecordList = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: listViewTankRecordList.length,
                itemBuilder: (context, listViewIndex) {
                  final listViewTankRecord =
                      listViewTankRecordList[listViewIndex];
                  return Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 0.0),
                    child: Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Color(0x33536765),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  listViewTankRecord.tankName!,
                                  style: GF.GoogleFonts.leagueSpartan(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                FlutterFlowIconButton(
                                  borderRadius: 30.0,
                                  borderWidth: 1.0,
                                  buttonSize: 60.0,
                                  icon: Icon(
                                    Icons.edit_rounded,
                                    color: Color(0xFF91D9E9),
                                    size: 30.0,
                                  ),
                                  onPressed: () async {
                                    context.pushNamed(
                                      'CuboidalTankEdit',
                                      queryParams: {
                                        'tankReference': serializeParam(
                                          listViewTankRecord,
                                          ParamType.Document,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        'tankReference': listViewTankRecord,
                                      },
                                    );
                                  },
                                ),
                                Text(
                                  'Edit',
                                  style: GF.GoogleFonts.leagueSpartan(
                                    color: Color(0xFF91D9E9),
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              // mainAxisSize: MainAxisSize.max,
                              children: [
                                FlutterFlowIconButton(
                                  borderRadius: 30.0,
                                  borderWidth: 1.0,
                                  buttonSize: 60.0,
                                  icon: Icon(
                                    Icons.delete_rounded,
                                    color: Color(0xFFFF7171),
                                    size: 30.0,
                                  ),
                                  onPressed: () async {
                                    var confirmDialogResponse =
                                        await showDialog<bool>(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Delete'),
                                                  content: Text(
                                                      'Are you sure you want to delete this item? The action cannot be undone.'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              false),
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              true),
                                                      child: Text('Confirm'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ) ??
                                            false;
                                    if (confirmDialogResponse) {
                                      await listViewTankRecord.reference
                                          .delete();

                                      final usersUpdateData = {
                                        'keyList': FieldValue.arrayRemove(
                                            [listViewTankRecord.tankKey]),
                                      };
                                      await currentUserReference!
                                          .update(usersUpdateData);
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Success'),
                                            content: Text(
                                                'Device deleted successfully'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            content: Text(
                                                'The entry was not deleted'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                                Text(
                                  'Delete',
                                  style: GF.GoogleFonts.leagueSpartan(
                                    color: Color(0xFFFF7171),
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation']!),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
