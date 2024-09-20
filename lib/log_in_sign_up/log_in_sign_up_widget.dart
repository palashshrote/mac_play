import 'package:hydrow/services/auth_service.dart';
import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'log_in_sign_up_model.dart';
export 'log_in_sign_up_model.dart';
import 'signUp.dart';
import 'package:hydrow/dashboard/dashboard_widget.dart';

class LogInSignUpWidget extends StatefulWidget {
  const LogInSignUpWidget({Key? key}) : super(key: key);

  @override
  _LogInSignUpWidgetState createState() => _LogInSignUpWidgetState();
}

class _LogInSignUpWidgetState extends State<LogInSignUpWidget>
    with TickerProviderStateMixin {
  late LogInSignUpModel _model;
  bool _isPasswordVisible = false;
  void _tooglePassowrdVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

// Fade effect while opening the page.
  final animationsMap = {
    'tabBarOnPageLoadAnimation': AnimationInfo(
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
    super.initState();
    _model = createModel(context, () => LogInSignUpModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.lockOrientation();
    });

// Declaring different variables for different fields.
    _model.logInEmailController ??= TextEditingController();
    _model.logInPasswordController ??= TextEditingController();
    _model.userNameController ??= TextEditingController();
    _model.emailController ??= TextEditingController();
    _model.phoneNumberController ??= TextEditingController();
    _model.signUpPasswordController ??= TextEditingController();
    _model.signUpConfirmPasswordController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  void _login(BuildContext context) async {
    GoRouter.of(context).prepareAuthEvent();
    final user = await signInWithEmail(
      context,
      _model.logInEmailController.text.trim(),
      _model.logInPasswordController.text,
    );
    // final usersUpdateData = createUsersRecordData(
    //   lastLoginTime: getCurrentTimestamp,
    // );
    // await currentUserReference!.update(usersUpdateData);

    if (user == null) {
      return;
    }

    // print(user.email);
    //Add timestamp while logining in

    // login to dashboard code below.
    context.goNamedAuth(
      'Dashboard',
      mounted,
      queryParams: {
        'water': serializeParam(
          _model.output,
          ParamType.JSON,
        ),
      }.withoutNulls,
    );
    Navigator.pop(context);
  }

  final GoogleSignInProvider _googleSignInProvider = GoogleSignInProvider();
  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

// Main design and function block of the page.
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80),
              child: Image.asset('assets/images/banner.png'),
            ),
            SizedBox(height: 40.0),
            Text(
              "Login",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                fontFamily: "Spartan",
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextFormField(
                    controller: _model.logInEmailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      hintText: 'Email',
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
                    validator: _model.logInEmailControllerValidator
                        .asValidator(context),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextFormField(
                    controller: _model.logInPasswordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: _tooglePassowrdVisibility,
                      ),
                      filled: true,
                      fillColor: Colors.black,
                      hintText: 'Password',
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
                    validator: _model.logInPasswordControllerValidator
                        .asValidator(context),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () => _login(context),
                child: Text(
                  'Log In',
                  style: TextStyle(fontFamily: 'Spartan'),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(0xFFC6DDDB),
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Text(
              "or",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: "Spartan",
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 300,
              child: ElevatedButton.icon(
                onPressed: () async {
                  AuthService().signInWithGoogle().then((success) {
                    if (success) {
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(builder: (context) => DashboardWidget()),
                      // );
                      context.goNamedAuth(
                        'Dashboard',
                        mounted,
                        queryParams: {
                          'water': serializeParam(
                            _model.output,
                            ParamType.JSON,
                          ),
                        }.withoutNulls,
                      );
                    }
                  });
                },
                // onPressed: () async {
                //   User? user = await _googleSignInProvider.signInWithGoogle();
                //   print(user);
                //   if (user != null) {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(
                //         content: Text('Welcome ${user.displayName}!'),
                //       ),
                //     );
                //   }
                // },
                // onPressed: () => AuthService().signInWithGoogle(),
                // Implement your Google login functionality herer
                icon: Image.asset(
                  'assets/images/google.png',
                  width: 24,
                  height: 24,
                ),
                label: Text(
                  'Continue with Google',
                  style: TextStyle(
                    fontFamily: 'Spartan',
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Color(0xFFC6DDDB)),
                  ),
                  backgroundColor: Colors.black,
                  foregroundColor: Color(0xFFC6DDDB),
                ),
              ),
            ),
            SizedBox(height: 35),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                );
                // Navigator.pushNamed(context, MyRoutes.SignupRoute);
              },
              child: Text(
                'New to Hydrow? Sign up here!',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontFamily: 'Spartan',
                  fontWeight: FontWeight.bold,
                  // decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
