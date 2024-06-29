import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'cube_or_cy_model.dart';
export 'cube_or_cy_model.dart';

class CubeOrCyWidget extends StatefulWidget {
  const CubeOrCyWidget({
    Key? key,
    this.tankKey,
  }) : super(key: key);

  final String? tankKey;

  @override
  _CubeOrCyWidgetState createState() => _CubeOrCyWidgetState();
}

class _CubeOrCyWidgetState extends State<CubeOrCyWidget>
    with TickerProviderStateMixin {
  late CubeOrCyModel _model;

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
    _model = createModel(context, () => CubeOrCyModel());

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
      backgroundColor: Color(0xFF0c0c0c),
      appBar: AppBar(
        backgroundColor: Color(0xFF112025),
        title: Text(
          'Select Tank Type',
          style: GF.GoogleFonts.leagueSpartan(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.normal,
            fontSize: 22, //edited
          ),
        ),
        centerTitle: true,
      ),

      // Selecting tha tank type.
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 250.0, 0.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0x33536765),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 30.0, 0.0, 10.0),
                            child: Text(
                              'What is the shape of the tank?',
                              style: GF.GoogleFonts.leagueSpartan(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 20.0, 20.0, 20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    context.pushNamed(
                                      'AddDevice',
                                      queryParams: {
                                        'tankKey': serializeParam(
                                          widget.tankKey,
                                          ParamType.String,
                                        ),
                                        'isCuboid': serializeParam(
                                          false,
                                          ParamType.bool,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Text(
                                    'Cylinder',
                                    style: GF.GoogleFonts.leagueSpartan(
                                      fontSize: 18,
                                      color: Color(0xFF0C0C0C),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.5),
                                    ),
                                    backgroundColor: Color(0xFFC6DDDB),
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 17, 20, 17),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'or',
                            style: GF.GoogleFonts.leagueSpartan(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 20.0, 20.0, 20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 20.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      context.pushNamed(
                                        'AddDevice',
                                        queryParams: {
                                          'tankKey': serializeParam(
                                            widget.tankKey,
                                            ParamType.String,
                                          ),
                                          'isCuboid': serializeParam(
                                            true,
                                            ParamType.bool,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Text(
                                      'Cuboid',
                                      style: GF.GoogleFonts.leagueSpartan(
                                        fontSize: 18,
                                        color: Color(0xFF0C0C0C),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.5),
                                      ),
                                      backgroundColor: Color(0xFFC6DDDB),
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 17, 20, 17),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation']!),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
