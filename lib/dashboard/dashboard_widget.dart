import 'dart:async';
import 'package:hydrow/backend/schema/borewell_record.dart';
import 'package:hydrow/constants/k_dashboard_container.dart';
import 'package:hydrow/constants/k_generalized.dart';
import 'package:hydrow/custom_code/actions/call_a_p_i.dart';
import 'package:hydrow/edit_device_debore/edit_device_debore_widget.dart';
import 'package:hydrow/edit_device_pravah/edit_device_pravah_widget.dart';
import 'package:hydrow/primary_borewell/primary_borewell_widget.dart';
import 'package:hydrow/primary_meter/primary_meter_widget.dart';
import 'package:hydrow/utils/network_connectivity_widget.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../components/TermsandCondition_widget.dart';
import '../primary_tank/primary_tank_widget.dart';
import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/about_widget.dart';
import '/components/contact_us_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:hydrow/custom_code/actions/new_custom_action.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'dashboard_model.dart';
export 'dashboard_model.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'dart:ui';
import 'package:hydrow/edit_profile/edit_profile_widget.dart';
import 'package:hydrow/edit_device/edit_device_widget.dart';
import 'package:hydrow/tank_summary/tank_summary_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as gauges;

class DashboardWidget extends StatefulWidget {
  DashboardWidget({
    Key? key,
    this.water = '0',
  }) : super(key: key);

  // Getting the default tank and giving the key to tankKey variable.
  var meterKey = FFAppState().meterKey;
  var tankKey = FFAppState().tankKey;
  var borewellKey = FFAppState().borewellKey;
  String? water;

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

int selectedindex = 0;

final appTheme = ThemeData(
  primarySwatch: Colors.red,
);

class _DashboardWidgetState extends State<DashboardWidget>
    with TickerProviderStateMixin {
  late DashboardModel _model;
  bool _isLoading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  String date = new DateFormat.yMMMMd('en_US').format(new DateTime.now());
  String dropdownValueStarr = 'Daily';
  String dropdownValuePravahRate = 'Daily';
  String dropdownValuePravahTotal = 'Daily';
  String dropdownValueDebore = 'Daily';
  double _pointerValue = 60;
  bool isActive = true;
  bool isActivePravah = true;
  bool isActiveDebore = true;
  // double _waterlevel = 0.5;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardModel());
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.lockOrientation();
      isActive = await functions.checkActivity(FFAppState().tankKey);
      isActivePravah =
          await functions.checkActivityPravah(FFAppState().meterKey);
      isActiveDebore =
          await functions.checkActivityDebore(FFAppState().borewellKey);
      _model.waterLevel = await actions.callAPI(
          functions.generateChannelID(FFAppState().tankKey),
          functions.generateReadAPI(FFAppState().tankKey));
      _model.temperature = await callAPITemperature(
          functions.generateChannelID(FFAppState().tankKey),
          functions.generateReadAPI(FFAppState().tankKey));
      setState(() {});
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
    //Giving the Default tank key to widget tankKey
    widget.tankKey = FFAppState().tankKey;
    List<Widget> drawers = <Widget>[
      // Starr Drawer
      genralDrawer(
        context,
        () async {
          context.pushNamed('AddDeviceQRScan');
        },
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PrimaryTankWidget()),
          );
        },
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditProfileWidget()),
          );
        },
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditDeviceWidget()),
          );
        },
        () async {
          GoRouter.of(context).prepareAuthEvent();
          await signOut();

          context.goNamedAuth('LogInSignUp', mounted);
        },
      ),
      /*
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Drawer(
          backgroundColor: Color(0xFF0C0C0C),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              // Drawer Element
              InkWell(
                onTap: () async {
                  context.pushNamed('AddDeviceQRScan');
                },
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
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrimaryTankWidget()),
                  )
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 20, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/images/change-icon.svg',
                        height: 20,
                        colorFilter: ColorFilter.mode(
                            Color(0xFF93DCEC), BlendMode.srcIn),
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
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfileWidget()),
                  )
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 20, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/images/edit-icon.svg',
                        height: 20,
                        colorFilter: ColorFilter.mode(
                            Color(0xFF93DCEC), BlendMode.srcIn),
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
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditDeviceWidget()),
                  )
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 20, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/images/settings-icon.svg',
                        height: 20,
                        colorFilter: ColorFilter.mode(
                            Color(0xFF93DCEC), BlendMode.srcIn),
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
                    MaterialPageRoute(
                        builder: (context) => const AboutWidget()),
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
                onTap: () async {
                  GoRouter.of(context).prepareAuthEvent();
                  await signOut();

                  context.goNamedAuth('LogInSignUp', mounted);
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 20, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/images/logout-icon.svg',
                        height: 20,
                        colorFilter: ColorFilter.mode(
                            Color(0xFF93DCEC), BlendMode.srcIn),
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
      ),
      */ // Pravah Drawer
      genralDrawer(
        context,
        () async {
          context.pushNamed('AddDeviceQRScanPravah');
        },
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PrimaryMeterWidget()),
          );
        },
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditProfileWidget()),
          );
        },
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const EditDevicePravahWidget()),
          );
        },
        () async {
          GoRouter.of(context).prepareAuthEvent();
          await signOut();

          context.goNamedAuth('LogInSignUp', mounted);
        },
      ),
      //debore drawer
      genralDrawer(
        context,
        () async {
          context.pushNamed('AddDeviceQRScanDebore');
        },
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PrimaryBorewellWidget(),
            ),
          );
        },
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditProfileWidget()),
          );
        },
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditDeviceDeboreWidget(),
            ),
          );
        },
        () async {
          GoRouter.of(context).prepareAuthEvent();
          await signOut();

          context.goNamedAuth('LogInSignUp', mounted);
        },
      ),
    ];
    List<Widget> pages = <Widget>[
      //starr container
      singleChildScrollViewContainer(
        date,
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 20),
          child: StreamBuilder<InternetConnectionStatus>(
            stream: InternetConnectionCheckerPlus().onStatusChange,
            builder: (context, connectionSnapshot) {
              final isConnected =
                  connectionSnapshot.data == InternetConnectionStatus.connected;

              return Stack(
                children: [
                  StreamBuilder<List<TankRecord>>(
                    stream: queryTankRecord(
                      parent: currentUserReference,
                      queryBuilder: (tankRecord) => tankRecord.where('TankKey',
                          isEqualTo: FFAppState().tankKey),
                      singleRecord: true,
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return spinKit();
                      }
                      List<TankRecord> containerTankRecordList = snapshot.data!;
                      // Return an empty Container when the item does not exist.
                      if (snapshot.data!.isEmpty) {
                        return selectDefaultAfterSpinkit(
                          "Default Tank is not selected. \nTap to select a default tank.",
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PrimaryTankWidget(),
                              ),
                            );
                          },
                        );
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
                                            waveAmplitude:
                                                3.00, //depth of curves
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
                                            child: isConnected
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        //Row 1
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              containerTankRecord!
                                                                  .tankName!, //replace with $tankname variable
                                                              // Text(text.length > 8 ? '${text.substring(0, 8)}...' : text); for input variable $text
                                                              style: GF
                                                                      .GoogleFonts
                                                                  .leagueSpartan(
                                                                fontSize: 30,
                                                                color: Color(
                                                                    0xFFFFFFFF),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                                                  defaultDeviceSpecsHeading(
                                                                      "Tank filled"),
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
                                                                  FutureBuilder<
                                                                      bool>(
                                                                    future: functions
                                                                        .checkActivity(
                                                                            containerTankRecord.tankKey!),
                                                                    builder: (BuildContext
                                                                            context,
                                                                        AsyncSnapshot<dynamic>
                                                                            snapshot) {
                                                                      if (snapshot
                                                                              .connectionState ==
                                                                          ConnectionState
                                                                              .waiting) {
                                                                        return CircularProgressIndicator(); // Display a loading indicator while waiting for the result
                                                                      } else if (snapshot
                                                                          .hasError) {
                                                                        return Text(
                                                                            'Error: ${snapshot.error}');
                                                                      } else {
                                                                        var value =
                                                                            snapshot.data;
                                                                        isActive =
                                                                            value;
                                                                        if (isActive ==
                                                                            true) {
                                                                          return FutureBuilder<
                                                                              dynamic>(
                                                                            future:
                                                                                functions.getStarrWaterLevel(containerTankRecord.tankKey!),
                                                                            builder:
                                                                                (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                return CircularProgressIndicator(); // Display a loading indicator while waiting for the result
                                                                              } else if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                var value = snapshot.data;
                                                                                _model.waterLevel = value;
                                                                                var filledP = (value != null) ? functions.convertToInt(functions.tankAPI(functions.calculateWaterAvailable(containerTankRecord!.length!, containerTankRecord!.breadth!, containerTankRecord!.height!, containerTankRecord!.radius!, _model.waterLevel, containerTankRecord!.isCuboid!), containerTankRecord!.capacity)).toString() + " %" : "N/A";
                                                                                return Text(
                                                                                  filledP,
                                                                                  style: defaultDeviceDataStyle,
                                                                                );
                                                                              }
                                                                            },
                                                                          );
                                                                        } else {
                                                                          return NAText();
                                                                        }
                                                                      }
                                                                    },
                                                                  ),

                                                                  /*isActive
                                                                        ? functions.convertToInt(functions.tankAPI(functions.calculateWaterAvailable(containerTankRecord!.length!, containerTankRecord!.breadth!, containerTankRecord!.height!, containerTankRecord!.radius!, _model.waterLevel, containerTankRecord!.isCuboid!), containerTankRecord!.capacity)).toString() +
                                                                            " %"
                                                                        : 'N/A', //replace with original data
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GF
                                                                            .GoogleFonts
                                                                        .leagueSpartan(
                                                                      fontSize:
                                                                          24,
                                                                      color: Color(
                                                                          0xFF91D9E9),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),*/
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
                                                                  defaultDeviceSpecsHeading(
                                                                      "Available for use"),
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
                                                                  FutureBuilder<
                                                                      bool>(
                                                                    future: functions
                                                                        .checkActivity(
                                                                            containerTankRecord.tankKey!),
                                                                    builder: (BuildContext
                                                                            context,
                                                                        AsyncSnapshot<dynamic>
                                                                            snapshot) {
                                                                      if (snapshot
                                                                              .connectionState ==
                                                                          ConnectionState
                                                                              .waiting) {
                                                                        return CircularProgressIndicator(); // Display a loading indicator while waiting for the result
                                                                      } else if (snapshot
                                                                          .hasError) {
                                                                        return Text(
                                                                            'Error: ${snapshot.error}');
                                                                      } else {
                                                                        var value =
                                                                            snapshot.data;
                                                                        isActive =
                                                                            value;
                                                                        if (isActive ==
                                                                            true) {
                                                                          return FutureBuilder<
                                                                              dynamic>(
                                                                            future:
                                                                                functions.getStarrWaterLevel(containerTankRecord.tankKey!),
                                                                            builder:
                                                                                (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                return CircularProgressIndicator(); // Display a loading indicator while waiting for the result
                                                                              } else if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                var value = snapshot.data;
                                                                                // print("Value = ${value}");
                                                                                _model.waterLevel = value;
                                                                                var availForUse = (value != null) ? functions.shortenNumber(functions.calculateWaterAvailable(containerTankRecord!.length!, containerTankRecord!.breadth!, containerTankRecord!.height!, containerTankRecord!.radius!, _model.waterLevel, containerTankRecord!.isCuboid!)) + "L" : "N/A";
                                                                                return Text(
                                                                                  availForUse,
                                                                                  style: defaultDeviceDataStyle,
                                                                                );
                                                                              }
                                                                            },
                                                                          );
                                                                        } else {
                                                                          return NAText();
                                                                        }
                                                                      }
                                                                    },
                                                                  ),

                                                                  /*Text(
                                                                    isActive
                                                                        ? functions.shortenNumber(functions.calculateWaterAvailable(
                                                                                containerTankRecord!.length!,
                                                                                containerTankRecord!.breadth!,
                                                                                containerTankRecord!.height!,
                                                                                containerTankRecord!.radius!,
                                                                                _model.waterLevel,
                                                                                containerTankRecord!.isCuboid!)) +
                                                                            "L"
                                                                        : 'N/A', //replace with oririginal data
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GF
                                                                            .GoogleFonts
                                                                        .leagueSpartan(
                                                                      fontSize:
                                                                          24,
                                                                      color: Color(
                                                                          0xFF91D9E9),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                */
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
                                                                  defaultDeviceSpecsHeading(
                                                                      "Total volume"),
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
                                                                      // isActive
                                                                      //     ? functions.shortenNumber(containerTankRecord!.capacity!) +
                                                                      //         'L'
                                                                      //     : 'N/A', //replace with oririginal data
                                                                      functions.shortenNumber(containerTankRecord!
                                                                              .capacity!) +
                                                                          'L',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          defaultDeviceDataStyle),
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
                                                                  defaultDeviceSpecsHeading(
                                                                      "Temperature"),

                                                                  /*Text(
                                                                    'Temperature',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GF
                                                                            .GoogleFonts
                                                                        .leagueSpartan(
                                                                      fontSize:
                                                                          16,
                                                                      color: Color(
                                                                          0xFFFFFFFF),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                                  ),
                                                                */
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 7,
                                                              ),
                                                              FutureBuilder<
                                                                      dynamic>(
                                                                  future: functions
                                                                      .getTemp(
                                                                          containerTankRecord
                                                                              .tankKey!),
                                                                  builder: (BuildContext
                                                                          context,
                                                                      AsyncSnapshot<
                                                                              dynamic>
                                                                          snapshot) {
                                                                    if (snapshot
                                                                            .connectionState ==
                                                                        ConnectionState
                                                                            .waiting) {
                                                                      return CircularProgressIndicator(); // Display a loading indicator while waiting for the result
                                                                    } else if (snapshot
                                                                        .hasError) {
                                                                      return Text(
                                                                          'Error: ${snapshot.error}');
                                                                    } else {
                                                                      var value =
                                                                          snapshot
                                                                              .data;
                                                                      // print("Balue from dashboard: ${value}");
                                                                      if (value !=
                                                                          null) {
                                                                        return Text(
                                                                          value.toString() +
                                                                              "°C",
                                                                          style:
                                                                              defaultDeviceDataStyle,
                                                                        );
                                                                      } else {
                                                                        return NAText();
                                                                      }
                                                                    }
                                                                  }),

                                                              /*Row(
                                                                //row3 column2 subrow2
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                      isActive
                                                                          ? _model.temperature.toString() +
                                                                              ' \u00B0C'
                                                                          : 'N/A', //replace with original data
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GF
                                                                              .GoogleFonts
                                                                          .leagueSpartan(
                                                                        fontSize:
                                                                            24,
                                                                        color: Color(
                                                                            0xFF91D9E9),
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      )),
                                                                ],
                                                              ),
                                                            */
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
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton.icon(
                                                            // <-- ElevatedButton
                                                            onPressed:
                                                                () async {
                                                              // isActive = await functions
                                                              //     .checkActivity(
                                                              //         FFAppState()
                                                              //             .tankKey);
                                                              // _model.waterLevel = await actions.callAPI(
                                                              //     functions.generateChannelID(
                                                              //         containerTankRecord!
                                                              //             .tankKey!),
                                                              //     functions.generateReadAPI(
                                                              //         containerTankRecord!
                                                              //             .tankKey!));
                                                              // _model.temperature = await callAPITemperature(
                                                              //     functions.generateChannelID(
                                                              //         containerTankRecord!
                                                              //             .tankKey!),
                                                              //     functions.generateReadAPI(
                                                              //         containerTankRecord!
                                                              //             .tankKey!));
                                                              isActive = true;
                                                              setState(() {});
                                                            },
                                                            icon: Icon(
                                                              CupertinoIcons
                                                                  .arrow_2_squarepath,
                                                              size: 16.0,
                                                              color: Color(
                                                                  0xFF0C0C0C),
                                                            ),
                                                            label: Text(
                                                              'Refresh',
                                                              style: GF
                                                                      .GoogleFonts
                                                                  .leagueSpartan(
                                                                fontSize: 16,
                                                                color: Color(
                                                                    0xFF0C0C0C),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7.5),
                                                              ),
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFC6DDDB),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        //Row 1
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              containerTankRecord!
                                                                  .tankName!, //replace with $tankname variable
                                                              // Text(text.length > 8 ? '${text.substring(0, 8)}...' : text); for input variable $text
                                                              style: GF
                                                                      .GoogleFonts
                                                                  .leagueSpartan(
                                                                fontSize: 30,
                                                                color: Color(
                                                                    0xFFFFFFFF),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                              overflow: TextOverflow
                                                                  .ellipsis, // new
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      emptyBox(),
                                                    ],
                                                  ),
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),

                                summaryDropDownBtnGeneralized(
                                  "Tank Summary",
                                  dropdownValueStarr,
                                  (String? newValue) {
                                    setState(() {
                                      dropdownValueStarr = newValue!;
                                    });
                                  },
                                ),
                                // graph - library to be updated as per the data
                                generalizedGraph(
                                  functions.getChartStarr(
                                      containerTankRecord!.tankKey,
                                      dropdownValueStarr,
                                      containerTankRecord!.length!,
                                      containerTankRecord!.breadth!,
                                      containerTankRecord!.height!,
                                      containerTankRecord!.radius!,
                                      containerTankRecord!.capacity!,
                                      containerTankRecord!.isCuboid!),
                                ),

                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 30, 20, 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      showAllDevicesButton(
                                        "Show All Devices",
                                        () async {
                                          if (!await InternetConnectionCheckerPlus()
                                              .hasConnection) {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Please connect to the internet'),
                                              ),
                                            );
                                          } else {
                                            context.pushNamed(
                                                'TankSummaryTesting');
                                          }
                                        },
                                      ),
                                      showAllDevicesButton(
                                        "Testing",
                                        () async {
                                          if (!await InternetConnectionCheckerPlus()
                                              .hasConnection) {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Please connect to the internet'),
                                              ),
                                            );
                                          } else {
                                            context.pushNamed('TankSummaryT2');
                                          }
                                        },
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
                ],
              );
            },
          ),
        ),
      ),
      //pravah container
      singleChildScrollViewContainer(
        date,
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 20),
          child: StreamBuilder<InternetConnectionStatus>(
            stream: InternetConnectionCheckerPlus().onStatusChange,
            builder: (context, connectionSnapshot) {
              final isConnected =
                  connectionSnapshot.data == InternetConnectionStatus.connected;
              return Stack(
                children: [
                  StreamBuilder<List<MeterRecord>>(
                      stream: queryMeterRecord(
                        parent: currentUserReference,
                        queryBuilder: (meterRecord) => meterRecord.where(
                            'MeterKey',
                            isEqualTo: FFAppState().meterKey),
                        singleRecord: true,
                      ),
                      builder: (context, meterSnapshot) {
                        if (!meterSnapshot.hasData) {
                          return spinKit();
                        }
                        List<MeterRecord> meterRecordList = meterSnapshot.data!;
                        if (meterSnapshot.data!.isEmpty) {
                          return selectDefaultAfterSpinkit(
                            "Default meter is not selected. \nTap to select a Default meter.",
                            () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PrimaryMeterWidget()));
                            },
                          );
                        }
                        final meterRecord = meterRecordList.isNotEmpty
                            ? meterRecordList.first
                            : null;
                        return Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 0, 0),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child:
                              Column(mainAxisSize: MainAxisSize.max, children: [
                            Column(mainAxisSize: MainAxisSize.max, children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 20, 15, 0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Color(0xded2ecf2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Positioned(
                                        child: Center(
                                          child: gauges.SfRadialGauge(
                                            animationDuration: 2000,
                                            enableLoadingAnimation: true,
                                            axes: <gauges.RadialAxis>[
                                              gauges.RadialAxis(
                                                minimum: 0,
                                                maximum: 100,
                                                radiusFactor: 1,
                                                minorTicksPerInterval: 5,
                                                startAngle: 110,
                                                endAngle: 70,
                                                showLabels: false,
                                                axisLineStyle:
                                                    gauges.AxisLineStyle(
                                                  thickness: 0.1,
                                                  thicknessUnit: gauges
                                                      .GaugeSizeUnit.factor,
                                                  cornerStyle: gauges
                                                      .CornerStyle.bothCurve,
                                                  color: Color(0xFF0C0C0C),
                                                ),
                                                majorTickStyle:
                                                    gauges.MajorTickStyle(
                                                        length: 0.075,
                                                        lengthUnit: gauges
                                                            .GaugeSizeUnit
                                                            .factor,
                                                        color: Color(0xFF0c0c0c)
                                                        // color: Color(0xb1bbe5ef),
                                                        ),
                                                minorTickStyle:
                                                    gauges.MinorTickStyle(
                                                  // color: Color(0x7bbbe5ef),
                                                  color: Color(0xFF0c0c0c),
                                                  length: 0.05,
                                                  lengthUnit: gauges
                                                      .GaugeSizeUnit.factor,
                                                ),
                                                pointers: [
                                                  gauges.RangePointer(
                                                    width: 0.087,
                                                    sizeUnit: gauges
                                                        .GaugeSizeUnit.factor,
                                                    value: _pointerValue,
                                                    cornerStyle: gauges
                                                        .CornerStyle.bothCurve,
                                                    color: Color(0xff37a8d4),
                                                  ),
                                                  gauges.NeedlePointer(
                                                    value: _pointerValue,
                                                    needleStartWidth: 1,
                                                    needleEndWidth: 5,
                                                    needleLength: 8,
                                                    needleColor:
                                                        Color(0x770c0c0c),
                                                    knobStyle: gauges.KnobStyle(
                                                      knobRadius: 5,
                                                      sizeUnit: gauges
                                                          .GaugeSizeUnit
                                                          .logicalPixel,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        child: Center(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            decoration: BoxDecoration(
                                              color: Color(0xd80c0c0c),
                                              shape: BoxShape.circle,
                                            ),
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    50, 0, 50, 0),
                                            child: isConnected
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Row(
                                                        //Row 1
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              meterRecord!
                                                                  .meterName!,
                                                              // Text(text.length > 8 ? '${text.substring(0, 8)}...' : text); for input variable $text
                                                              style: GF
                                                                      .GoogleFonts
                                                                  .leagueSpartan(
                                                                fontSize: 30,
                                                                color: Color(
                                                                    0xFFFFFFFF),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                                      // isActivePravah
                                                      //     ?
                                                      // : Text("N/A"),
                                                      FutureBuilder<
                                                          Map<String,
                                                              dynamic>?>(
                                                        future:
                                                            fetchMeterDataForUser(
                                                                meterRecord
                                                                    .meterKey!),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return const CircularProgressIndicator();
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return const Text(
                                                                'Error fetching data');
                                                          } else if (!snapshot
                                                                  .hasData ||
                                                              snapshot.data ==
                                                                  null) {
                                                            return const Text(
                                                                'No data available');
                                                          }

                                                          var meterData =
                                                              snapshot.data!;
                                                          var reading =
                                                              meterData[
                                                                  'Reading'];
                                                          var flowRate =
                                                              meterData[
                                                                  'FlowRate'];
                                                          bool isMeterActive =
                                                              reading == "N/A"
                                                                  ? false
                                                                  : true;
                                                          Timestamp ts =
                                                              meterData[
                                                                  'Timestamp'];
                                                          DateTime dt =
                                                              ts.toDate();
                                                          return Row(
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
                                                                      defaultDeviceSpecsHeading(
                                                                          "Reading"),
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
                                                                        reading,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            defaultDeviceNADataStyle,
                                                                      ),
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
                                                                        "kL",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            defaultDeviceNADataStyle,
                                                                      ),
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
                                                                      defaultDeviceSpecsHeading(
                                                                          "Flow Rate"),
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
                                                                        flowRate,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            defaultDeviceNADataStyle,
                                                                      ),
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
                                                                        "ml/s",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            defaultDeviceNADataStyle,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),

                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        //Row4
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton.icon(
                                                            // <-- ElevatedButton
                                                            onPressed:
                                                                () async {
                                                              setState(() {});
                                                            },
                                                            icon: Icon(
                                                              CupertinoIcons
                                                                  .arrow_2_squarepath,
                                                              size: 16.0,
                                                              color: Color(
                                                                  0xFF0C0C0C),
                                                            ),
                                                            label: Text(
                                                              'Refresh',
                                                              style: GF
                                                                      .GoogleFonts
                                                                  .leagueSpartan(
                                                                fontSize: 16,
                                                                color: Color(
                                                                    0xFF0C0C0C),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7.5),
                                                              ),
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFC6DDDB),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          meterRecord!
                                                              .meterName!,
                                                          // Text(text.length > 8 ? '${text.substring(0, 8)}...' : text); for input variable $text
                                                          style: GF.GoogleFonts
                                                              .leagueSpartan(
                                                            fontSize: 30,
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis, // new
                                                        ),
                                                      ),
                                                      emptyBox(),
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Total Flow Chart
                              summaryDropDownBtnGeneralized(
                                "Total Flow Summary",
                                dropdownValuePravahTotal,
                                (String? newValue) {
                                  setState(() {
                                    dropdownValuePravahTotal = newValue!;
                                  });
                                },
                              ),
                              // graph - library to be updated as per the data
                              generalizedGraph(
                                functions.getChartPravahTotal(
                                    meterRecord!.meterKey!,
                                    dropdownValuePravahTotal),
                              ),

                              // Flow Rate Chart
                              summaryDropDownBtnGeneralized(
                                "Flow Rate Summary",
                                dropdownValuePravahRate,
                                (String? newValue) {
                                  setState(() {
                                    dropdownValuePravahRate = newValue!;
                                  });
                                },
                              ),

                              // graph - library to be updated as per the data
                              generalizedGraph(
                                functions.getChartPravahRate(
                                    meterRecord.meterKey!,
                                    dropdownValuePravahRate),
                              ),

                              //Show all pravah dev. btn
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 30, 20, 30),
                                child: Column(
                                  children: [
                                    showAllDevicesButton(
                                      "Show All Devices",
                                      () async {
                                        if (!await InternetConnectionCheckerPlus()
                                            .hasConnection) {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Please connect to the internet'),
                                            ),
                                          );
                                        } else {
                                          context
                                              .pushNamed('MeterSummaryTesting');
                                        }
                                      },
                                    ),
                                    showAllDevicesButton(
                                      "Testing",
                                      () async {
                                        if (!await InternetConnectionCheckerPlus()
                                            .hasConnection) {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Please connect to the internet'),
                                            ),
                                          );
                                        } else {
                                          context.pushNamed('MeterSummaryT2');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ]),
                        );
                      }),
                ],
              );
            },
          ),
        ),
      ),
      //debore container
      singleChildScrollViewContainer(
        date,
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 20),
          child: StreamBuilder<InternetConnectionStatus>(
            stream: InternetConnectionCheckerPlus().onStatusChange,
            builder: (context, connectionSnapshot) {
              final isConnected =
                  connectionSnapshot.data == InternetConnectionStatus.connected;

              return Stack(
                children: [
                  StreamBuilder<List<BorewellRecord>>(
                    stream: queryBorewellRecord(
                      parent: currentUserReference,
                      queryBuilder: (borewellRecord) => borewellRecord.where(
                          'BorewellKey',
                          isEqualTo: FFAppState().borewellKey),
                      singleRecord: true,
                    ),
                    builder: (context, borewellSnapshot) {
                      if (!borewellSnapshot.hasData) {
                        return spinKit();
                      }
                      List<BorewellRecord> containerBorewellRecordList =
                          borewellSnapshot.data!;

                      if (borewellSnapshot.data!.isEmpty) {
                        return selectDefaultAfterSpinkit(
                          "Click to select a \n Default borewell.",
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PrimaryBorewellWidget(),
                              ),
                            );
                          },
                        );
                      }
                      final containerBorewellRecord =
                          containerBorewellRecordList.isNotEmpty
                              ? containerBorewellRecordList.first
                              : null;

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
                                SizedBox(
                                  height: 50,
                                ),
                                isConnected
                                    ? Stack(
                                        children: [
                                          //Image
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
                                                    color: Color.fromARGB(
                                                        192, 80, 63, 63),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(50, 0, 50, 0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      //device name
                                                      defaultDeviceName(
                                                          containerBorewellRecord!
                                                              .borewellName!),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      //Text
                                                      defaultDeviceSpecsHeading(
                                                          "Waterlevel from ground"),
                                                      SizedBox(
                                                        height: 7,
                                                      ),
                                                      isActiveDebore
                                                          ? FutureBuilder<
                                                              Map<String,
                                                                  dynamic>?>(
                                                              future: fetchBorewellDataForUser(
                                                                  containerBorewellRecord
                                                                      .borewellKey!),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  return const CircularProgressIndicator();
                                                                } else if (snapshot
                                                                    .hasError) {
                                                                  return const Text(
                                                                      'Error fetching data');
                                                                } else if (!snapshot
                                                                        .hasData ||
                                                                    snapshot.data ==
                                                                        null) {
                                                                  return const Text(
                                                                      'No data available');
                                                                }

                                                                var borewellData =
                                                                    snapshot
                                                                        .data!;
                                                                var waterLevel =
                                                                    borewellData[
                                                                            'WaterLevelGround'] +
                                                                        " m";

                                                                return Text(
                                                                  waterLevel,
                                                                  style:
                                                                      defaultDeviceDataStyle,
                                                                );
                                                              },
                                                            )
                                                          : Text(
                                                              "N/A",
                                                              style:
                                                                  defaultDeviceNADataStyle,
                                                            ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      refreshButton(() async {
                                                        setState(() {});
                                                      }),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Stack(
                                        children: [
                                          //Image
                                          badNetworkCircle(
                                              context,
                                              containerBorewellRecord!
                                                  .borewellName!),
                                        ],
                                      ),

                                //Graph filter selector
                                summaryDropDownBtnGeneralized(
                                  "Borewell summary",
                                  dropdownValueDebore,
                                  (String? newValue) {
                                    setState(() {
                                      dropdownValueDebore = newValue!;
                                    });
                                  },
                                ),
                                //Generalized graph
                                generalizedGraph(
                                  functions.getChartDebore(
                                      containerBorewellRecord!.borewellKey,
                                      dropdownValueDebore),
                                ),

                                //show all devices btn
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 30, 20, 30),
                                  child: Column(
                                    children: [
                                      showAllDevicesButton("Show All Devices",
                                          () async {
                                        if (!await InternetConnectionCheckerPlus()
                                            .hasConnection) {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Please connect to the internet'),
                                            ),
                                          );
                                        } else {
                                          context.pushNamed(
                                              'BorewellSummaryTesting');
                                        }
                                      }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      showAllDevicesButton("Testing", () async {
                                        if (!await InternetConnectionCheckerPlus()
                                            .hasConnection) {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Please connect to the internet'),
                                            ),
                                          );
                                        } else {
                                          context
                                              .pushNamed('BorewellSummaryT2');
                                        }
                                      }),
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
                  // if (!isConnected)
                  //   Positioned(
                  //     left: 0,
                  //     right: 0,
                  //     bottom: 0,
                  //     child: NetworkConnectivityWidget(),
                  //   ),
                ],
              );
            },
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Color(0xFF0C0C0C),
      endDrawer: drawers.elementAt(selectedindex),
      appBar: genAppBar("Hydrow Verse"),
      //It will select the Starr or Pravah dashboard based of selectedindex value
      // body: pages.elementAt(selectedindex),
      body: StreamBuilder<bool>(
        stream: functions.checkInternetConnection(),
        builder: (context, snapshot) {
          return Stack(
            children: [
              pages.elementAt(selectedindex),
              if (_isLoading)
                const Opacity(
                  opacity: 0.5,
                  child: ModalBarrier(
                    color: Colors.black,
                    dismissible: false,
                  ),
                ),
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              if (snapshot.hasData && !snapshot.data!)
                // Positioned(
                //   bottom: 0, // This anchors the widget to the bottom
                //   left: 0, // Make sure the widget is stretched across the width
                //   right: 0,
                //   child: NetworkConnectivityWidget(),
                // ),
                NetworkConnectivityWidget(),
            ],
          );
        },
      ),

      //Bottom navigation bar of Debore, Starr and Pravah
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF112025),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.invert_colors,
              // color: Colors.blueAccent,
            ),
            label: 'Starr',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.show_chart),
            label: 'Pravah',
          ),
          //debore
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.align_horizontal_center),
            label: 'Debore',
          ),
        ],
        currentIndex: selectedindex,
        selectedLabelStyle: GF.GoogleFonts.leagueSpartan(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        unselectedLabelStyle: GF.GoogleFonts.leagueSpartan(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        unselectedItemColor: Colors.white,
        selectedItemColor: Color.fromARGB(255, 0, 197, 241),
        onTap: onTapItem,
      ),
    );
  }

//Switching of index value upon clicking
  void onTapItem(int index) {
    setState(() {
      selectedindex = index;
    });
  }
}

class AddDevices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Drawer());
  }
}
