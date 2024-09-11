import 'package:hydrow/backend/schema/borewell_record.dart';
import 'package:hydrow/constants/k_generalized.dart';
import 'package:hydrow/constants/k_showPravahCard.dart';
import 'package:hydrow/constants/k_show_all_device_style.dart';
import 'package:hydrow/flutter_flow/custom_functions.dart';
import 'package:hydrow/meter_summary/meter_summary_t2_model.dart';
import 'package:hydrow/tank_summary/tank_summary_t2_model.dart';
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
import 'package:provider/provider.dart';
// import 'tank_summary_testing_model.dart';
// import '../constants/k_generalized.dart';
import 'tank_summary_testing_model.dart';
export 'tank_summary_testing_model.dart';

class TankSummaryT2Widget extends StatefulWidget {
  const TankSummaryT2Widget({super.key});

  @override
  State<TankSummaryT2Widget> createState() => _TankSummaryT2WidgetState();
}

class _TankSummaryT2WidgetState extends State<TankSummaryT2Widget>
    with TickerProviderStateMixin {
  late TankSummaryT2Model _model;
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
    _model = createModel(context, () => TankSummaryT2Model());
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
      appBar: genAppBar("Testing"),
      body: SafeArea(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: StreamBuilder<List<TankRecord>>(
          stream: queryTankRecord(
            parent: currentUserReference,
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 75,
                  height: 75,
                  child: SpinKitRipple(
                    color: Color(0xFF7E8083),
                    size: 75.0,
                  ),
                ),
              );
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
              return showStarrCardOptimised(listViewTankRecordList, _model,
                  animationsMap['containerOnPageLoadAnimation']!);
            }
          },
        ),
      )),
    );
  }
}
