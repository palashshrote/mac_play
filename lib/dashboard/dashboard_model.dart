import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/about_widget.dart';
import '/components/contact_us_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:hydrow/custom_code/actions/new_custom_action.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:provider/provider.dart';

class DashboardModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - newCustomAction] action in Button widget.
  dynamic? output;
  // Stores action output result for [Custom Action - bore] action in Button widget.
  dynamic? boreWater;
  // Stores action output result for [Custom Action - callAPI] action in Button widget.
  double? waterLevel;
  double? outputwater;
  double? temperature;

  // get the data for pravah dashboard.
  dynamic? totalFlow = functions.getReading(FFAppState().meterKey);
  dynamic? flowRate = functions.getFlowRate(FFAppState().meterKey);
  dynamic? outputPravah = newCustomActionPravah(
    (currentUserDocument?.meterKeyList?.toList() ?? []).toList(),
  );

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Additional helper methods are added here.
}
