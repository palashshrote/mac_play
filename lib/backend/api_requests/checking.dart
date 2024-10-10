import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> deviceAlreadyRegistered(String cId, String deviceType) {
  return fetchMeterKeys(cId, deviceType);
}

Future<bool> fetchMeterKeys(String cId, String deviceType) async {
  // Get a reference to the "Meter" collection
  CollectionReference devices =
      FirebaseFirestore.instance.collection(deviceType);

  try {
    // Fetch all documents in the collection
    QuerySnapshot querySnapshot = await devices.get();

    // Iterate over each document and extract the MeterKey field
    for (var doc in querySnapshot.docs) {
      String key;

      // Fetch the key based on deviceType
      if (deviceType == "Meter") {
        key = doc['MeterKey'];
      } else if (deviceType == "Tank") {
        key = doc['TankKey'];
      } else if (deviceType == "Borewell") {
        key = doc['BorewellKey'];
      } else {
        // If the deviceType is unknown, return false
        return false;
      }

      // Check if the device is present
      if (checkIfPresent(cId, key)) {
        return true; // Device found, return true
      }
    }
    return false;
  } catch (e) {
    print('Error fetching Keys: $e');
    return false;
  }
}

bool checkIfPresent(String channelId, String key) {
  List<String>? parts = key.split('&');
  String cId = parts[0];

  return (channelId == cId);
}
