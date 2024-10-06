import 'package:hydrow/backend/api_requests/register_device.dart';
import 'package:hydrow/backend/schema/borewell_record.dart';
import 'package:hydrow/constants/k_add_device_widget.dart';

import '/auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'add_device_debore_model.dart';
export 'add_device_debore_model.dart';

class AddDeviceDeboreWidget extends StatefulWidget {
  final String? borewellKey;
  const AddDeviceDeboreWidget({super.key, this.borewellKey});

  @override
  State<AddDeviceDeboreWidget> createState() => _AddDeviceDeboreWidgetState();
}

class _AddDeviceDeboreWidgetState extends State<AddDeviceDeboreWidget>
    with TickerProviderStateMixin {
  late AddDeviceDeboreModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
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
    // TODO: implement initState
    super.initState();
    _model = createModel(context, () => AddDeviceDeboreModel());
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.lockOrientation();
    });
    _model.textController1 ??= TextEditingController();
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
          "Add Debore Device",
          style: appBarStyle,
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
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
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
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 30.0),
                              child: _isButtonDisabled
                                  ? disabledBtn("Save")
                                  : ElevatedButton(
                                      onPressed: () async {
                                        // print("Onpressed tapped");
                                        // toggleBtnState();
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

                                        if (_model.formKey.currentState ==
                                                null ||
                                            !_model.formKey.currentState!
                                                .validate()) {
                                          // print("Form not valid");
                                          return;
                                        }
                                        // toggleBtnState();

                                        final borewellCreateData =
                                            createBorewellRecordData(
                                          borewellName:
                                              _model.textController1.text,
                                          borewellKey: widget.borewellKey,
                                        );
                                        // print(borewellCreateData);
                                        await BorewellRecord.createDoc(
                                                currentUserReference!)
                                            .set(borewellCreateData);
                                        await AddDeviceDeboreCall.call(
                                          field2: _model.textController1.text,
                                          apiKey: functions.generateWrite(
                                              widget.borewellKey!),
                                        );
                                        final usersUpdateData = {
                                          'borewellKeyList':
                                              FieldValue.arrayUnion(
                                                  [widget.borewellKey]),
                                        };
                                        await currentUserReference!
                                            .update(usersUpdateData);
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0), // Add curvature
                                              ),
                                              title: Text("S U C C E S S"),
                                              content: Text(
                                                  "Device added successfully"),
                                              actions: [
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
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
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
          ),
        ),
      ),
    );
  }
}
