import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hydrow/backend/api_requests/register_device.dart';
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
import 'package:provider/provider.dart';
import 'signUpModel.dart';
export 'signUpModel.dart';
import 'log_in_sign_up_widget.dart';
// import 'log_in_sign_up/log_in_sign_up_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  late SignUpModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUpModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.lockOrientation();
    });
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

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80),
              child: Image.asset(
                'assets/images/banner.png',
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                fontFamily: "Spartan",
                color: Colors.white,
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  /*
                  TextFormField(
                    controller: _model.userNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
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
                          color: Colors.white,
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
                    validator:
                        _model.userNameControllerValidator.asValidator(context),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                */
                  customTextField(
                    _model.userNameController,
                    'Name',
                    _model.userNameControllerValidator.asValidator(context),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  /*
                  TextFormField(
                    controller: _model.emailController,
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
                    validator:
                        _model.emailControllerValidator.asValidator(context),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  */
                  customTextField(
                    _model.emailController,
                    'Email',
                    _model.emailControllerValidator.asValidator(context),
                  ),
                ],
              ),
            ),
            // Rest of the code for phone number, password, and confirm password fields
            // ...
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  /*
                  TextFormField(
                    controller: _model.phoneNumberController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
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
                    validator: _model.phoneNumberControllerValidator
                        .asValidator(context),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                  ),
                */
                  customTextField(
                    _model.phoneNumberController,
                    'Phone Number',
                    _model.phoneNumberControllerValidator.asValidator(context),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  /*
                  TextFormField(
                    controller: _model.signUpPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
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
                    validator: _model.signUpPasswordControllerValidator
                        .asValidator(context),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  */
                  customTextField(
                    _model.signUpPasswordController,
                    'Password',
                    _model.signUpPasswordControllerValidator
                        .asValidator(context),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  /*
                  TextFormField(
                    controller: _model.signUpConfirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      hintText: 'Confirm Password',
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
                    validator: _model.signUpConfirmPasswordControllerValidator
                        .asValidator(context),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                */
                  customTextField(
                    _model.signUpConfirmPasswordController,
                    'Confirm Password',
                    _model.signUpConfirmPasswordControllerValidator
                        .asValidator(context),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    GoRouter.of(context).prepareAuthEvent();

                    // Matching the passwords.
                    if (_model.signUpPasswordController.text !=
                        _model.signUpConfirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Passwords don\'t match!',
                          ),
                        ),
                      );
                      return;
                    }
                    final user = await createAccountWithEmail(
                      context,
                      _model.emailController.text.trim(),
                      _model.signUpPasswordController.text,
                    );
                    if (user == null) {
                      return;
                    }

                    final usersCreateData = createUsersRecordData(
                      email: _model.emailController.text.trim(),
                      displayName: _model.userNameController.text.trim(),
                      phoneNumber: _model.phoneNumberController.text,
                    );
                    await UsersRecord.collection
                        .doc(user.uid)
                        .update(usersCreateData);

                    await sendEmailVerification();
                    if (currentUserEmailVerified) {
                      context.pushNamedAuth('Dashboard', mounted);
                    } else {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return customAlertDialog(
                            // 'Authentication',
                            'A U T H E N T I C A T I O N',
                            'An authentication mail was sent to your email-id. Please verify and then login using your credentials.',
                            [
                              actionBtnWidget(
                                "O K",
                                onPressed: () {
                                  Navigator.pop(alertDialogContext);
                                },
                              ),
                            ],
                          );
                          /*return AlertDialogg(
                            title: Text('Authentication'),
                            content: Text(
                                'An authentication mail was sent to your email-id. Please verify and then login using your credentials.'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext),
                                child: Text('Ok'),
                              ),
                            ],
                          );*/
                        },
                      );

                      context.pushNamedAuth('LogInSignUp', mounted);
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontFamily: 'Spartan',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xFFC6DDDB),
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                context.pushNamed('LogInSignUp');
              },
              child: Text(
                'Already Registered? Login here!',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontFamily: 'Spartan',
                  fontWeight: FontWeight.bold,
                  // decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // customTextField(_model.userNameController,'Name',_model.userNameControllerValidator.asValidator(context),),
  Widget customTextField2(TextEditingController? controller, String hintText,
      String? Function(String?)? validator) {
    return TextFormField(
      controller: _model.userNameController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black,
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
            color: Colors.white,
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
      validator: _model.userNameControllerValidator.asValidator(context),
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget customTextField(TextEditingController? controller, String hintText,
      String? Function(String?)? validator) {
    return TextFormField(
      controller: controller,
      obscureText: hintText == 'Password' || hintText == 'Confirm Password'
          ? true
          : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 31, 16, 16),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.w500,
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
            color: Colors.white,
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
      validator: validator,
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }
}
