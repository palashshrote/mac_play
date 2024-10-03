import 'package:hydrow/constants/k_generalized.dart';
import 'package:hydrow/flutter_flow/flutter_flow_util.dart';
import 'package:provider/src/provider.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hydrow/flutter_flow/nav/serialization_util.dart';
import 'package:hydrow/flutter_flow/nav/nav.dart';

class RegisterDevice extends StatefulWidget {
  final String deviceType;
  final String qrData;
  const RegisterDevice(
      {super.key, required this.deviceType, required this.qrData});

  @override
  State<RegisterDevice> createState() => _RegisterDeviceState();
}

class _RegisterDeviceState extends State<RegisterDevice> {
  late String _deviceType;
  late String _qrData;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController devicenameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _deviceType = widget.deviceType;
    _qrData = widget.qrData;
  }

  Future<void> addToFirestore() async {
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
                return AlertDialog(
                  title: Text('Register'),
                  content: Text(
                      'Do you want to register this device as ${deviceName}?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext, false),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext, true),
                      child: Text('Confirm'),
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
                return AlertDialog(
                  title: const Text('Success'),
                  content: const Text('Device Registered successfully'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        if (_deviceType == "Tank") {
                          context.pushNamed(
                            'CubeOrCy',
                            queryParams: {
                              'tankKey': serializeParam(
                                _qrData,
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        } else if (_deviceType == "Meter") {
                          context.pushNamed(
                            'AddDevicePravah',
                            queryParams: {
                              'meterKey': serializeParam(
                                _qrData,
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        } else {
                          context.pushNamed(
                            'AddDeviceDebore',
                            queryParams: {
                              'borewellKey': serializeParam(
                                _qrData,
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        }
                      },
                      child: const Text('OK'),
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
    context.watch<FFAppState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF0C0C0C),
      appBar: genAppBar("Register Device"),
      // appBar: AppBar(
      //   title: const Text(''),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: TextField(
                controller: devicenameController,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: entryInputDecoration,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
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

var devButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(7.0),
  ),
  backgroundColor: Colors.white,
  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
);

var devTextStyle = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

var entryInputDecoration = InputDecoration(
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
);
