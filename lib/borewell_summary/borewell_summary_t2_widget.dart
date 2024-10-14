import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hydrow/auth/auth_util.dart';
import 'package:hydrow/backend/backend.dart';
import 'package:hydrow/backend/schema/borewell_record.dart';
import 'package:hydrow/constants/k_generalized.dart';
import 'package:hydrow/constants/k_individual_device_summary.dart';
import 'package:hydrow/constants/k_show_all_device_style.dart';
import 'package:hydrow/flutter_flow/flutter_flow_animations.dart';
import 'package:provider/provider.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/scheduler.dart';
import 'package:hydrow/borewell_summary/borewell_summary_t2_model.dart';
import 'package:hydrow/flutter_flow/flutter_flow_util.dart';
import 'package:google_fonts/google_fonts.dart' as GF;

class BorewellSummaryT2Widget extends StatefulWidget {
  const BorewellSummaryT2Widget({super.key});

  @override
  State<BorewellSummaryT2Widget> createState() =>
      _BorewellSummaryT2WidgetState();
}

class _BorewellSummaryT2WidgetState extends State<BorewellSummaryT2Widget>
    with TickerProviderStateMixin {
  late BorewellSummaryT2Model _model;
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
    _model = createModel(context, () => BorewellSummaryT2Model());
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
      appBar: genAppBar("All Dbore Devices", centerTitle: true),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
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
                      color: Color(0xFF7E8083),
                      size: 75.0,
                    ),
                  ),
                );
              }
              List<BorewellRecord> listViewBorewellRecordList = snapshot.data!;
              if (listViewBorewellRecordList.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: Text(
                      "No Debore devices has been added.",
                      style: GF.GoogleFonts.leagueSpartan(
                        color: Color(0xFF91D9E9),
                        fontSize: 23,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                );
              } else {
                return showDeboreCardOptimised(listViewBorewellRecordList,
                    _model, animationsMap['containerOnPageLoadAnimation']!);

                /*return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listViewBorewellRecordList.length,
                  itemBuilder: (context, listViewIndex) {
                    final listViewBorewellRecord =
                        listViewBorewellRecordList[listViewIndex];

                    return FutureBuilder<Map<String, dynamic>?>(
                      future: fetchBorewellDataForUser(
                          listViewBorewellRecord.borewellKey!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text('Error fetching data');
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return const Text('No data available');
                        }

                        var borewellData = snapshot.data!;
                        var waterLevel = borewellData['WaterLevelGround'];
                        return Text(
                          'Water Level: $waterLevel',
                          style: liveDataStyle,
                        );
                      },
                    );
                  },
                );
              */
              }
            },
          ),
        ),
      ),
    );
  }
}
