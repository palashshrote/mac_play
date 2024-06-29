import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'edit_profile_model.dart';
export 'edit_profile_model.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({Key? key}) : super(key: key);

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget>
    with TickerProviderStateMixin {
  late EditProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

// Fade effect while opening the page.
  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
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
    _model = createModel(context, () => EditProfileModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.lockOrientation();
    });

    _model.textController1 ??=
        TextEditingController(text: currentUserDisplayName);
    _model.textController2 ??= TextEditingController(text: currentPhoneNumber);
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
// Main designing block of the page.
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0x33536765),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 20.0, 20.0, 20.0),
                                  child: Text(
                                    'Email ID:',
                                    style: GF.GoogleFonts.leagueSpartan(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 22, //edited
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                // Will show the current user email.
                                Text(
                                  currentUserEmail,
                                  style: GF.GoogleFonts.leagueSpartan(
                                    color: Color(0xFFD9D9D9),
                                    fontSize: 18, //edited
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            // Fetching, displaying and editing of the name of the user.
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  30.0, 20.0, 30.0, 20.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => TextFormField(
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
                            ),

                            // Fetching, displaying and editing of the phone number.
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  30.0, 20.0, 30.0, 20.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => TextFormField(
                                  controller: _model.textController2,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFF0c0c0c),
                                    hintText: 'Phone Number',
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
                            ),
                          ],
                        ),

                        // BUTTON for saving the changes.
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 30.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              final usersUpdateData = createUsersRecordData(
                                displayName: _model.textController1.text,
                                phoneNumber: _model.textController2.text,
                              );
                              await currentUserReference!
                                  .update(usersUpdateData);
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Saved'),
                                    content:
                                        Text('Changes saved successfully.'),
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
                              context.pushNamed('Dashboard');
                            },
                            child: Text(
                              'Save Changes',
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
                                    20, 17, 20, 17)),
                          ),
                        ),
                      ],
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation']!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
