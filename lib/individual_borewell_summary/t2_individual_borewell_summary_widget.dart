import 'package:hydrow/backend/backend.dart';
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

class T2IndividualBorewellSummaryWidget extends StatefulWidget {
  final BorewellRecord? docReference;
  final bool? isActive;
  const T2IndividualBorewellSummaryWidget(
      {super.key, this.docReference, this.isActive});

  @override
  State<T2IndividualBorewellSummaryWidget> createState() =>
      _T2IndividualBorewellSummaryWidgetState();
}

class _T2IndividualBorewellSummaryWidgetState
    extends State<T2IndividualBorewellSummaryWidget>
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
          'Borewell Details (Testing)',
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                FutureBuilder<Map<String, dynamic>?>(
                  future: fetchBorewellDataForUser(
                      widget.docReference!.borewellKey!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error fetching data');
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Text('No data available');
                    }

                    var borewellData = snapshot.data!;
                    var waterLevel = borewellData['WaterLevelGround'];
                    Timestamp ts = borewellData['Timestamp'];
                    DateTime dt = ts.toDate();
                    // print("Timestamp val: ${dt}");
                    bool isBorewellActive = waterLevel == "N/A" ? false : true;
                    return Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(30, 12.5, 30, 12.5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              dataContainer("Reading", waterLevel),
                              dataContainer("Device status",
                                  isBorewellActive ? "Active" : "Inactive"),
                            ],
                          ),
                          sbox(10, null),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              dataContainer("Updated at", dt.toString(), 200),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    refreshButton(() async {
                      setState(() {});
                    })
                  ],
                ),

                
                summaryDropDownBtnGeneralized(
                  "Borewell Summary",
                  dropdownValueDeboreTotal,
                  (String? newValue) {
                    setState(() {
                      dropdownValueDeboreTotal = newValue!;
                    });
                  },
                ),
                generalizedGraph(
                  functions.getChartDebore(widget.docReference!.borewellKey!,
                      dropdownValueDeboreTotal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
