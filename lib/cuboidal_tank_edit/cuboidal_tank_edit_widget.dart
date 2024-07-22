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
import 'cuboidal_tank_edit_model.dart';
export 'cuboidal_tank_edit_model.dart';

class CuboidalTankEditWidget extends StatefulWidget {
  const CuboidalTankEditWidget({
    Key? key,
    this.tankReference,
  }) : super(key: key);

  final TankRecord? tankReference;

  @override
  _CuboidalTankEditWidgetState createState() => _CuboidalTankEditWidgetState();
}

class _CuboidalTankEditWidgetState extends State<CuboidalTankEditWidget>
    with TickerProviderStateMixin {
  late CuboidalTankEditModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

// Fade effect while opening the page.
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
    _model = createModel(context, () => CuboidalTankEditModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.lockOrientation();
    });

    _model.textController1 ??=
        TextEditingController(text: widget.tankReference!.tankName);
    _model.textController2 ??=
        TextEditingController(text: widget.tankReference!.length);
    _model.textController3 ??=
        TextEditingController(text: widget.tankReference!.breadth);
    _model.textController4 ??=
        TextEditingController(text: widget.tankReference!.height);
    _model.textController5 ??=
        TextEditingController(text: widget.tankReference!.radius);
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

// main designing and functioning block of the page.
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF0C0C0C),
      appBar: AppBar(
        backgroundColor: Color(0xFF112025),
        title: Text(
          'Edit Device',
          style: GF.GoogleFonts.leagueSpartan(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.normal,
            fontSize: 22, //edited
          ),
        ),
        centerTitle: true,
      ),

      // Main body of the page.
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
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

                            // shows the default tank type which was selected.
                            child: Text(
                              'Tank Type: ' +
                                  functions.isCuboid(
                                      widget.tankReference!.isCuboid!),
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

                // Fields that can be edited.
                Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 30.0),
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
                        // Dimensions for the CUBOID tank to be edited.
                        if (widget.tankReference!.isCuboid ?? true)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 30.0),
                            child: TextFormField(
                              controller: _model.textController2,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF0c0c0c),
                                hintText: 'Length (in cm)',
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
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              validator: _model.textController2Validator
                                  .asValidator(context),
                            ),
                          ),
                        if (widget.tankReference!.isCuboid ?? true)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 30.0),
                            child: TextFormField(
                              controller: _model.textController3,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF0c0c0c),
                                hintText: 'Breadth (in cm)',
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
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              validator: _model.textController3Validator
                                  .asValidator(context),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 30.0),
                          child: TextFormField(
                            controller: _model.textController4,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF0c0c0c),
                              hintText: 'Height (in cm)',
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
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            validator: _model.textController4Validator
                                .asValidator(context),
                          ),
                        ),

                        // Editing radius for the tank type - CYLINDER.
                        if (!widget.tankReference!.isCuboid!)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 30.0),
                            child: TextFormField(
                              controller: _model.textController5,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF0c0c0c),
                                hintText: 'Radius (in cm)',
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
                              keyboardType: TextInputType.number,
                              validator: _model.textController5Validator
                                  .asValidator(context),
                            ),
                          ),

                        // Represenation of the volume of water in litres.
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
                                      functions
                                          .calculateVolume(
                                              widget.tankReference!.isCuboid!,
                                              _model.textController2.text,
                                              _model.textController3.text,
                                              _model.textController4.text,
                                              _model.textController5.text)
                                          .toString(),
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
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_model.formKey.currentState == null ||
                                  !_model.formKey.currentState!.validate()) {
                                return;
                              }

                              // Sending the updated data to backend.
                              final tankUpdateData = createTankRecordData(
                                tankName: _model.textController1.text,
                                tankKey: widget.tankReference!.tankKey,
                                length: _model.textController2.text,
                                breadth: _model.textController3.text,
                                height: _model.textController4.text,
                                radius: _model.textController5.text,
                                isCuboid: widget.tankReference!.isCuboid,
                                capacity: functions.calculateVolume(
                                    widget.tankReference!.isCuboid!,
                                    _model.textController2.text,
                                    _model.textController3.text,
                                    _model.textController4.text,
                                    _model.textController5.text),
                              );
                              await widget.tankReference!.reference
                                  .update(tankUpdateData);
                              await AddDeviceCall.call(
                                apiKey: functions.generateWrite(
                                    widget.tankReference!.tankKey!),
                                field1: _model.textController1.text,
                                field2: _model.textController3.text,
                                field3: _model.textController4.text,
                                field4: _model.textController2.text,
                                field5: _model.textController5.text,
                              );
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Succcess'),
                                    content: Text('Changes saved successfully'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
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
                            },
                            child: Text(
                              'Save Changes',
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
                ),
              ],
            ),
          ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!),
        ),
      ),
    );
  }
}
