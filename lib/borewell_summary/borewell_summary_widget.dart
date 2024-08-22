import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hydrow/auth/auth_util.dart';
import 'package:hydrow/backend/backend.dart';
import 'package:hydrow/backend/schema/borewell_record.dart';
import 'package:hydrow/constants/k_generalized.dart';
import 'package:hydrow/custom_code/actions/call_a_p_i.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'borewell_summary_model.dart';
export 'borewell_summary_model.dart';

class BorewellSummaryWidget extends StatefulWidget {
  final dynamic reading;
  const BorewellSummaryWidget({super.key, this.reading});

  @override
  State<BorewellSummaryWidget> createState() => _BorewellSummaryWidgetState();
}

class _BorewellSummaryWidgetState extends State<BorewellSummaryWidget> {
  late BorewellSummaryModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = createModel(context, () => BorewellSummaryModel());
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
      appBar: genAppBar("All Borewellss", centerTitle: true),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Builder(
            builder: (context) {
              final borewells = getJsonField(
                widget.reading,
                r'''$.borewells''',
              ).toList();
              return ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: borewells.length,
                  itemBuilder: (context, borewellsIndex) {
                    final borewellsItem = borewells[borewellsIndex];
                    return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 25.0, 20.0, 0.0),
                        child: StreamBuilder<List<BorewellRecord>>(
                          stream: queryBorewellRecord(
                            parent: currentUserReference,
                            queryBuilder: (borewellRecord) =>
                                borewellRecord.where('BorewellName',
                                    isEqualTo: getJsonField(
                                      borewellsItem,
                                      r'''$.BorewellName''',
                                    ).toString()),
                            singleRecord: true,
                          ),
                          builder: (context, snapshot) {
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
                            List<BorewellRecord> containerBorewellRecordList =
                                snapshot.data!;
                            final containerBorewellRecord =
                                containerBorewellRecordList.isNotEmpty
                                    ? containerBorewellRecordList.first
                                    : null;
                            final isActive =
                                getJsonField(borewellsItem, r'''$.Activity''');
                            return Container(
                                height: 160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Color(0xFF686868)),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      22, 22, 22, 22),
                                  child: Column(
                                    //main column
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        //row1
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                              // row1 column
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(//row1 subrow1
                                                    children: [
                                                  Text(
                                                    isActive == "true"
                                                        ? getJsonField(
                                                              borewellsItem,
                                                              r'''$.WaterLevel''',
                                                            ).toString() +
                                                            " L"
                                                        : 'N/A',
                                                    style: GF.GoogleFonts
                                                        .leagueSpartan(
                                                      fontSize: 28,
                                                      color: Color(0xFF91D9E9),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ]),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                Row(//row1 subrow2
                                                    children: [
                                                  Text(
                                                    'Reading',
                                                    style: GF.GoogleFonts
                                                        .leagueSpartan(
                                                      fontSize: 18,
                                                      color: Color(0xFFFFFFFF),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ]),
                                              ]),
                                          Text(
                                            containerBorewellRecord!
                                                .borewellName!,
                                            style: GF.GoogleFonts.leagueSpartan(
                                              fontSize: 30,
                                              color: Color(0xFFFFFFFF),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        //row2
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              _model.outputWaterLevel =
                                                  await callAPIWaterLevel(
                                                functions.generateChannelID(
                                                    containerBorewellRecord
                                                        .borewellKey!),
                                                functions.generateReadAPI(
                                                    containerBorewellRecord
                                                        .borewellKey!),
                                              );
                                              print(
                                                  "Water level = ${_model.outputWaterLevel}");

                                              context.pushNamed(
                                                'IndividualBorewellSummary',
                                                queryParams: {
                                                  'docReference':
                                                      serializeParam(
                                                    containerBorewellRecord,
                                                    ParamType.Document,
                                                  ),
                                                  'waterLevel': serializeParam(
                                                    _model.outputWaterLevel,
                                                    ParamType.double,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'docReference':
                                                      containerBorewellRecord,
                                                },
                                              );

                                              setState(() {});
                                            },
                                            child: Text(
                                              'View More',
                                              style:
                                                  GF.GoogleFonts.leagueSpartan(
                                                fontSize: 18,
                                                color: Color(0xFF0C0C0C),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.5),
                                                ),
                                                backgroundColor:
                                                    Color(0xFFC6DDDB),
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15, 7.5, 15, 7.5)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        ));
                  });
            },
          ),
        ),
      ),
    );
  }
}
