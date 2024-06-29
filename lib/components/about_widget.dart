import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';
import 'about_model.dart';
export 'about_model.dart';

class AboutWidget extends StatefulWidget {
  const AboutWidget({Key? key}) : super(key: key);

  @override
  _AboutWidgetState createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  late AboutModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutModel());
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
            'About',
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
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'About HydrowVerse',
                //   style: GF.GoogleFonts.leagueSpartan(
                //     textStyle: TextStyle(
                //       fontSize: 20.0,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white, // Set text color to white
                //     ),
                //   ),
                // ),
                SizedBox(height: 16.0),
                Text(
                  'Hydrow Technologies is a water intelligence platform providing solutions for monitoring water in tanks and pipes. Realtime updates of the water levels and flow can be viewed and alerts of possible leakages are given. Water wastage and losses in the form of NRW (Non Revenue Water) can be mitigated.\n\nHydrow Technologies is a start-up founded in SPCRC Labs, IIIT Hyderabad, under Dr. Sachin Chaudhari (Associate Professor) and Thomas David Tency.',
                  style: GF.GoogleFonts.leagueSpartan(
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      height: 1.2,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                Text(
                  'Developers',
                  style: GF.GoogleFonts.leagueSpartan(
                    textStyle: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                DeveloperCard(
                  name: 'Chinmay Bhalodia',
                  role: 'chinmaybhalodia@gmail.com.',
                ),
                SizedBox(height: 8.0),
                DeveloperCard(
                  name: 'Raj Tejaswee',
                  role: 'rajtejaswee02@gmail.com.',
                ),
                SizedBox(height: 8.0),
                DeveloperCard(
                  name: 'Anshita Kanthed ',
                  role: 'Anshita.j08@gmail.com',
                ),
                SizedBox(height: 8.0),
                DeveloperCard(
                  name: 'Yashpal Yadav',
                  role: 'yashpalyadav050@gmail.com',
                ),
                SizedBox(height: 8.0),
                DeveloperCard(
                  name: 'Vishna Panyala',
                  role: 'vishnapanyala@gmail.com.',
                ),
                DeveloperCard(
                  name: 'Priyanka Joshi',
                  role: 'priyankajoshi.pj31@gmail.com',
                ),
                SizedBox(height: 8.0),
                DeveloperCard(
                  name: 'Urmil Lokhande',
                  role: 'urmillokhande@gmail.com',
                ),
              ],
            ),
          ),
        ));
  }
}

class DeveloperCard extends StatelessWidget {
  final String name;
  final String role;

  const DeveloperCard({
    Key? key,
    required this.name,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF212121), // Set card background color
      child: ListTile(
        title: Text(
          name,
          style: GF.GoogleFonts.leagueSpartan(
            textStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Colors.white, // Set text color to white
            ),
          ),
        ),
        subtitle: Text(
          role,
          style: GF.GoogleFonts.leagueSpartan(
            textStyle: TextStyle(
              fontSize: 16.0,
              color:
                  Colors.white70, // Set text color to a lighter shade of white
            ),
          ),
        ),
      ),
    );
  }
}
//     return Card(
//       elevation: 2.0,
//       color: Colors.white, // Set card background color
//       child: ListTile(
//         leading: Icon(Icons.person),
//         title: Text(
//           name,
//           style: GF.GoogleFonts.leagueSpartan(
//             textStyle: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         subtitle: Text(
//           role,
//           style: GF.GoogleFonts.leagueSpartan(),
//         ),
//       ),
//     );
//   }
// }






//     return SingleChildScrollView(
//       child: Container(
//         width: 400.0,
//         height: 1000.0,
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
//                     'About',
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
//                 'Hydrow Technologies is a water intelligence platform providing solutions for monitoring water in tanks and pipes. Realtime updates of the water levels and flow can be viewed and alerts of possible leakages are given. Water wastage and losses in the form of NRW (Non Revenue Water) can be mitigated.\n\nHydrow Technologies is a start-up founded in SPCRC Labs, IIIT Hyderabad, under Dr. Sachin Chaudhari (Associate Professor) and Thomas David Tency.',
//                 textAlign: TextAlign.center,
//                 style: FlutterFlowTheme.of(context).bodyText1.override(
//                       fontFamily: 'Poppins',
//                       fontSize: 16.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                       useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
//                           FlutterFlowTheme.of(context).bodyText1Family),
//                     ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
//               child: Text(
//                 'Developers',
//                 textAlign: TextAlign.center,
//                 style: FlutterFlowTheme.of(context).bodyText1.override(
//                       fontFamily: 'Poppins',
//                       fontSize: 16.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                       useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
//                           FlutterFlowTheme.of(context).bodyText1Family),
//                     ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
//               child: Text(
//                 'Urmil Lokhande',
//                 textAlign: TextAlign.center,
//                 style: FlutterFlowTheme.of(context).bodyText1.override(
//                       fontFamily: 'Poppins',
//                       fontSize: 16.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                       useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
//                           FlutterFlowTheme.of(context).bodyText1Family),
//                     ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
//               child: Text(
//                 'urmillokhande@gmail.com',
//                 textAlign: TextAlign.center,
//                 style: FlutterFlowTheme.of(context).bodyText1.override(
//                       fontFamily: 'Poppins',
//                       fontSize: 16.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                       useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
//                           FlutterFlowTheme.of(context).bodyText1Family),
//                     ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
//               child: Text(
//                 'Priyanka Joshi',
//                 textAlign: TextAlign.center,
//                 style: FlutterFlowTheme.of(context).bodyText1.override(
//                       fontFamily: 'Poppins',
//                       fontSize: 16.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                       useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
//                           FlutterFlowTheme.of(context).bodyText1Family),
//                     ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
//               child: Text(
//                 'priyankajoshi.pj31@gmail.com',
//                 textAlign: TextAlign.center,
//                 style: FlutterFlowTheme.of(context).bodyText1.override(
//                       fontFamily: 'Poppins',
//                       fontSize: 16.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                       useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
//                           FlutterFlowTheme.of(context).bodyText1Family),
//                     ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
//               child: Text(
//                 'Anshita Kanthed',
//                 textAlign: TextAlign.center,
//                 style: FlutterFlowTheme.of(context).bodyText1.override(
//                       fontFamily: 'Poppins',
//                       fontSize: 16.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                       useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
//                           FlutterFlowTheme.of(context).bodyText1Family),
//                     ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
//               child: Text(
//                 'Anshita.j08@gmail.com',
//                 textAlign: TextAlign.center,
//                 style: FlutterFlowTheme.of(context).bodyText1.override(
//                       fontFamily: 'Poppins',
//                       fontSize: 16.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                       useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
//                           FlutterFlowTheme.of(context).bodyText1Family),
//                     ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
//               child: Text(
//                 'Yashpal Yadav',
//                 textAlign: TextAlign.center,
//                 style: FlutterFlowTheme.of(context).bodyText1.override(
//                       fontFamily: 'Poppins',
//                       fontSize: 16.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                       useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
//                           FlutterFlowTheme.of(context).bodyText1Family),
//                     ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
//               child: Text(
//                 'yashpalyadav050@gmail.com',
//                 textAlign: TextAlign.center,
//                 style: FlutterFlowTheme.of(context).bodyText1.override(
//                       fontFamily: 'Poppins',
//                       fontSize: 16.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                       useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
//                           FlutterFlowTheme.of(context).bodyText1Family),
//                     ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
//               child: Text(
//                 'Vishna Panyala',
//                 textAlign: TextAlign.center,
//                 style: FlutterFlowTheme.of(context).bodyText1.override(
//                       fontFamily: 'Poppins',
//                       fontSize: 16.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                       useGoogleFonts: GF.GoogleFonts.asMap().containsKey(
//                           FlutterFlowTheme.of(context).bodyText1Family),
//                     ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
//               child: Text(
//                 'vishnapanyala@gmail.com.com',
//                 textAlign: TextAlign.center,
//                 style: FlutterFlowTheme.of(context).bodyText1.override(
//                       fontFamily: 'Poppins',
//                       fontSize: 16.0,
//                       color: Colors.white,
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
//                 child: const Text('Go back!'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
