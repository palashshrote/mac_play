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
            'Reading': await functions.getReading(_qrData),
            'FlowRate': await functions.getFlowRate(_qrData),
          };
        } else {
          backendData = {
            'TankKey': _qrData,
            'WaterLevel': await functions.getStarrWaterLevel(_qrData),
            'Temperature': await functions.getTemp(_qrData),
          };
        }
        backendData['Name'] = deviceName;
        backendData['Timestamp'] = FieldValue.serverTimestamp();
        print(backendData);
        await FirebaseFirestore.instance
            .collection(_deviceType)
            .add(backendData);

        // Show a success message or navigate back
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Device added successfully'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      context.pushNamed(
                        'CubeOrCy',
                        queryParams: {
                          'tankKey': serializeParam(
                            _qrData,
                            ParamType.String,
                          ),
                        }.withoutNulls,
                      );
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            });

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
      appBar: genAppBar("Add Device"),
      // appBar: AppBar(
      //   title: const Text(''),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: devicenameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Device Name',
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
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
