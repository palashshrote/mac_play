import 'package:hydrow/backend/api_requests/api_manager.dart';
import 'package:hydrow/constants/k_generalized.dart';
import 'package:hydrow/flutter_flow/flutter_flow_util.dart';
import 'package:provider/src/provider.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hydrow/flutter_flow/nav/serialization_util.dart';
import 'package:hydrow/flutter_flow/nav/nav.dart';

class RegisterDevice extends StatefulWidget {
  final String deviceType;
  // final DocumentReference parent;
  final String qrData;
  const RegisterDevice(
      {super.key,
      required this.deviceType,
      // required this.parent,
      required this.qrData});

  @override
  State<RegisterDevice> createState() => _RegisterDeviceState();
}

class _RegisterDeviceState extends State<RegisterDevice> {
  late String _deviceType;
  late String _qrData;
  // late DocumentReference _parent;
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController devicenameController = TextEditingController();
  bool _isButtonDisabled = false;

  void _onButtonTap() {
    setState(() {
      _isButtonDisabled = true; // Disable the button when tapped
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isButtonDisabled = false; // Re-enable the button after 3 seconds
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _deviceType = widget.deviceType;
    // _parent = widget.parent;
    _qrData = widget.qrData;
  }

  Future<void> addToFirestore() async {
    _onButtonTap();
    String deviceName = devicenameController.text;

    // Ensure device name is not empty
    if (deviceName.isNotEmpty) {
      try {
        // Add device to Firestore
        Map<String, dynamic> backendData;

        if (_deviceType == "Borewell") {
          backendData = {
            'BorewellKey': _qrData,
            'WaterLevelGround':
                await functions.getWaterLevelfromGround(_qrData),
          };
        } else if (_deviceType == "Meter") {
          backendData = {
            'MeterKey': _qrData,
            'Reading': await (functions.getReadingStr(_qrData)),
            'FlowRate': await functions.getFlowRateStr(_qrData),
          };
        } else {
          backendData = {
            'TankKey': _qrData,
            'WaterLevel':
                await functions.getStarrWaterLevel(_qrData, str: true),
            'Temperature': await functions.getTemp(_qrData, str: true),
          };
        }
        backendData['Name'] = deviceName;
        backendData['Timestamp'] = FieldValue.serverTimestamp();
        print(backendData);
        var confirmDialogResponse = await showDialog<bool>(
              context: context,
              builder: (alertDialogContext) {
                return customBodyAlertDialog(
                  null,
                  Text.rich(
                    TextSpan(
                      text:
                          'Are you sure to register this device as ', // Regular text
                      children: <TextSpan>[
                        TextSpan(
                          text: deviceName, // Bold text for deviceName
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text: ' ?', // Regular text after deviceName
                        ),
                      ],
                    ),
                  ),
                  [
                    actionBtnWidget(
                      'C A N C E L',
                      onPressed: () => Navigator.pop(alertDialogContext, false),
                    ),
                    actionBtnWidget(
                      'C O N F I R M',
                      onPressed: () => Future.delayed(
                        Duration(seconds: 2),
                        () {
                          Navigator.pop(alertDialogContext, true);
                        },
                      ),
                    ),
                  ],
                );
              },
            ) ??
            false;
        if (confirmDialogResponse) {
          await FirebaseFirestore.instance
              .collection(_deviceType)
              .add(backendData);

          // Show a success message or navigate back
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return customAlertDialog(
                  'S U C C E S S',
                  'Device Registered successfully',
                  <Widget>[
                    actionBtnWidget(
                      "O K",
                      onPressed: () async {
                        Navigator.pop(context);
                        Navigator.pop(context, 'success');
                      },
                    ),
                  ],
                );
              });
        }
        // Optionally, navigate to another page or reset the form
      } catch (e) {
        // Handle Firestore write error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to add device: $e"),
          ),
        );
      }
    } else {
      // Show an error if the name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Device name cannot be empty"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // context.watch<FFAppState>();
    return Scaffold(
      // key: scaffoldKey,
      backgroundColor: Color(0xFF0C0C0C),
      appBar: genAppBar("Register Device"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: TextField(
                controller: devicenameController,
                autofocus: true,
                style: GF.GoogleFonts.leagueSpartan(
                  color: Color(0xFFFFFFFF),
                ),
                decoration: addDevInpDec("Name"),
              ),
            ),
            Row(
              children: [
                _isButtonDisabled
                    ? disabledBtn("Register")
                    : Expanded(
                        child: ElevatedButton(
                          // onPressed: () {},
                          onPressed: addToFirestore,
                          style: devButtonStyle,
                          child: Text(
                            'Register',
                            style: devTextStyle,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget disabledBtn(String btnText) {
  return Expanded(
    child: ElevatedButton(
      onPressed: () {},
      style: disabledButtonStyle,
      child: Text(
        btnText,
        style: devTextStyle,
      ),
    ),
  );
}

var disabledButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(7.0),
  ),
  backgroundColor: Colors.grey,
  padding: const EdgeInsets.fromLTRB(20, 17, 20, 17),
);

var devButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(7.0),
  ),
  backgroundColor: Colors.white,
  padding: const EdgeInsets.fromLTRB(20, 17, 20, 17),
);

var devTextStyle = GF.GoogleFonts.leagueSpartan(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

InputDecoration addDevInpDec(String hintText) {
  return InputDecoration(
    filled: true,
    fillColor: Color(0xFF0c0c0c),
    hintText: hintText,
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
  );
}

Widget actionBtnWidget(String btnText, {void Function()? onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 41, 32, 32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    // onPressed: () => Navigator.pop(alertDialogContext, false),
    onPressed: onPressed,
    child: Text(btnText),
  );
}

Widget actionBtnWidget2(Text btnText, {void Function()? onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 41, 32, 32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    // onPressed: () => Navigator.pop(alertDialogContext, false),
    onPressed: onPressed,
    child: btnText,
  );
}

Widget customAlertDialog(
    String? titleText, String bodyText, List<Widget> actionTools) {
  return AlertDialog(
    title: titleText != null ? Text(titleText) : null,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0), // Add curvature
    ),
    content: Text(bodyText),
    actions: actionTools,
  );
}

Widget customBodyAlertDialog(
    String? titleText, Widget customContent, List<Widget> actionTools) {
  return AlertDialog(
    title: titleText != null ? Text(titleText) : null,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0), // Add curvature
    ),
    content: customContent,
    actions: actionTools,
  );
}
