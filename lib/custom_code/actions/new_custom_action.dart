// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;
import 'dart:convert';

String generateChannelID(String key) {
  return key.split("&").first;
}

String generateReadAPI(String key) {
  return key.split("&").elementAt(1);
}

Future<dynamic> newCustomActionPravah(List<String> keys) async {
  String str1 = "channels/";
  String str2 = "/fields/1&3.json?api_key=";
  String str3 = "/fields/2&3.json?api_key=";
  String str4 = '&results=1';
  String FinalString = "{\"meters\"" + ":[";
  String thingspeak = 'https://api.thingspeak.com/';
  for (int i = 0; i < keys.length; i++) {
    String ChannelID = generateChannelID(keys[i]);
    String ReadAPI = generateReadAPI(keys[i]);

    // getting meter name
    String s1 = thingspeak +
        str1 +
        ChannelID +
        "/fields/3/last.json?api_key=" +
        ReadAPI;
    var url1 = Uri.parse(s1);
    var response1 = await http.get(url1);
    var jsonData1 = json.decode(response1.body);
    var meterName = jsonData1["field3"];

    // getting the total flow reading and flow rate
    String s2 = thingspeak +
        str1 +
        ChannelID +
        "/fields/1&2.json?api_key=" +
        ReadAPI +
        "&results=1";
    var url2 = Uri.parse(s2);
    var response2 = await http.get(url2);
    var jsonData2 = json.decode(response2.body);
    var totalFlow = jsonData2["feeds"][0]["field1"];
    var flowRate = jsonData2["feeds"][0]["field2"];

    if (totalFlow == null) {
      totalFlow = "0.0";
    }
    if (flowRate == null) {
      flowRate = "0.0";
    }

    bool isActive = await checkActivityPravah(keys[i]);

    var String2 = "{\"MeterName\":" +
        "\"" +
        meterName +
        "\"" +
        ", \"TotalFlow\":" +
        "\"" +
        totalFlow +
        "\"" +
        ", \"FlowRate\":" +
        "\"" +
        flowRate +
        "\"" +
        ", \"Activity\":" +
        "\"" +
        isActive.toString() +
        "\""+
        "}";
    if (i == keys.length - 1) {
      FinalString += String2;
    } else {
      FinalString += String2 + ",";
    }
  }
  FinalString += "]}";
  var mapObject = json.decode(FinalString);

  return mapObject;
}

Future<dynamic> newCustomAction(List<String> keys) async {
  String str1 = '/channels/';
  String str2 = '/fields/6&7.json?api_key=';
  String str3 = '&results=1';
  String FinalString = "{\"tanks\"" + ":[";
  String thingspeak = 'https://api.thingspeak.com/';
  for (int i = 0; i < keys.length; i++) {
    String ChannelID = generateChannelID(keys[i]);
    String ReadAPI = generateReadAPI(keys[i]);
    String str = str1 + ChannelID + str2 + ReadAPI + str3;
    String str10 = "https://api.thingspeak.com/channels/" +
        ChannelID +
        "/fields/1/last.json?api_key=" +
        ReadAPI;

    var url = Uri.parse(thingspeak + str);
    var response = await http.get(url);
    var jdata = json.decode(response.body);
    var waterLevel = jdata["feeds"][0]["field6"];
    var temperature = jdata["feeds"][0]["field7"];

    if(waterLevel==null){
      waterLevel = "0.0";
    }
    if(temperature==null){
      temperature = "0.0";
    }

    var url2 = Uri.parse(str10);
    var response2 = await http.get(url2);
    var jdata2 = json.decode(response2.body);
    print("JDATA2"+jdata2.toString());
    var tankName = jdata2["field1"];

    bool isActive = await checkActivity(keys[i]);

    var String2 = "{\"TankName\":" +
        "\"" +
        tankName +
        "\"" +
        ", \"WaterLevel\":" +
        "\"" +
        waterLevel.toString().trim() +
        "\"" +
        ", \"Temperature\":" +
        "\"" +
        temperature +
        "\"" +
        ", \"Activity\":" +
        "\"" +
        isActive.toString() +
        "\""+
        "}";
    if (i == keys.length - 1) {
      FinalString += String2;
    } else {
      FinalString += String2 + ",";
    }
  }
  FinalString += "]}";
  var mapObject = json.decode(FinalString);

  return mapObject;
}
