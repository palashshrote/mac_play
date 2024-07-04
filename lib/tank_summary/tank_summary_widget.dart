import 'package:hydrow/custom_code/actions/call_a_p_i.dart';

import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'tank_summary_model.dart';
export 'tank_summary_model.dart';

class TankSummaryWidget extends StatefulWidget {
  const TankSummaryWidget({
    Key? key,
    this.water,
  }) : super(key: key);

  final dynamic water;

  @override
  _TankSummaryWidgetState createState() => _TankSummaryWidgetState();
}

class _TankSummaryWidgetState extends State<TankSummaryWidget> {
  late TankSummaryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TankSummaryModel());

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

    // return Container();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF0C0C0C),
      appBar: AppBar(
        backgroundColor: Color(0xFF112025),
        title: Text(
          'All Tanks',
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
              //Getting all the tanks
              final tanks = getJsonField(
                widget.water,
                r'''$.tanks''',
              ).toList();
              return ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: tanks.length,
                itemBuilder: (context, tanksIndex) {
                  final tanksItem = tanks[tanksIndex];
                  return Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 25.0, 20.0, 0.0),
                    child: StreamBuilder<List<TankRecord>>(
                      stream: queryTankRecord(
                        parent: currentUserReference,
                        queryBuilder: (tankRecord) =>
                            tankRecord.where('TankName',
                                isEqualTo: getJsonField(
                                  tanksItem,
                                  r'''$.TankName''',
                                ).toString()),
                        singleRecord: true,
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
                        List<TankRecord> containerTankRecordList =
                            snapshot.data!;
                        final containerTankRecord =
                            containerTankRecordList.isNotEmpty
                                ? containerTankRecordList.first
                                : null;
                        final isActive = getJsonField(tanksItem, r'''$.Activity''');
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
                                            Row(//row1 subrow1, NA
                                                children: [
                                              Text(
                                                isActive == "true"?
                                                functions
                                                        .convertToInt(functions.tankAPI(
                                                            functions.calculateWaterAvailable(
                                                                containerTankRecord!.length!,
                                                                containerTankRecord!.breadth!,
                                                                containerTankRecord!.height!,
                                                                containerTankRecord!.radius!,
                                                                functions.stringToDouble(getJsonField(
                                                                  tanksItem,
                                                                  r'''$.WaterLevel''',
                                                                ).toString()),
                                                                containerTankRecord!.isCuboid!),
                                                            containerTankRecord!.capacity))
                                                        .toString() +
                                                    ' %':'N/A',
                                                style:
                                                    GF.GoogleFonts.leagueSpartan(
                                                  fontSize: 28,
                                                  color: Color(0xFF91D9E9),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ]),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Row(//row1 subrow2 ,Tank filled
                                                children: [ 
                                              Text(
                                                'Tank Filled',
                                                style:
                                                    GF.GoogleFonts.leagueSpartan(
                                                  fontSize: 18,
                                                  color: Color(0xFFFFFFFF),
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ]),
                                          ]),
                                      Text(
                                        containerTankRecord!.tankName!,
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                          // row2 column
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(//row2 subrow1 ,NA
                                                children: [
                                              Text(
                                                isActive == "true"?
                                                functions
                                                        .calculateWaterAvailable(
                                                            containerTankRecord!
                                                                .length!,
                                                            containerTankRecord!
                                                                .breadth!,
                                                            containerTankRecord!
                                                                .height!,
                                                            containerTankRecord!
                                                                .radius!,
                                                            functions
                                                                .stringToDouble(
                                                                    getJsonField(
                                                              tanksItem,
                                                              r'''$.WaterLevel''',
                                                            ).toString()),
                                                            containerTankRecord!
                                                                .isCuboid!)
                                                        .toString() +
                                                    ' L':'N/A',
                                                style:
                                                    GF.GoogleFonts.leagueSpartan(
                                                  fontSize: 28,
                                                  color: Color(0xFF91D9E9),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ]),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Row(//row2 subrow2 , Available for use
                                                children: [
                                              Text(
                                                'Available for use',
                                                style:
                                                    GF.GoogleFonts.leagueSpartan(
                                                  fontSize: 18,
                                                  color: Color(0xFFFFFFFF),
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ]),
                                          ]),
                                      ElevatedButton(
                                        onPressed: () async {
                                          _model.outputwater =
                                              await actions.callAPI(
                                            functions.generateChannelID(
                                                containerTankRecord!.tankKey!),
                                            functions.generateReadAPI(
                                                containerTankRecord!.tankKey!),
                                          );
                                          _model.outputtemperature =
                                              await callAPITemperature(
                                            functions.generateChannelID(
                                                containerTankRecord!.tankKey!),
                                            functions.generateReadAPI(
                                                containerTankRecord!.tankKey!),
                                          );

                                          context.pushNamed(
                                            'IndividualSummary',
                                            queryParams: {
                                              'docReference': serializeParam(
                                                containerTankRecord,
                                                ParamType.Document,
                                              ),
                                              'waterLevel': serializeParam(
                                                _model.outputwater,
                                                ParamType.double,
                                              ),
                                              'temperature': serializeParam(
                                                _model.outputtemperature,
                                                ParamType.double,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              'docReference':
                                                  containerTankRecord,
                                            },
                                          );

                                          setState(() {});
                                        },
                                        child: Text(
                                          'View More',
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15, 7.5, 15, 7.5)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      },
                    ),
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
