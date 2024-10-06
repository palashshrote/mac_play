import 'package:hydrow/backend/api_requests/register_device.dart';

import '/auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'add_device_model.dart';
export 'add_device_model.dart';

class AddDeviceWidget extends StatefulWidget {
  const AddDeviceWidget({
    Key? key,
    this.tankKey,
    this.isCuboid,
  }) : super(key: key);

  final String? tankKey;
  final bool? isCuboid;

  @override
  _AddDeviceWidgetState createState() => _AddDeviceWidgetState();
}

class _AddDeviceWidgetState extends State<AddDeviceWidget>
    with TickerProviderStateMixin {
  late AddDeviceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

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
  bool _isButtonDisabled = false;

  void _onButtonTap() {
    setState(() {
      _isButtonDisabled = true; // Disable the button when tapped
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isButtonDisabled = false; // Re-enable the button after 3 seconds
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddDeviceModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.lockOrientation();
    });

    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
    _model.textController3 ??= TextEditingController();
    _model.textController4 ??= TextEditingController();
    _model.textController5 ??= TextEditingController();
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF0C0C0C),
      appBar: AppBar(
        backgroundColor: Color(0xFF112025),
        title: Text(
          'Add Starr Device',
          style: GF.GoogleFonts.leagueSpartan(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.normal,
            fontSize: 22, //edited
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
              children: [
                Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0x33536765),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 15.0, 15.0, 15.0),
                                  child: Text(
                                    'Tank Type: ' +
                                        functions.isCuboid(widget.isCuboid!),
                                    style: GF.GoogleFonts.leagueSpartan(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 22, //edited
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //1 name
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 30.0),
                              child: TextFormField(
                                controller: _model.textController1,
                                autofocus: true,
                                obscureText: false,
                                decoration: addDevInpDec("Name"),
                                style: GF.GoogleFonts.leagueSpartan(
                                  color: Color(0xFFFFFFFF),
                                ),
                                validator: _model.textController1Validator
                                    .asValidator(context),
                              ),
                            ),
                            if (widget.isCuboid ?? true)
                              //2 length
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 30.0),
                                child: TextFormField(
                                  controller: _model.textController2,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: addDevInpDec("Length (in cm)"),
                                  style: GF.GoogleFonts.leagueSpartan(
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: true, decimal: true),
                                  validator: _model.textController2Validator
                                      .asValidator(context),
                                ),
                              ),
                            if (widget.isCuboid ?? true)
                              //3 breadth
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 30.0),
                                child: TextFormField(
                                  controller: _model.textController3,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: addDevInpDec("Breadth (in cm)"),
                                  style: GF.GoogleFonts.leagueSpartan(
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: true, decimal: true),
                                  validator: _model.textController3Validator
                                      .asValidator(context),
                                ),
                              ),
                            // 4 height
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 30.0),
                              child: TextFormField(
                                controller: _model.textController4,
                                autofocus: true,
                                obscureText: false,
                                decoration: addDevInpDec("Height (in cm)"),
                                style: GF.GoogleFonts.leagueSpartan(
                                  color: Color(0xFFFFFFFF),
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                validator: _model.textController4Validator
                                    .asValidator(context),
                              ),
                            ),
                            if (!widget.isCuboid!)
                              //5 radius
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 30.0),
                                child: TextFormField(
                                  controller: _model.textController5,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: addDevInpDec("Radius (in cm)"),
                                  style: GF.GoogleFonts.leagueSpartan(
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: _model.textController5Validator
                                      .asValidator(context),
                                ),
                              ),
                            //Calculating volume
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 30.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 15.0, 15.0, 15.0),
                                    child: Text(
                                      'Volume (in L): ' +
                                          functions.shortenNumber(
                                            functions.calculateVolume(
                                                widget.isCuboid!,
                                                _model.textController2.text,
                                                _model.textController3.text,
                                                _model.textController4.text,
                                                _model.textController5.text),
                                          ) +
                                          "L",
                                      style: GF.GoogleFonts.leagueSpartan(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 22, //edited
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 30.0),
                              child: _isButtonDisabled
                                  ? disabledBtn("Save")
                                  : ElevatedButton(
                                      onPressed: () async {
                                        _onButtonTap();
                                        var confirmDialogResponse =
                                            await showDialog<bool>(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20.0), // Add curvature
                                                      ),
                                                      // title: Text('Register'),
                                                      content: Text.rich(
                                                        TextSpan(
                                                          text:
                                                              'Are you sure to name this device as ', // Regular text
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: _model
                                                                  .textController1
                                                                  .text, // Bold text for deviceName
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const TextSpan(
                                                              text:
                                                                  ' ?', // Regular text after deviceName
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: [
                                                        actionBtnWidget(
                                                          'C A N C E L',
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext,
                                                                  false),
                                                        ),
                                                        actionBtnWidget(
                                                          'C O N F I R M',
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext,
                                                                  true),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ) ??
                                                false;

                                        if (!confirmDialogResponse) {
                                          return;
                                        }

                                        if (confirmDialogResponse) {
                                          if (_model.formKey.currentState ==
                                                  null ||
                                              !_model.formKey.currentState!
                                                  .validate()) {
                                            return;
                                          }

                                          final tankCreateData =
                                              createTankRecordData(
                                            tankName:
                                                _model.textController1.text,
                                            length: _model.textController2.text,
                                            breadth:
                                                _model.textController3.text,
                                            height: _model.textController4.text,
                                            radius: _model.textController5.text,
                                            tankKey: widget.tankKey,
                                            isCuboid: widget.isCuboid,
                                            capacity: functions.calculateVolume(
                                                widget.isCuboid!,
                                                _model.textController2.text,
                                                _model.textController3.text,
                                                _model.textController4.text,
                                                _model.textController5.text),
                                          );
                                          await TankRecord.createDoc(
                                                  currentUserReference!)
                                              .set(tankCreateData);

                                          //.call method responsible for adding starr device
                                          await AddDeviceCall.call(
                                            field1: _model.textController1.text,
                                            field2: _model.textController3.text,
                                            field3: _model.textController4.text,
                                            field4: _model.textController2.text,
                                            field5: _model.textController5.text,
                                            apiKey: functions
                                                .generateWrite(widget.tankKey!),
                                          );

                                          final usersUpdateData = {
                                            'keyList': FieldValue.arrayUnion(
                                                [widget.tankKey]),
                                          };
                                          await currentUserReference!
                                              .update(usersUpdateData);
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return customAlertDialog(
                                                "S U C C E S S",
                                                'Device added successfully',
                                                [
                                                  actionBtnWidget(
                                                    "O K",
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          alertDialogContext);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );

                                          // context.pushNamed('Dashboard');
                                          //THREE TIMES to reach back to the hompage
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(
                                        'Save',
                                        style: GF.GoogleFonts.leagueSpartan(
                                          fontSize: 20,
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!),
        ),
      ),
    );
  }
}
