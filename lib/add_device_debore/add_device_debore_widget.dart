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
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFF0c0c0c),
                                  hintText: 'Name',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontFamily: 'Spartan',
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
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
                              child: ElevatedButton(
                                onPressed: () async {
                                  print("Onpressed tapped");

                                  if (_model.formKey.currentState == null ||
                                      !_model.formKey.currentState!
                                          .validate()) {
                                    print("Form not valid");
                                    return;
                                  }

                                  final borewellCreateData =
                                      createBorewellRecordData(
                                    borewellName: _model.textController1.text,
                                    borewellKey: widget.borewellKey,
                                  );
                                  print(borewellCreateData);
                                  await BorewellRecord.createDoc(
                                          currentUserReference!)
                                      .set(borewellCreateData);
                                  await AddDeviceDeboreCall.call(
                                    field2: _model.textController1.text,
                                    apiKey: functions
                                        .generateWrite(widget.borewellKey!),
                                  );
                                  final usersUpdateData = {
                                    'borewellKeyList': FieldValue.arrayUnion(
                                        [widget.borewellKey]),
                                  };
                                  await currentUserReference!
                                      .update(usersUpdateData);
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: Text("Success"),
                                        content:
                                            Text("Device added successfully"),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('OK'),
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
                                      borderRadius: BorderRadius.circular(7.5),
                                    ),
                                    backgroundColor: Color(0xFFC6DDDB),
                                    padding: EdgeInsetsDirectional.fromSTEB(
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
