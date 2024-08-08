import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class BorewellEditModel extends FlutterFlowModel {
  final formKey = GlobalKey<FormState>();
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  String? _textController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 1) {
      return "Requires at least 1 characters.";
    }
    if (val.length > 10) {
      return "Maximum 10 characters allowed, currently ${val.length}.";
    }
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(val)) {
      return 'Name can only contain letters and numbers';
    }

    return null;
  }

  void initState(BuildContext context) {
    textController1Validator = _textController1Validator;
  }

  void dispose() {
    textController1?.dispose();
  }
}
