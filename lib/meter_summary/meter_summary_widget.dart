import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:hydrow/custom_code/actions/call_a_p_i.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'meter_summary_model.dart';
export 'meter_summary_model.dart';

class MeterSummaryWidget extends StatefulWidget {
  const MeterSummaryWidget({
    Key? key,
    this.reading,
  }) : super(key: key);

  final dynamic reading;

  @override
  _MeterSummaryWidgetState createState() => _MeterSummaryWidgetState();
}

class _MeterSummaryWidgetState extends State<MeterSummaryWidget> {
  late MeterSummaryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MeterSummaryModel());

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
    // print(widget.reading.toString());
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF0C0C0C),
      appBar: AppBar(
        backgroundColor: Color(0xFF112025),
        title: Text(
          'All Meters',
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
          child: Builder(
            builder: (context) {
              final meters = getJsonField(
                widget.reading,
                r'''$.meters''',
              ).toList();
              return ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: meters.length,
                  itemBuilder: (context, metersIndex) {
                    final metersItem = meters[metersIndex];
                    return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 25.0, 20.0, 0.0),
                        child: StreamBuilder<List<MeterRecord>>(
                          stream: queryMeterRecord(
                            parent: currentUserReference,
                            queryBuilder: (meterRecord) =>
                                meterRecord.where('MeterName',
                                    isEqualTo: getJsonField(
                                      metersItem,
                                      r'''$.MeterName''',
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
                            List<MeterRecord> containerMeterRecordList =
                                snapshot.data!;
                            final containerMeterRecord =
                                containerMeterRecordList.isNotEmpty
                                    ? containerMeterRecordList.first
                                    : null;
                            final isActive =
                                getJsonField(metersItem, r'''$.Activity''');
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
                                                              metersItem,
                                                              r'''$.TotalFlow''',
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
                                            containerMeterRecord!.meterName!,
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
                                          Column(
                                              // row2 column
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(//row2 subrow1
                                                    children: [
                                                  Text(
                                                    isActive == "true"
                                                        ? getJsonField(
                                                                    metersItem,
                                                                    r'''$.FlowRate''')
                                                                .toString() +
                                                            ' kL/s'
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
                                                Row(//row2 subrow2
                                                    children: [
                                                  Text(
                                                    'Flow Rate',
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
                                          ElevatedButton(
                                            onPressed: () async {
                                              _model.outputTotalFlow =
                                                  await callAPITotalFlow(
                                                functions.generateChannelID(
                                                    containerMeterRecord!
                                                        .meterKey!),
                                                functions.generateReadAPI(
                                                    containerMeterRecord!
                                                        .meterKey!),
                                              );

                                              _model.outputFlowRate =
                                                  await callAPIFlowRate(
                                                functions.generateChannelID(
                                                    containerMeterRecord!
                                                        .meterKey!),
                                                functions.generateReadAPI(
                                                    containerMeterRecord!
                                                        .meterKey!),
                                              );

                                              context.pushNamed(
                                                'IndividualMeterSummary',
                                                queryParams: {
                                                  'docReference':
                                                      serializeParam(
                                                    containerMeterRecord,
                                                    ParamType.Document,
                                                  ),
                                                  'totalFlow': serializeParam(
                                                    _model.outputTotalFlow,
                                                    ParamType.double,
                                                  ),
                                                  'flowRate': serializeParam(
                                                    _model.outputFlowRate,
                                                    ParamType.double,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'docReference':
                                                      containerMeterRecord,
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
