import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'TermsandConditions_model.dart';

class TermsandCondition extends StatefulWidget {
  const TermsandCondition({Key? key}) : super(key: key);

  @override
  State<TermsandCondition> createState() => _TermsandConditionState();
}

class _TermsandConditionState extends State<TermsandCondition> {
  late TermsandConditionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TermsandConditionModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
          style: GF.GoogleFonts.leagueSpartan(
            textStyle: TextStyle(
              fontSize: 22.0,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF112025), // Set app bar color
      ),
      backgroundColor: Color(0xFF0C0C0C), // Set background color
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please read these Terms and Conditions of Use ("Terms") carefully before downloading, installing, or using the water tank monitoring mobile application (the "App") on your Android device. By downloading, installing, or using the App, you agree to be bound by these Terms and all associated services offered by Hydrow',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  height: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'License:',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF91D9E9),
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'The owner grants you a non-exclusive and revocable license to use the App on your Android device in accordance with these Terms and the applicable usage rules set forth in the Google Play Store Terms of Service.',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 18.0,
                  height: 1.2,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Restrictions: ',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF91D9E9),
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'You are not allowed to copy, modify, distribute, sell, or transfer the App or any portion thereof; attempting to reverse engineer or extract source code from the App is strictly prohibited unless such activity is expressly permitted by law. You are not permitted to use the App for any illegal or unauthorized purpose.',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  height: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Ownership:',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  height: 1.2,
                  color: Color(0xFF91D9E9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'The App, along with all intellectual property rights therein, is owned exclusively by Owner and its licensors; no rights or licenses are granted to you by implication or otherwise besides the limited license granted to you within these Terms.',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 18.0,
                  height: 1.2,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Privacy:',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  height: 1.2,
                  color: Color(0xFF91D9E9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'The owner values your privacy and is committed to protecting your personal information for details about how we collect and use your data.',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  height: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Disclaimer of Warranties:',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  height: 1.2,
                  color: Color(0xFF91D9E9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'The App is provided without warranty of any kind; the Owner disclaims all express and implied warranties including merchantability, fitness for a specific purpose, and non-infringement. There is no guarantee that this application will meet all your requirements nor that its operation will be error-free and uninterrupted at all times.',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 18.0,
                  height: 1.2,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Limitation of Liability:',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  height: 1.2,
                  color: Color(0xFF91D9E9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'In no event shall the Owner be liable for any direct or indirect damages arising out of or in connection with the use or inability to use this application even if a warning has been given regarding such damages; some jurisdictions do not allow exclusion/limitation of liability for consequential/incidental damages so this limitation may not apply to you.',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  height: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Indemnification:',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  height: 1.2,
                  color: Color(0xFF91D9E9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'You agree to defend, and hold harmless the Owner as well as its affiliates, officers, directors, employees, agents, and licensors from any claims resulting from your use of the App.',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  height: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Changes To Terms:',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  height: 1.2,
                  color: Color(0xFF91D9E9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'The owner reserves the right to modify these Terms at any time without notice and without liability towards you; continued usage signifies agreement with revised terms.',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  height: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Termination:',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  height: 1.2,
                  color: Color(0xFF91D9E9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'The owner may terminate these Terms as well as access to this application at any time without prior warning.',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  height: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Governing Law:',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  height: 1.2,
                  color: Color(0xFF91D9E9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'These Terms shall be governed by their courts; any legal actions resulting from these terms should be brought there too.',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  height: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Entire Agreement:',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  height: 1.2,
                  color: Color(0xFF91D9E9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'These terms constitute the complete agreement between both parties concerning the usage of this app, superseding all prior communications between both parties regarding it.',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 18.0,
                  height: 1.2,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
//     return SingleChildScrollView(
//       child: Container(
//         width: 400.0,
//         height: 1700.0,
//         decoration: BoxDecoration(
//           color: Colors.black,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding:
//                       EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 15.0),
//                   child: Text(
//                     'Terms and Conditions',
//                     textAlign: TextAlign.left,
//                     style: FlutterFlowTheme.of(context).bodyText1.override(
//                           fontFamily: 'Poppins',
//                           color: Colors.white,
//                           fontSize: 28.0,
//                           useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
//                               FlutterFlowTheme.of(context).bodyText1Family),
//                         ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
//               child: Text(
//                 'Please read these Terms and Conditions of Use ("Terms") carefully before downloading, installing, or using the water tank monitoring mobile application (the "App") on your Android device. By downloading, installing, or using the App, you agree to be bound by these Terms and all associated services offered by Hydrow\n
//                 \n1. License:Owner grants you a non-exclusive and revocable license to use the App on your Android device in accordance with these Terms and the applicable usage rules set forth in the Google Play Store Terms of Service.
//                 \n2. Restrictions:You are not allowed to copy, modify, distribute, sell, or transfer the App or any portion thereof; attempting to reverse engineer or extract source code from the App is strictly prohibited unless such activity is expressly permitted by law. You are not permitted to use the App for any illegal or unauthorized purpose.
//                 \n3. Ownership:The App, along with all intellectual property rights therein, is owned exclusively by Owner and its licensors; no rights or licenses are granted to you by implication or otherwise besides the limited license granted to you within these Terms.
//                 \n4. Privacy:Owner values your privacy and is committed to protecting your personal information for details about how we collect and use your data.
//                 \n5. Disclaimer of Warranties: The App is provided without warranty of any kind; Owner disclaims all express and implied warranties including merchantability, fitness for a specific purpose, and non-infringement. There is no guarantee that this application will meet all your requirements nor that its operation will be error-free and uninterrupted at all times.
//                 \n 6. Limitation of Liability: In no event shall Owner be liable for any direct or indirect damages arising out of or in connection with the use or inability to use this application even if a warning has been given regarding such damages; some jurisdictions do not allow exclusion/limitation of liability for consequential/incidental damages so this limitation may not apply to you .
//                 \n7. Indemnification: You agree to defend, hold harmless Owner as well as its affiliates, officers, directors, employees, agents and licensors from any claims resulting from your use of the App .
//                 \n8. Changes To Terms: Owner reserves the right to modify these Terms at any time without notice and without liability towards you; continued usage signifies agreement with revised terms .
//                 \n9. Termination: Owner may terminate these Terms as well as access to this application at any time without prior warning .
//                 \n10. Governing Law : These Terms shall be governed by their courts ; any legal actions resulting from these terms should be brought there too .\n11. Entire Agreement : These terms constitute the complete agreement between both parties concerning usage of this app , superseding all prior communications between both parties regarding it .',
//                 textAlign: TextAlign.left,
//                 style: FlutterFlowTheme.of(context).bodyText1.override(
//                       fontFamily: 'Poppins',
//                       color: Colors.white,
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.w500,
//                       useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
//                           FlutterFlowTheme.of(context).bodyText1Family),
//                     ),
//               ),
//             ),
//             Container(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Go Back!'),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
