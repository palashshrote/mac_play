import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'contact_us_model.dart';
export 'contact_us_model.dart';

class ContactUsWidget extends StatefulWidget {
  const ContactUsWidget({Key? key}) : super(key: key);

  @override
  _ContactUsWidgetState createState() => _ContactUsWidgetState();
}

class _ContactUsWidgetState extends State<ContactUsWidget> {
  late ContactUsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContactUsModel());
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
          'Contact Us',
          style: GF.GoogleFonts.leagueSpartan(
            textStyle: TextStyle(fontSize: 22.0),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF112025), // Set app bar color
      ),
      backgroundColor: Color(0xFF0C0C0C), // Set background color
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Contact Information',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(Icons.email, color: Colors.white),
              title: Text(
                'Email',
                style: GF.GoogleFonts.leagueSpartan(
                  textStyle: TextStyle(
                      fontSize: 18,
                      height: 1.2,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              subtitle: Text(
                'thomas.tency@research.iiit.ac.in',
                style: GF.GoogleFonts.leagueSpartan(
                  textStyle: TextStyle(
                    height: 1.2,
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text(
                'Phone',
                style: GF.GoogleFonts.leagueSpartan(
                  textStyle: TextStyle(
                      height: 1.2,
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              subtitle: Text(
                '+91 9821838139',
                style: GF.GoogleFonts.leagueSpartan(
                  textStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    height: 1.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.white),
              title: Text(
                'Address',
                style: GF.GoogleFonts.leagueSpartan(
                  textStyle: TextStyle(
                      height: 1.2,
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              subtitle: Text(
                'SPCRC Lab, IIIT Hyderabad, Gachibowli, Hyderabad, Telangana 500032, India ',
                style: GF.GoogleFonts.leagueSpartan(
                  textStyle: TextStyle(
                    height: 1.2,
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Text(
              'Opening Hours',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Monday - Friday: 9:00 AM - 5:00 PM',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  color: Colors.white,
                  height: 1.2,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Text(
              'Saturday: 10:00 AM - 2:00 PM',
              style: GF.GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  color: Colors.white,
                  height: 1.2,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            // SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () {
            //     // Add your action here
            //   },
            //   child: Text(
            //     'Send Message',
            //     style: GF.GoogleFonts.leagueSpartan(
            //       textStyle: TextStyle(
            //         fontSize: 16.0,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
      // width: 400.0,
      // height: 400.0,
      // decoration: BoxDecoration(
      //   color: Colors.black,
      // ),
      // child: Column(
      //   mainAxisSize: MainAxisSize.max,
      //   children: [
      //     Row(
      //       mainAxisSize: MainAxisSize.max,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Padding(
      //           padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 15.0),
      //           child: Text(
      //             'Contact Us',
      //             style: FlutterFlowTheme.of(context).bodyText1.override(
      //                   fontFamily: 'Poppins',
      //                   color: Colors.white,
      //                   fontSize: 28.0,
      //                   useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
      //                       FlutterFlowTheme.of(context).bodyText1Family),
      //                 ),
      //           ),
      //         ),
      //       ],
      //     ),
  //         Text(
  //           'Thomas David Tency',
  //           style: FlutterFlowTheme.of(context).bodyText1.override(
  //                 fontFamily: 'Poppins',
  //                 fontSize: 17.0,
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.w600,
  //                 useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
  //                     FlutterFlowTheme.of(context).bodyText1Family),
  //               ),
  //         ),
  //         Text(
  //           'thomas.tency@research.iiit.ac.in',
  //           style: FlutterFlowTheme.of(context).bodyText1.override(
  //                 fontFamily: 'Poppins',
  //                 fontSize: 16.0,
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.w500,
  //                 useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
  //                     FlutterFlowTheme.of(context).bodyText1Family),
  //               ),
  //         ),
  //         Text(
  //           '+91 9821838139',
  //           style: FlutterFlowTheme.of(context).bodyText1.override(
  //                 fontFamily: 'Poppins',
  //                 fontSize: 16.0,
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.w500,
  //                 useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
  //                     FlutterFlowTheme.of(context).bodyText1Family),
  //               ),
  //         ),
  //         Container(
  //       child: ElevatedButton(
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         child: const Text('Go back!'),
  //       ),)
  //       ],
  //     ),
  //   );
  // }
