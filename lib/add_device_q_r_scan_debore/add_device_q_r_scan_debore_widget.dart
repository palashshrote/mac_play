import 'package:flutter/cupertino.dart';
import 'package:hydrow/add_device_q_r_scan_debore/add_device_q_r_scan_debore_model.dart';
import 'package:hydrow/auth/auth_util.dart';
import 'package:hydrow/backend/api_requests/checking.dart';
import 'package:hydrow/backend/api_requests/register_device.dart';
import 'package:hydrow/backend/backend.dart';
import 'package:hydrow/backend/schema/borewell_record.dart';
import 'package:hydrow/constants/k_add_device_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'add_device_q_r_scan_debore_model.dart';
export 'add_device_q_r_scan_debore_model.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class AddDeviceQRScanDeboreWidget extends StatefulWidget {
  const AddDeviceQRScanDeboreWidget({super.key});

  @override
  State<AddDeviceQRScanDeboreWidget> createState() =>
      _AddDeviceQRScanDeboreWidgetState();
}

class _AddDeviceQRScanDeboreWidgetState
    extends State<AddDeviceQRScanDeboreWidget> with TickerProviderStateMixin {
  late AddDeviceQRScanDeboreModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeIn,
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
    _model = createModel(context, () => AddDeviceQRScanDeboreModel());

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
      appBar: AppBar(
        backgroundColor: Color(0xFF112025),
        title: Text(
          'Add Device - QR Scan',
          style: GF.GoogleFonts.leagueSpartan(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.normal,
            fontSize: 20, //edited
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 250, 10, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0x33536765),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 2.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(20.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 20, 10, 30),
                                child: Text(
                                  "Scan Dbore QR to proceed futher",
                                  textAlign: TextAlign.center,
                                  style: scanQrTextStyle,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 25.0),
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  if (await InternetConnectionCheckerPlus()
                                      .hasConnection) {
                                    try {
                                      _model.qROutput =
                                          await FlutterBarcodeScanner
                                              .scanBarcode(
                                        '#C62828', // scanning line color
                                        'Cancel', // cancel button text
                                        true, // whether to show the flash icon
                                        ScanMode.QR,
                                      );
                                    } catch (e) {
                                      // print(e.toString());
                                    }
                                    if (functions.qrDebore(_model.qROutput)) {
                                      List<String>? parts =
                                          _model.qROutput?.split('&');
                                      String cId = parts![0];
                                      String readApi = parts[1];

                                      if (!await deviceAlreadyRegistered(
                                          cId, "Borewell")) {
                                        //register code
                                        print(
                                            "Device not registered, navigating to register page");

                                     
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterDevice(
                                              deviceType: "Borewell",
                                              qrData: _model.qROutput,
                                            ),
                                          ),
                                        );

                                        if (result == null ||
                                            result != 'success') {
                                          // Handle the case where registration was not successful
                                          print(
                                              'Registration was not completed');
                                          return; // Stop further execution if registration failed
                                        }

                                        // Registration was successful, now proceed with the rest of the logic
                                        print(
                                            "Registration successful, resuming to add device");
                                      }
                                      //  else {
                                      //check if device already added by user
                                      bool devicePresent =
                                          await functions.deviceAlreadyPresent2(
                                              currentUserReference!,
                                              _model.qROutput,
                                              "borewell");

                                      if (devicePresent) {
                                        print("No need to add");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Dbore device already added.'),
                                          ),
                                        );
                                        return;
                                      } else {
                                        print("Need to add");
                                        context.pushNamed(
                                          'AddDeviceDebore',
                                          queryParams: {
                                            'borewellKey': serializeParam(
                                              _model.qROutput,
                                              ParamType.String,
                                            ),
                                          }.withoutNulls,
                                        );
                                      }

                                      // }
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20.0), // Add curvature
                                            ),
                                            title: Text('E R R O R'),
                                            content: Text(
                                                'QR wasn\'t scanned successfully. Try again and please check that you are scanning the right QR.'),
                                            actions: [
                                              actionBtnWidget(
                                                "O K",
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      context.pop();
                                      context
                                          .pushNamed('AddDeviceQRScanDebore');
                                    }
                                    setState(() {});
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Please check you internet connectivity to proceed further."),
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(
                                  CupertinoIcons.qrcode_viewfinder,
                                  size: 18.0,
                                  color: Color(0xFF0C0C0C),
                                ),
                                label: Text(
                                  'Scan QR',
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}

extension on Map<String, Object?> {
  get withoutNulls => null;
}
