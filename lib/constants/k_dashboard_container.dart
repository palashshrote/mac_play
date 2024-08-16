import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:flutter/src/cupertino/icons.dart';
import 'package:hydrow/auth/auth_util.dart';
import 'package:hydrow/backend/backend.dart';
import 'package:hydrow/components/TermsandCondition_widget.dart';
import 'package:hydrow/components/about_widget.dart';
import 'package:hydrow/components/contact_us_widget.dart';
import 'package:hydrow/flutter_flow/flutter_flow_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hydrow/primary_tank/primary_tank_widget.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import '/flutter_flow/custom_functions.dart' as functions;

var notSelectedStyle = GF.GoogleFonts.leagueSpartan(
  height: 1.5,
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

var defaultDeviceNADataStyle = GF.GoogleFonts.leagueSpartan(
  fontSize: 24,
  color: Color(0xFF91D9E9),
  fontWeight: FontWeight.w600,
);

var defaultDeviceNameStyle = GF.GoogleFonts.leagueSpartan(
  fontSize: 30,
  color: Color(0xFFFFFFFF),
  fontWeight: FontWeight.w600,
);

var defaultDeviceDataStyle = GF.GoogleFonts.leagueSpartan(
  fontSize: 24,
  color: Color(0xFF91D9E9),
  fontWeight: FontWeight.w600,
);

var showAllDeviceButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7.5),
    ),
    backgroundColor: Color(0xFFC6DDDB),
    padding: EdgeInsetsDirectional.fromSTEB(20, 17, 20, 17));

Widget defaultDeviceName(String str) {
  return Text(
    str,
    style: defaultDeviceNameStyle,
    overflow: TextOverflow.ellipsis,
  );
}

/*
Widget generalPage(BuildContext context, String date, bool isActive{
  return SingleChildScrollView(
        child: Container(
          // color: Colors.black,
          color: Color(0xFF0C0C0C),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 25, 20, 0),
                child: Text(
                  'Hi,',
                  style: GF.GoogleFonts.leagueSpartan(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w600,
                      fontSize: 40),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 5, 20, 0),
                child: Text(
                  currentUserDisplayName, //replace with $username
                  style: GF.GoogleFonts.leagueSpartan(
                      color: Color(0xFF2F9DC1),
                      fontWeight: FontWeight.w600,
                      fontSize: 40),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                child: Text(
                  '$date',
                  style: GF.GoogleFonts.leagueSpartan(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.normal,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 20),
                child: StreamBuilder<List<TankRecord>>(
                  //Fetching the tank record of the default tank
                  stream: queryTankRecord(
                    parent: currentUserReference,
                    queryBuilder: (tankRecord) => tankRecord.where('TankKey',
                        isEqualTo: FFAppState().tankKey),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 75,
                          height: 75,
                          child: SpinKitRipple(
                            color: Color(0xFF7E8083),
                            size: 75,
                          ),
                        ),
                      );
                    }
                    List<TankRecord> containerTankRecordList = snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PrimaryTankWidget()));
                            },
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0xFF686868)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Default Tank is not selected. \nClick to select a Default Tank.',
                                    style: GF.GoogleFonts.leagueSpartan(
                                      height: 1.5,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    }
                    final containerTankRecord =
                        containerTankRecordList.isNotEmpty
                            ? containerTankRecordList.first
                            : null;
                    //If data found return the Water tank container
                    return Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 30, 20, 0),
                                child: Container(
                                  height: 350,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFECECEC),
                                    shape: BoxShape.rectangle,
                                    // borderRadius: BorderRadius.circular(20),
                                    // border: Border.all(color: Color(0xFFF7F7F8)),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        child: WaveWidget(
                                          config: CustomConfig(colors: [
                                            Color(0xFF93DCEC),
                                            Color(0xFF91D9E9),
                                            Color(0xFF52B9D5)
                                          ], durations: [
                                            4000,
                                            6000,
                                            8000
                                          ], heightPercentages: [
                                            isActive
                                                ? 0.87 -
                                                    functions.tankAPI(
                                                        functions.calculateWaterAvailable(
                                                            containerTankRecord!
                                                                .length!,
                                                            containerTankRecord!
                                                                .breadth!,
                                                            containerTankRecord!
                                                                .height!,
                                                            containerTankRecord!
                                                                .radius!,
                                                            _model.waterLevel,
                                                            containerTankRecord!
                                                                .isCuboid!),
                                                        functions.calculateVolume(
                                                            containerTankRecord!
                                                                .isCuboid!,
                                                            containerTankRecord!
                                                                .length!,
                                                            containerTankRecord!
                                                                .breadth!,
                                                            containerTankRecord!
                                                                .height!,
                                                            containerTankRecord!
                                                                .radius!))
                                                : 0.87,
                                            isActive
                                                ? 0.87 -
                                                    functions.tankAPI(
                                                        functions.calculateWaterAvailable(
                                                            containerTankRecord!
                                                                .length!,
                                                            containerTankRecord!
                                                                .breadth!,
                                                            containerTankRecord!
                                                                .height!,
                                                            containerTankRecord!
                                                                .radius!,
                                                            _model.waterLevel,
                                                            containerTankRecord!
                                                                .isCuboid!),
                                                        functions.calculateVolume(
                                                            containerTankRecord!
                                                                .isCuboid!,
                                                            containerTankRecord!
                                                                .length!,
                                                            containerTankRecord!
                                                                .breadth!,
                                                            containerTankRecord!
                                                                .height!,
                                                            containerTankRecord!
                                                                .radius!))
                                                : 0.87,
                                            isActive
                                                ? 0.87 -
                                                    functions.tankAPI(
                                                        functions.calculateWaterAvailable(
                                                            containerTankRecord!
                                                                .length!,
                                                            containerTankRecord!
                                                                .breadth!,
                                                            containerTankRecord!
                                                                .height!,
                                                            containerTankRecord!
                                                                .radius!,
                                                            _model.waterLevel,
                                                            containerTankRecord!
                                                                .isCuboid!),
                                                        functions.calculateVolume(
                                                            containerTankRecord!
                                                                .isCuboid!,
                                                            containerTankRecord!
                                                                .length!,
                                                            containerTankRecord!
                                                                .breadth!,
                                                            containerTankRecord!
                                                                .height!,
                                                            containerTankRecord!
                                                                .radius!))
                                                : 0.87
                                          ]
                                              // heightPercentages: [
                                              //   0.50,
                                              //   0.52,
                                              //   0.54
                                              // ], //replace with actual tank height
                                              // blur: MaskFilter.blur(BlurStyle.solid, 1),
                                              ),
                                          waveAmplitude: 3.00, //depth of curves
                                          waveFrequency:
                                              3, //number of curves in waves
                                          size: Size(
                                            double.infinity,
                                            double.infinity,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          child: Center(
                                        child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.75,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.75,
                                            decoration: BoxDecoration(
                                              color: Color(0xC00C0C0C),
                                              shape: BoxShape.circle,
                                            ),
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    50, 0, 50, 0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  //Row 1
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        containerTankRecord!
                                                            .tankName!, //replace with $tankname variable
                                                        // Text(text.length > 8 ? '${text.substring(0, 8)}...' : text); for input variable $text
                                                        style: GF.GoogleFonts
                                                            .leagueSpartan(
                                                          fontSize: 30,
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis, // new
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  //Row2
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Column(
                                                      //row2 column1
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Row(
                                                          //row2 column1 subrow1
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text('Tank Filled',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GF
                                                                        .GoogleFonts
                                                                    .leagueSpartan(
                                                                  fontSize: 16,
                                                                  color: Color(
                                                                      0xFFFFFFFF),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                )),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                        Row(
                                                          //row2 column1 subrow2
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                isActive
                                                                    ? functions.convertToInt(functions.tankAPI(functions.calculateWaterAvailable(containerTankRecord!.length!, containerTankRecord!.breadth!, containerTankRecord!.height!, containerTankRecord!.radius!, _model.waterLevel, containerTankRecord!.isCuboid!), containerTankRecord!.capacity)).toString() +
                                                                        " %"
                                                                    : 'N/A', //replace with original data
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GF
                                                                        .GoogleFonts
                                                                    .leagueSpartan(
                                                                  fontSize: 24,
                                                                  color: Color(
                                                                      0xFF91D9E9),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                )),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      //row2 column2
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Row(
                                                          //row2 column2 subrow1
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                'Available for use',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GF
                                                                        .GoogleFonts
                                                                    .leagueSpartan(
                                                                  fontSize: 16,
                                                                  color: Color(
                                                                      0xFFFFFFFF),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                )),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                        Row(
                                                          //row2 column2 subrow2
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                isActive
                                                                    ? functions.shortenNumber(functions.calculateWaterAvailable(
                                                                            containerTankRecord!
                                                                                .length!,
                                                                            containerTankRecord!
                                                                                .breadth!,
                                                                            containerTankRecord!
                                                                                .height!,
                                                                            containerTankRecord!
                                                                                .radius!,
                                                                            _model
                                                                                .waterLevel,
                                                                            containerTankRecord!
                                                                                .isCuboid!)) +
                                                                        "L"
                                                                    : 'N/A', //replace with oririginal data
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GF
                                                                        .GoogleFonts
                                                                    .leagueSpartan(
                                                                  fontSize: 24,
                                                                  color: Color(
                                                                      0xFF91D9E9),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                )),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  //Row3
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Column(
                                                      //row3 column1
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Row(
                                                          //row3 column1 subrow1
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text('Total Volume',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GF
                                                                        .GoogleFonts
                                                                    .leagueSpartan(
                                                                  fontSize: 16,
                                                                  color: Color(
                                                                      0xFFFFFFFF),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                )),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                        Row(
                                                          //row3 column1 subrow2
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                isActive
                                                                    ? functions.shortenNumber(containerTankRecord!
                                                                            .capacity!) +
                                                                        'L'
                                                                    : 'N/A', //replace with oririginal data
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GF
                                                                        .GoogleFonts
                                                                    .leagueSpartan(
                                                                  fontSize: 24,
                                                                  color: Color(
                                                                      0xFF91D9E9),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                )),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      //row3 column2
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Row(
                                                          //row3 column2 subrow1
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text('Temperature',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GF
                                                                        .GoogleFonts
                                                                    .leagueSpartan(
                                                                  fontSize: 16,
                                                                  color: Color(
                                                                      0xFFFFFFFF),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                )),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                        Row(
                                                          //row3 column2 subrow2
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                isActive
                                                                    ? _model.temperature
                                                                            .toString() +
                                                                        ' \u00B0C'
                                                                    : 'N/A', //replace with original data
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GF
                                                                        .GoogleFonts
                                                                    .leagueSpartan(
                                                                  fontSize: 24,
                                                                  color: Color(
                                                                      0xFF91D9E9),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                )),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  //Row4
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton.icon(
                                                      // <-- ElevatedButton
                                                      onPressed: () async {
                                                        isActive = await functions
                                                            .checkActivity(
                                                                FFAppState()
                                                                    .tankKey);
                                                        _model.waterLevel = await actions.callAPI(
                                                            functions.generateChannelID(
                                                                containerTankRecord!
                                                                    .tankKey!),
                                                            functions.generateReadAPI(
                                                                containerTankRecord!
                                                                    .tankKey!));
                                                        _model.temperature = await callAPITemperature(
                                                            functions.generateChannelID(
                                                                containerTankRecord!
                                                                    .tankKey!),
                                                            functions.generateReadAPI(
                                                                containerTankRecord!
                                                                    .tankKey!));
                                                        setState(() {});
                                                      },
                                                      icon: Icon(
                                                        CupertinoIcons
                                                            .arrow_2_squarepath,
                                                        size: 16.0,
                                                        color:
                                                            Color(0xFF0C0C0C),
                                                      ),
                                                      label: Text(
                                                        'Refresh',
                                                        style: GF.GoogleFonts
                                                            .leagueSpartan(
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xFF0C0C0C),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      7.5),
                                                        ),
                                                        backgroundColor:
                                                            Color(0xFFC6DDDB),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 40, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tank Summary',
                                      style: GF.GoogleFonts.leagueSpartan(
                                        fontSize: 24,
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF1A1A1A),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Color(0xFF656565),
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15, 0, 15, 0),
                                          child: DropdownButton<String>(
                                            value: dropdownValueStarr,
                                            // borderRadius: BorderRadius.circular(5),
                                            dropdownColor: Color(0xFF1A1A1A),
                                            focusColor: Color(0xFF1A1A1A),

                                            icon: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Icon(
                                                  CupertinoIcons
                                                      .arrow_turn_right_down,
                                                  size: 14,
                                                )),
                                            iconEnabledColor:
                                                Color(0xFF656565), //Icon color
                                            underline: Container(),
                                            items: <String>[
                                              'Daily',
                                              'Weekly',
                                              'Monthly'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value,
                                                    style: GF.GoogleFonts
                                                        .leagueSpartan(
                                                      fontSize: 14,
                                                      color: Color(0xFFFFFFFF),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    )),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownValueStarr = newValue!;
                                              });
                                            },
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 20, 15, 0),
                                child: Container(
                                  height: 200,
                                  child: FutureBuilder<SfCartesianChart>(
                                    // replace with following call
                                    future: functions.getChartStarr(
                                        containerTankRecord!.tankKey,
                                        dropdownValueStarr,
                                        containerTankRecord!.length!,
                                        containerTankRecord!.breadth!,
                                        containerTankRecord!.height!,
                                        containerTankRecord!.radius!,
                                        containerTankRecord!.capacity!,
                                        containerTankRecord!.isCuboid!),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Text(
                                            'Error occured in loading graph.');
                                      } else {
                                        return snapshot.data ??
                                            SizedBox(); // Render the chart or an empty SizedBox if data is null
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 30, 20, 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        // _model.output =
                                        //     await actions.newCustomAction(
                                        //   (currentUserDocument?.keyList
                                        //               ?.toList() ??
                                        //           [])
                                        //       .toList(),
                                        // );
                                        try {
                                          _model.output =
                                              await actions.newCustomAction(
                                            (currentUserDocument?.keyList
                                                        ?.toList() ??
                                                    [])
                                                .toList(),
                                          );

                                          // Check if _model.output is null or any other failure condition
                                          if (_model.output == null) {
                                            // Handle the case where the output is null
                                            // print(
                                            //     'Action failed: output is null');
                                          } else {
                                            // Handle the successful case
                                            // print(
                                            // 'Action succeeded: output is ${_model.output}');
                                          }
                                        } catch (e) {
                                          // Handle any exceptions that occur
                                          // print('An error occurred: $e');
                                        }

                                        setState(() {
                                          _isLoading = false;
                                        });

                                        context.pushNamed(
                                          'TankSummary',
                                          queryParams: {
                                            'water': serializeParam(
                                              _model.output,
                                              ParamType.JSON,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Text(
                                        'Show All Devices',
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
                                                  20, 17, 20, 17)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // ),
      );
}
*/
Widget genralDrawer(
    BuildContext context,
    void Function()? onTapAdd,
    void Function()? onTapDefault,
    void Function()? onTapEditPr,
    void Function()? onTapSettings,
    void Function()? onTapLogout) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.7,
    child: Drawer(
      backgroundColor: Color(0xFF0C0C0C),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          // Drawer Element
          InkWell(
            onTap: onTapAdd,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 20, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    CupertinoIcons.add,
                    size: 20,
                    color: Color(0xFF93DCEC),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Add Device',
                      style: GF.GoogleFonts.leagueSpartan(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      )),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: onTapDefault,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 20, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/images/change-icon.svg',
                    height: 20,
                    colorFilter:
                        ColorFilter.mode(Color(0xFF93DCEC), BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Change Defaults',
                      style: GF.GoogleFonts.leagueSpartan(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      )),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: onTapEditPr,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 20, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/images/edit-icon.svg',
                    height: 20,
                    colorFilter:
                        ColorFilter.mode(Color(0xFF93DCEC), BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Edit Profile',
                      style: GF.GoogleFonts.leagueSpartan(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      )),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: onTapSettings,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 20, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/images/settings-icon.svg',
                    height: 20,
                    colorFilter:
                        ColorFilter.mode(Color(0xFF93DCEC), BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Settings',
                      style: GF.GoogleFonts.leagueSpartan(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      )),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TermsandCondition()),
              )
            },
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 20, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    CupertinoIcons.doc_text,
                    size: 20,
                    color: Color(0xFF93DCEC),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Terms & Conditions',
                      style: GF.GoogleFonts.leagueSpartan(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      )),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutWidget()),
              )
            },
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 20, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    CupertinoIcons.info_circle,
                    size: 20,
                    color: Color(0xFF93DCEC),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('About',
                      style: GF.GoogleFonts.leagueSpartan(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      )),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ContactUsWidget()),
              )
            },
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 20, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    CupertinoIcons.ellipses_bubble,
                    size: 20,
                    color: Color(0xFF93DCEC),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Contact Us',
                      style: GF.GoogleFonts.leagueSpartan(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      )),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: onTapLogout,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 20, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/images/logout-icon.svg',
                    height: 20,
                    colorFilter:
                        ColorFilter.mode(Color(0xFF93DCEC), BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Logout',
                      style: GF.GoogleFonts.leagueSpartan(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget defaultDeviceSpecsHeading(String str) {
  return Text(
    str,
    textAlign: TextAlign.center,
    style: GF.GoogleFonts.leagueSpartan(
      fontSize: 16,
      color: Color(0xFFFFFFFF),
      fontWeight: FontWeight.normal,
    ),
  );
}

Widget showAllDevicesButton(String str, void Function()? onPressFunction) {
  return ElevatedButton(
    onPressed: onPressFunction,
    child: Text(str,
        style: GF.GoogleFonts.leagueSpartan(
          fontSize: 18,
          color: Color(0xFF0C0C0C),
          fontWeight: FontWeight.w600,
        )),
    style: showAllDeviceButtonStyle,
  );
}

Widget refreshButton(void Function()? onPressFunction) {
  return ElevatedButton.icon(
    onPressed: onPressFunction,

    // onPressed: () {},
    icon: Icon(
      CupertinoIcons.arrow_2_squarepath,
      size: 16.0,
      color: Color(0xFF0C0C0C),
    ),
    label: Text(
      'Refresh',
      style: GF.GoogleFonts.leagueSpartan(
        fontSize: 16,
        color: Color(0xFF0C0C0C),
        fontWeight: FontWeight.w500,
      ),
    ),
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.5),
      ),
      padding: EdgeInsets.all(20),
      backgroundColor: Color(0xFFC6DDDB),
    ),
  );
}
