import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

// final snackBar = SnackBar(
//   content: const Text('Not enough data to show.'),
//   action: SnackBarAction(
//     label: 'OK',
//     onPressed: () {

//     },

//   ),
// );

String shortenNumber(double value) {
  List<String> units = [' ', 'k', 'M', 'B', 'T', 'P', 'E', 'Z', 'Y'];
  int unitIndex = 0;
  while (value >= 1000 && unitIndex < units.length - 1) {
    value /= 1000;
    unitIndex++;
  }
  return value.toStringAsFixed(1) + " " + units[unitIndex];
}

bool qrStarr(String? qrString) {
  String str = qrString ?? "";
  if (str == "" ||
      str == "-1" ||
      generateVerifString(str) != "sTaRrHyDrOwVeRiFsTrInG") {
    return false;
  } else {
    return true;
  }
}

bool qrDebore(String? qrString) {
  String str = qrString ?? "";
  if (str == "" || str == "-1" || generateVerifString(str) != "db") {
    return false;
  } else {
    return true;
  }
}

bool qrPravah(String? qrString) {
  String str = qrString ?? "";
  if (str == "" ||
      str == "-1" ||
      generateVerifString(str) != "pRaVaHhYdRoWvErIfStRiNg") {
    return false;
  } else {
    return true;
  }
}

String generateChannelID(String key) {
  return key.split("&").first;
}

String generateReadAPI(String key) {
  return key.split("&").elementAt(1);
}

String generateWrite(String key) {
  return key.split("&").elementAt(2);
}

String generateVerifString(String key) {
  return key.split("&").last;
}

// String graph(String? channel) {
//   channel = channel ?? "NA";
//   if (channel == "NA") {
//     return "https://thingspeak.com/";
//   } else {
//     String a = "https://thingspeak.com/channels/";
//     String c = "/charts/6?api_key=";
//     String d =
//         "&width=auto&height=auto&bgcolor=000000&color=32e6ee&dynamic=true&results=100&type=line&update=15";

//     return a +
//         channel.split("&").first +
//         c +
//         channel.split("&").elementAt(1) +
//         d;
//   }
// }

String isCuboid(bool isC) {
  if (isC == true) {
    return "Cuboid";
  } else {
    return "Cylinder";
  }
}

double calculateVolume(
  bool isCuboid,
  String length,
  String breadth,
  String height,
  String radius,
) {
  if (isCuboid == true) {
    double? a = double.tryParse(length);
    double? b = double.tryParse(breadth);
    double? c = double.tryParse(height);

    a = a ?? 0;
    b = b ?? 0;
    c = c ?? 0;
    double vol = a * b * c / 1000;
    return double.parse(vol.toStringAsFixed(2));
  } else {
    double? a = double.tryParse(height);
    double? b = double.tryParse(radius);

    a = a ?? 0;
    b = b ?? 0;
    double vol = 3.14159 * a * b * b / 1000;
    return double.parse(vol.toStringAsFixed(2));
  }
}

double tankAPI(
  double? waterVolume,
  double? capacity,
) {
  waterVolume = waterVolume ?? 0;
  capacity = capacity ?? 0;
  if (capacity == 0) {
    return 0;
  }
  return waterVolume / capacity;
}

double calculateWaterAvailable(
  String length,
  String breadth,
  String height,
  String radius,
  double? waterLevel,
  bool isCuboid,
) {
  double? length_ = double.tryParse(length);
  double? breadth_ = double.tryParse(breadth);
  double? height_ = double.tryParse(height);
  double? radius_ = double.tryParse(radius);
  waterLevel = waterLevel ?? -1;
  if (waterLevel == -1) {
    return 0;
  }

  length_ = length_ ?? 0;
  breadth_ = breadth_ ?? 0;
  height_ = height_ ?? 0;
  radius_ = radius_ ?? 0;

  if (isCuboid) {
    double vol = length_ * breadth_ * (height_ - waterLevel) / 1000;
    return double.parse(vol.toStringAsFixed(2));
  } else {
    double vol2 = 3.14159 * radius_ * radius_ * (height_ - waterLevel) / 1000;
    return double.parse(vol2.toStringAsFixed(2));
  }
}

int convertToInt(double? input) {
  input = input ?? 0;
  input = input * 100;
  return input.toInt();
}

double? stringToDouble(String str) {
  return double.tryParse(str);
}

String? cardBackground(double percentage) {
  if (percentage < 100 && percentage > 65) {
    return "https://i.postimg.cc/3xKRcNDh/full-tank-card2.jpg";
  } else if (percentage < 65 && percentage > 35) {
    return "https://i.postimg.cc/021r7ckb/half-tank-card2.jpg";
  } else {
    return "https://i.postimg.cc/m23kjCkV/quartertank-card1.jpg";
  }
}

String? boreWell(String? channel) {
  channel = channel ?? "NA";
  if (channel == "NA") {
    return "https://thingspeak.com/";
  } else {
    String a = "https://thingspeak.com/channels/";
    String c = "/charts/1?api_key=";
    String d =
        "&width=auto&height=auto&bgcolor=000000&color=32e6ee&dynamic=true&results=100&type=line&update=15";

    return a +
        channel.split("&").first +
        c +
        channel.split("&").elementAt(1) +
        d;
  }
}

Future<dynamic> getFlowRate(String meterKey) async {
  String str1 = 'https://api.thingspeak.com/channels/';
  String str2 = '/feeds.json?api_key=';
  String apiUrl = str1 +
      generateChannelID(meterKey) +
      str2 +
      generateReadAPI(meterKey) +
      '&results=1';
  String res = await fetchData(apiUrl);
  var jsonData = json.decode(res, reviver: (key, value) {
    if (value == null) {
      return "N/A";
    }
    return value;
  });
  var val = jsonData['feeds'][0]['field2'];
  try {
    // if (val == null) return "N/A";
    var ans = double.tryParse(val);
    if (ans == null) return "N/A";
    return ans;
  } catch (e) {
    return "N/A";
  }
}

Future<dynamic> getReading(String meterKey) async {
  String str1 = 'https://api.thingspeak.com/channels/';
  String str2 = '/feeds.json?api_key=';
  String apiUrl = str1 +
      generateChannelID(meterKey) +
      str2 +
      generateReadAPI(meterKey) +
      "&results=1";
  String res = await fetchData(apiUrl);
  var jsonData = json.decode(res, reviver: (key, value) {
    if (value == null) {
      return "N/A";
    }
    return value;
  });
  var val = jsonData['feeds'][0]['field1'];
  try {
    // if (val == null) return "N/A";
    var ans = double.tryParse(val);
    if (ans == null) return "N/A";
    return ans;
  } catch (e) {
    return "N/A";
  }
}

Future<dynamic> getWaterLevelfromGround(String borewellKey) async {
  String str1 = 'https://api.thingspeak.com/channels/';
  String str2 = '/feeds.json?api_key=';
  String apiUrl = str1 +
      generateChannelID(borewellKey) +
      str2 +
      generateReadAPI(borewellKey) +
      "&results=1";
  String res = await fetchData(apiUrl);
  // print("All well ${generateChannelID(borewellKey)}");
  var jsonData = json.decode(res, reviver: (key, value) {
    if (value == null || value == -1) {
      // print("REturning NA");
      return 'N/A';
    }
    // print("Returning ${value}");
    return value;
  });
  // var jsonData = json.decode(res);
  if (jsonData == "N/A") return "N/A/B";
  var val = jsonData['feeds'][0]['field1'];
  // print("Null value : ${val}");

  try {
    var ans = (double.tryParse(val)).toString();
    if (ans == null) return "N/A";
    return ans;
  } catch (e) {
    return "N/A";
  }
}

// code for checking whether device is active or not for pravah and starr
Future<bool> checkActivity(String key) async {
  String url = await getActivityURL(key);
  String jsonData = await fetchData(url);
  List<DataEntry> data = convertDataStarr(jsonData);
  return isActive(data);
}

Future<bool> checkActivityPravah(String key) async {
  String url = await getActivityURLPravah(key);
  String jsonData = await fetchData(url);
  List<DataEntry> data = convertDataPravahTotal(jsonData);
  return isActivePravah(data);
}

Future<bool> checkActivityDebore(String key) async {
  String url = await getActivityURLDebore(key);
  String jsonData = await fetchData(url);
  List<DataEntry> data = convertDataDebore(jsonData);
  print("${key} : Active Debore: ${isActiveDebore(data)}");
  return isActiveDebore(data);
}

Future<String> getActivityURL(String key) async {
  key = key ?? "NA";
  if (key == "NA") {
    return "https://thingspeak.com/";
  } else {
    String a = "https://thingspeak.com/channels/";
    String c = "/fields/6.json?api_key=";
    String d = "&results=5&timezone=Asia/Kolkata";
    return a + generateChannelID(key) + c + generateReadAPI(key) + d;
  }
}

Future<String> getActivityURLPravah(String key) async {
  key = key ?? "NA";
  if (key == "NA") {
    return "https://thingspeak.com/";
  } else {
    String a = "https://thingspeak.com/channels/";
    String c = "/fields/1.json?api_key=";
    String d = "&results=5&timezone=Asia/Kolkata";
    return a + generateChannelID(key) + c + generateReadAPI(key) + d;
  }
}

Future<String> getActivityURLDebore(String key) async {
  key = key ?? "NA";
  if (key == "NA") {
    return "https://thingspeak.com/";
  } else {
    String a = "https://thingspeak.com/channels/";
    String c = "/fields/1.json?api_key=";
    String d = "&results=5&timezone=Asia/Kolkata";
    return a + generateChannelID(key) + c + generateReadAPI(key) + d;
  }
}

bool isActiveDebore(List<DataEntry> data) {
  if (data.isEmpty) {
    return false;
  }
  DataEntry latestEntry = data.last;
  // print("LAtest entry value: ${latestEntry.value}");
  if (latestEntry.value == null ||
      latestEntry.value == "No Value" ||
      latestEntry.value == "") {
    return false;
  }

  DateTime now = DateTime.now();
  Duration difference = now.difference(latestEntry.date);
  if (difference.inMinutes > 15) {
    return false; // Time difference exceeds 15 minutes, device is inactive
  }

  return true;
}

bool isActive(List<DataEntry> data) {
  if (data.isEmpty) {
    return false; // No data received, device is inactive
  }

  // // Check if the latest entry is null, "No Value", or an empty string
  DataEntry latestEntry = data.last;
  if (latestEntry.value == null ||
      latestEntry.value == "No Value" ||
      latestEntry.value == "") {
    return false; // Null value, "No Value", or empty string received, device is inactive
  }

  // Check the time difference between the latest entry and current time
  DateTime now = DateTime.now();
  Duration difference = now.difference(latestEntry.date);
  if (difference.inMinutes > 15) {
    return false; // Time difference exceeds 15 minutes, device is inactive
  }

  return true; // Device is active in all other cases
}

bool isActivePravah(List<DataEntry> data) {
  if (data.isEmpty) {
    return false; // No data received, device is inactive
  }

  // Check if the latest entry is null, "No Value", or an empty string
  DataEntry latestEntry = data.last;
  if (latestEntry.value == null ||
      latestEntry.value == "No Value" ||
      latestEntry.value == "") {
    return false; // Null value, "No Value", or empty string received, device is inactive
  }

  // Check the time difference between the latest entry and current time
  DateTime now = DateTime.now();
  Duration difference = now.difference(latestEntry.date);
  if (difference.inMinutes > 30) {
    return false; // Time difference exceeds 30 minutes, device is inactive
  }

  return true; // Device is active in all other cases
}

// code for showing daily average water use
Future<dynamic> getAverageUse(String tankKey, String length, String breadth,
    String radius, bool isCuboid) async {
  String url = await getAverageUseURL(tankKey);
  String jsonData = await fetchData(url);
  List<DataEntry> data = convertDataStarr(jsonData);
  return calculateAverageUse(data, length, breadth, radius, isCuboid);
}

Future<String> getAverageUseURL(String? tankKey) async {
  tankKey = tankKey ?? 'NA';
  if (tankKey == "N/A") {
    return "https://thingspeak.com/";
  } else {
    String a = "https://thingspeak.com/channels/";
    String c = "/fields/6.json?api_key=";
    String d = "&days=30&timezone=Asia/Kolkata";
    return a + generateChannelID(tankKey) + c + generateReadAPI(tankKey) + d;
  }
}

String calculateAverageUse(List<DataEntry> data, String length, String breadth,
    String radius, bool isCuboid) {
  double totalHeight = 0;
  int numberOfDays = 1;

  if (data.length > 0) {
    DataEntry previousEntry = data.first;
    for (int i = 1; i < data.length; i++) {
      DataEntry currentEntry = data[i];
      double difference = currentEntry.value - previousEntry.value;
      if (difference > 0) {
        totalHeight += difference;
      }
      if (currentEntry.date.day != previousEntry.date.day) {
        numberOfDays++;
      }
      previousEntry = currentEntry;
    }
  }
  double totalWaterConsumed = calculateVolume(
      isCuboid, length, breadth, totalHeight.toString(), radius);
  double dailyAverage = totalWaterConsumed / numberOfDays;

  return shortenNumber(dailyAverage);
}

// code for showing today's water use for tank
Future<dynamic> getTodayUse(String tankKey, String length, String breadth,
    String radius, bool isCuboid) async {
  String url = await getTodayUseURL(tankKey);
  String jsonData = await fetchData(url);
  List<DataEntry> data = convertDataStarr(jsonData);
  return calculateDailyUse(data, length, breadth, radius, isCuboid);
}

String calculateDailyUse(List<DataEntry> entries, String length, String breadth,
    String radius, bool isCuboid) {
  double sum = 0.0;
  for (int i = 0; i < entries.length - 1; i++) {
    DataEntry currentEntry = entries[i];
    DataEntry nextEntry = entries[i + 1];

    double difference = nextEntry.value - currentEntry.value;
    if (difference > 0) {
      sum += difference;
    }
  }
  return shortenNumber(
      calculateVolume(isCuboid, length, breadth, sum.toString(), radius));
}

Future<String> getTodayUseURL(String? tankKey) async {
  DateTime now = DateTime.now();
  DateTime todayStart = DateTime(now.year, now.month, now.day);
  tankKey = tankKey ?? "NA";
  if (tankKey == "NA") {
    return "https://thingspeak.com/";
  } else {
    String a = "https://thingspeak.com/channels/";
    String c = "/fields/6.json?api_key=";
    String d = "&timezone=Asia/Kolkata&start=";
    return a +
        generateChannelID(tankKey) +
        c +
        generateReadAPI(tankKey) +
        d +
        todayStart.toString();
  }
}

List<DataEntry> convertDataDebore(String jsonData) {
  List<DataEntry> dataEntries = [];
  try {
    Map<String, dynamic> jsonMap = jsonDecode(jsonData, reviver: (key, value) {
      if (value == null) {
        return "No Value";
      }
      return value;
    });
    if (jsonMap.containsKey('feeds')) {
      List<dynamic> feeds = jsonMap['feeds'];
      for (dynamic feed in feeds) {
        if (feed is Map<String, dynamic>) {
          if (feed.containsKey('created_at') && feed.containsKey('field1')) {
            DateTime? createdAt = DateTime.tryParse(feed['created_at']);
            double? field1 = double.tryParse(feed['field1']);
            if (createdAt != null && field1 != null) {
              DataEntry dataEntry = DataEntry(createdAt, field1);
              dataEntries.add(dataEntry);
            }
          }
        }
      }
    }
  } catch (e) {
    // print('Error decoding JSON: $e');
  }
  return dataEntries;
}

// Generic Function to convert API data to the form of DataEntry class for Starr devices.
// It adds 'created_at' as date and 'field6' as value (height measured by device)
List<DataEntry> convertDataStarr(String jsonData) {
  List<DataEntry> dataEntries = [];
  try {
    Map<String, dynamic> jsonMap = jsonDecode(jsonData, reviver: (key, value) {
      if (value == null) {
        return "No Value"; // Exclude null values from the decoded JSON object
      }
      return value;
    });
    if (jsonMap.containsKey('feeds')) {
      List<dynamic> feeds = jsonMap['feeds'];
      for (dynamic feed in feeds) {
        if (feed is Map<String, dynamic>) {
          if (feed.containsKey('created_at') && feed.containsKey('field6')) {
            DateTime? createdAt = DateTime.tryParse(feed['created_at']);
            double? field6 = double.tryParse(feed['field6']);

            if (createdAt != null && field6 != null) {
              DataEntry dataEntry = DataEntry(createdAt, field6);
              dataEntries.add(dataEntry);
            }
          }
        }
      }
    }
  } catch (e) {
    // print('Error decoding JSON: $e');
  }
  return dataEntries;
}

// Generic Function to convert API data to the form of DataEntry class for Prvah devices to store Total Flow Reading.
// It adds 'created_at' as date and 'field1' as value (meter reading detected by device)
List<DataEntry> convertDataPravahTotal(String jsonData) {
  List<DataEntry> dataEntries = [];
  try {
    Map<String, dynamic> jsonMap = jsonDecode(jsonData, reviver: (key, value) {
      if (value == null) {
        return "No Value";
      }
      return value;
    });
    if (jsonMap.containsKey('feeds')) {
      List<dynamic> feeds = jsonMap['feeds'];
      for (dynamic feed in feeds) {
        if (feed is Map<String, dynamic>) {
          if (feed.containsKey('created_at') && feed.containsKey('field1')) {
            DateTime? createdAt = DateTime.tryParse(feed['created_at']);
            double? field1 = double.tryParse(feed['field1']);

            if (createdAt != null && field1 != null) {
              DataEntry dataEntry = DataEntry(createdAt, field1);
              dataEntries.add(dataEntry);
            }
          }
        }
      }
    }
  } catch (e) {
    // print('Error decoding JSON: $e');
  }
  return dataEntries;
}

// Generic Function to convert API data to the form of DataEntry class for Prvah devices to store Flow Rate Reading.
// It adds 'created_at' as date and 'field2' as value (flow rate from thingspeak)
List<DataEntry> convertDataPravahRate(String jsonData) {
  List<DataEntry> dataEntries = [];
  try {
    Map<String, dynamic> jsonMap = jsonDecode(jsonData, reviver: (key, value) {
      if (value == null) {
        return "No Value";
      }
      return value;
    });
    if (jsonMap.containsKey('feeds')) {
      List<dynamic> feeds = jsonMap['feeds'];
      for (dynamic feed in feeds) {
        if (feed is Map<String, dynamic>) {
          if (feed.containsKey('created_at') && feed.containsKey('field2')) {
            DateTime? createdAt = DateTime.tryParse(feed['created_at']);
            double? field2 = double.tryParse(feed['field2']);

            if (createdAt != null && field2 != null) {
              DataEntry dataEntry = DataEntry(createdAt, field2);
              dataEntries.add(dataEntry);
            }
          }
        }
      }
    }
  } catch (e) {
    // print('Error decoding JSON: $e');
  }
  return dataEntries;
}

// backend code for plotting graphs
// method which returns the sfchart using chart library
Future<SfCartesianChart> getChartDebore(String? channel, String value) async {
  String url = await getAPIUrlDebore(channel);
  // String url =
  //     "https://api.thingspeak.com/channels/2086669/fields/6.json?api_key=F0QFTNP2WB3II639";
  if (value == "Weekly") {
    url = url + "&days=7&average=720&timezone=Asia/Kolkata";
  } else if (value == "Monthly") {
    url = url + "&days=30&average=daily&timezone=Asia/Kolkata";
  } else {
    url = url + "&minutes=1440&timescale=60&timezone=Asia/Kolkata";
  }
  String jsonData = await fetchData(url);
  List<DataEntry> filteredData = convertDataFormatDebore(jsonData, value);

  // List<DataEntry> filteredData = convertDataFormatStarr(
  //     jsonData, value, length, breadth, height, radius, capacity, isCuboid);
  // double minValue = filteredData.isNotEmpty
  //     ? filteredData.map((entry) => entry.value).reduce((a, b) => a < b ? a : b)
  //     : 0;
  return SfCartesianChart(
    tooltipBehavior: TooltipBehavior(enable: true),
    primaryXAxis: DateTimeAxis(
      labelStyle: TextStyle(fontSize: 9),
      majorGridLines:
          MajorGridLines(width: 0.3, color: Colors.grey.withOpacity(0.7)),
      minorGridLines:
          MinorGridLines(width: 0.2, color: Colors.grey.withOpacity(0.5)),
    ),
    primaryYAxis: NumericAxis(
      // minimum: minValue,
      anchorRangeToVisiblePoints: false,
      labelStyle: TextStyle(fontSize: 9),
      majorGridLines:
          MajorGridLines(width: 0.3, color: Colors.grey.withOpacity(0.7)),
      minorGridLines:
          MinorGridLines(width: 0.2, color: Colors.grey.withOpacity(0.5)),
    ),
    series: <ChartSeries<DataEntry, DateTime>>[
      LineSeries<DataEntry, DateTime>(
        name: "Water Level (%)",
        dataSource: filteredData..sort((a, b) => a.date.compareTo(b.date)),
        xValueMapper: (DataEntry entry, _) => entry.date,
        yValueMapper: (DataEntry entry, _) => entry.value,
        color: Color(0xFF91D9E9),
      ),
    ],
  );
}

Future<SfCartesianChart> getChartStarr(
    String? channel,
    String value,
    String length,
    String breadth,
    String height,
    String radius,
    double capacity,
    bool isCuboid) async {
  String url = await getAPIUrlStarr(channel);
  // String url =
  //     "https://api.thingspeak.com/channels/2086669/fields/6.json?api_key=F0QFTNP2WB3II639";
  if (value == "Weekly") {
    url = url + "&days=7&average=720&timezone=Asia/Kolkata";
  } else if (value == "Monthly") {
    url = url + "&days=30&average=daily&timezone=Asia/Kolkata";
  } else {
    url = url + "&minutes=1440&timescale=60&timezone=Asia/Kolkata";
  }
  String jsonData = await fetchData(url);
  List<DataEntry> filteredData = convertDataFormatStarr(
      jsonData, value, length, breadth, height, radius, capacity, isCuboid);
  // double minValue = filteredData.isNotEmpty
  //     ? filteredData.map((entry) => entry.value).reduce((a, b) => a < b ? a : b)
  //     : 0;
  return SfCartesianChart(
    tooltipBehavior: TooltipBehavior(enable: true),
    primaryXAxis: DateTimeAxis(
      labelStyle: TextStyle(fontSize: 9),
      majorGridLines:
          MajorGridLines(width: 0.3, color: Colors.grey.withOpacity(0.7)),
      minorGridLines:
          MinorGridLines(width: 0.2, color: Colors.grey.withOpacity(0.5)),
    ),
    primaryYAxis: NumericAxis(
      // minimum: minValue,
      anchorRangeToVisiblePoints: false,
      labelStyle: TextStyle(fontSize: 9),
      majorGridLines:
          MajorGridLines(width: 0.3, color: Colors.grey.withOpacity(0.7)),
      minorGridLines:
          MinorGridLines(width: 0.2, color: Colors.grey.withOpacity(0.5)),
    ),
    series: <ChartSeries<DataEntry, DateTime>>[
      LineSeries<DataEntry, DateTime>(
        name: "Water Level (%)",
        dataSource: filteredData..sort((a, b) => a.date.compareTo(b.date)),
        xValueMapper: (DataEntry entry, _) => entry.date,
        yValueMapper: (DataEntry entry, _) => entry.value,
        color: Color(0xFF91D9E9),
      ),
    ],
  );
}

Future<SfCartesianChart> getChartPravahRate(
    String? channel, String value) async {
  String url = await getAPIUrlPravahRate(channel);
  // String url =
  //     "https://api.thingspeak.com/channels/1455035/fields/2.json?api_key=9KRNLG9REQBBTTVC";
  if (value == "Weekly") {
    url = url + "&days=7&timezone=Asia/Kolkata";
  } else if (value == "Monthly") {
    url = url + "&days=30&timezone=Asia/Kolkata";
  } else {
    url = url + "&minutes=1440&timezone=Asia/Kolkata";
  }
  String jsonData = await fetchData(url);
  List<DataEntry> filteredData = convertDataFormatPravahRate(jsonData, value);
  // double minValue = filteredData.isNotEmpty
  //     ? filteredData.map((entry) => entry.value).reduce((a, b) => a < b ? a : b)
  //     : 0;
  return SfCartesianChart(
    tooltipBehavior: TooltipBehavior(enable: true),
    primaryXAxis: DateTimeAxis(
      labelStyle: TextStyle(fontSize: 9),
      majorGridLines:
          MajorGridLines(width: 0.3, color: Colors.grey.withOpacity(0.7)),
      minorGridLines:
          MinorGridLines(width: 0.2, color: Colors.grey.withOpacity(0.5)),
    ),
    primaryYAxis: NumericAxis(
      // minimum: minValue,
      anchorRangeToVisiblePoints: false,
      labelStyle: TextStyle(fontSize: 9),
      majorGridLines:
          MajorGridLines(width: 0.3, color: Colors.grey.withOpacity(0.7)),
      minorGridLines:
          MinorGridLines(width: 0.2, color: Colors.grey.withOpacity(0.5)),
    ),
    series: <ChartSeries<DataEntry, DateTime>>[
      LineSeries<DataEntry, DateTime>(
        name: "Flow Rate (kL/hr)",
        dataSource: filteredData..sort((a, b) => a.date.compareTo(b.date)),
        xValueMapper: (DataEntry entry, _) => entry.date,
        yValueMapper: (DataEntry entry, _) => entry.value,
        color: Color(0xFF91D9E9),
      ),
    ],
  );
}

Future<SfCartesianChart> getChartPravahTotal(
    String? channel, String value) async {
  String url = await getAPIUrlPravahTotal(channel);
  // String url =
  //     "https://api.thingspeak.com/channels/1455035/fields/1.json?api_key=9KRNLG9REQBBTTVC";
  if (value == "Weekly") {
    url = url + "&days=7&timescale=720&timezone=Asia/Kolkata";
  } else if (value == "Monthly") {
    url = url + "&days=30&timescale=daily&timezone=Asia/Kolkata";
  } else {
    url = url + "&minutes=1440&timescale=60&timezone=Asia/Kolkata";
  }
  String jsonData = await fetchData(url);
  List<DataEntry> filteredData = convertDataFormatPravahTotal(jsonData, value);
  // double minValue = filteredData.isNotEmpty
  //     ? filteredData.map((entry) => entry.value).reduce((a, b) => a < b ? a : b)
  //     : 0;
  return SfCartesianChart(
    tooltipBehavior: TooltipBehavior(enable: true),
    primaryXAxis: DateTimeAxis(
      labelStyle: TextStyle(fontSize: 9),
      majorGridLines:
          MajorGridLines(width: 0.3, color: Colors.grey.withOpacity(0.7)),
      minorGridLines:
          MinorGridLines(width: 0.2, color: Colors.grey.withOpacity(0.5)),
    ),
    primaryYAxis: NumericAxis(
      // minimum: minValue,
      anchorRangeToVisiblePoints: false,
      labelStyle: TextStyle(fontSize: 9),
      majorGridLines:
          MajorGridLines(width: 0.3, color: Colors.grey.withOpacity(0.7)),
      minorGridLines:
          MinorGridLines(width: 0.2, color: Colors.grey.withOpacity(0.5)),
    ),
    series: <ChartSeries<DataEntry, DateTime>>[
      LineSeries<DataEntry, DateTime>(
        name: "Total Flow (L)",
        dataSource: filteredData..sort((a, b) => a.date.compareTo(b.date)),
        xValueMapper: (DataEntry entry, _) => entry.date,
        yValueMapper: (DataEntry entry, _) => entry.value,
        color: Color(0xFF91D9E9),
      ),
    ],
  );
}

Future<String> getAPIUrlDebore(String? channel) async {
  channel = channel ?? "NA";
  if (channel == "NA") {
    return "https://thingspeak.com/";
  } else {
    String a = "https://thingspeak.com/channels/";
    String c = "/fields/1.json?api_key=";
    return a + generateChannelID(channel) + c + generateReadAPI(channel);
  }
}

Future<String> getAPIUrlStarr(String? channel) async {
  channel = channel ?? "NA";
  if (channel == "NA") {
    return "https://thingspeak.com/";
  } else {
    String a = "https://thingspeak.com/channels/";
    String c = "/fields/6.json?api_key=";
    return a + generateChannelID(channel) + c + generateReadAPI(channel);
  }
}

Future<String> getAPIUrlPravahRate(String? channel) async {
  channel = channel ?? "NA";
  if (channel == "NA") {
    return "https://thingspeak.com/";
  } else {
    String a = "https://thingspeak.com/channels/";
    String c = "/fields/2.json?api_key=";
    return a + generateChannelID(channel) + c + generateReadAPI(channel);
  }
}

Future<String> getAPIUrlPravahTotal(String? channel) async {
  channel = channel ?? "NA";
  if (channel == "NA") {
    return "https://thingspeak.com/";
  } else {
    String a = "https://thingspeak.com/channels/";
    String c = "/fields/1.json?api_key=";
    return a + generateChannelID(channel) + c + generateReadAPI(channel);
  }
}

Future<String> fetchData(String apiUrl) async {
  http.Response response = await http.get(Uri.parse(apiUrl));
  return response.body;
}

List<DataEntry> convertDataFormatStarr(
    String jsonData,
    String value,
    String length,
    String breadth,
    String height,
    String radius,
    double capacity,
    bool isCuboid) {
  List<DataEntry> dataEntries = [];
  try {
    Map<String, dynamic> jsonMap = jsonDecode(jsonData, reviver: (key, value) {
      if (value == null) {
        return "No Value"; // Exclude null values from the decoded JSON object
      }
      return value;
    });
    if (jsonMap.containsKey('feeds')) {
      List<dynamic> feeds = jsonMap['feeds'];
      for (dynamic feed in feeds) {
        if (feed is Map<String, dynamic>) {
          if (feed.containsKey('created_at') && feed.containsKey('field6')) {
            DateTime? createdAt = DateTime.tryParse(feed['created_at']);
            double? field6 = double.tryParse(feed['field6']);

            if (createdAt != null && field6 != null) {
              // calculate the water % here.
              double level = tankAPI(
                      calculateWaterAvailable(
                          length, breadth, height, radius, field6, isCuboid),
                      capacity) *
                  100;
              DataEntry dataEntry = DataEntry(createdAt, level);
              // DataEntry dataEntry = DataEntry(createdAt, field6);
              dataEntries.add(dataEntry);
            }
          }
        }
      }
    }
  } catch (e) {
    // print('Error decoding JSON: $e');
  }
  if (value == "Weekly") {
    return getWeeklyDataStarr(dataEntries);
  } else if (value == "Monthly") {
    return getMonthlyDataStarr(dataEntries);
  }
  return getDailyDataStarr(dataEntries);
}

List<DataEntry> convertDataFormatPravahRate(String jsonData, String value) {
  List<DataEntry> dataEntries = [];
  try {
    Map<String, dynamic> jsonMap = jsonDecode(jsonData, reviver: (key, value) {
      if (value == null) {
        return "No Value"; // Exclude null values from the decoded JSON object
      }
      return value;
    });
    if (jsonMap.containsKey('feeds')) {
      List<dynamic> feeds = jsonMap['feeds'];
      for (dynamic feed in feeds) {
        if (feed is Map<String, dynamic>) {
          if (feed.containsKey('created_at') && feed.containsKey('field2')) {
            DateTime? createdAt = DateTime.tryParse(feed['created_at']);
            double? field2 = double.tryParse(feed['field2']);

            if (createdAt != null && field2 != null) {
              DataEntry dataEntry = DataEntry(createdAt, field2);
              dataEntries.add(dataEntry);
            }
          }
        }
      }
    }
  } catch (e) {
    // print('Error decoding JSON: $e');
  }
  if (value == "Weekly") {
    return getWeeklyDataPravahRate(dataEntries);
  } else if (value == "Monthly") {
    return getMonthlyDataPravahRate(dataEntries);
  }
  return getDailyDataPravahRate(dataEntries);
}

List<DataEntry> convertDataFormatDebore(String jsonData, String value) {
  List<DataEntry> dataEntries = [];
  try {
    Map<String, dynamic> jsonMap = jsonDecode(jsonData, reviver: (key, value) {
      if (value == null) {
        return "No Value"; // Exclude null values from the decoded JSON object
      }
      return value;
    });
    if (jsonMap.containsKey('feeds')) {
      List<dynamic> feeds = jsonMap['feeds'];
      for (dynamic feed in feeds) {
        if (feed is Map<String, dynamic>) {
          if (feed.containsKey('created_at') && feed.containsKey('field1')) {
            DateTime? createdAt = DateTime.tryParse(feed['created_at']);
            double? field1 = double.tryParse(feed['field1']);

            if (createdAt != null && field1 != null) {
              // calculate the water % here.
              // double level = tankAPI(
              //         calculateWaterAvailable(
              //             length, breadth, height, radius, field6, isCuboid),
              //         capacity) *
              //     100;
              // double depth = 200.3;
              DataEntry dataEntry = DataEntry(createdAt, field1);
              // DataEntry dataEntry = DataEntry(createdAt, field6);
              dataEntries.add(dataEntry);
            }
          }
        }
      }
    }
  } catch (e) {
    // print('Error decoding JSON: $e');
  }
  if (value == "Weekly") {
    return getWeeklyDataDebore(dataEntries);
  } else if (value == "Monthly") {
    return getMonthlyDataDebore(dataEntries);
  }
  return getDailyDataDebore(dataEntries);
}

List<DataEntry> convertDataFormatPravahTotal(String jsonData, String value) {
  List<DataEntry> dataEntries = [];
  try {
    Map<String, dynamic> jsonMap = jsonDecode(jsonData, reviver: (key, value) {
      if (value == null) {
        return "No Value"; // Exclude null values from the decoded JSON object
      }
      return value;
    });
    if (jsonMap.containsKey('feeds')) {
      List<dynamic> feeds = jsonMap['feeds'];
      for (dynamic feed in feeds) {
        if (feed is Map<String, dynamic>) {
          if (feed.containsKey('created_at') && feed.containsKey('field1')) {
            DateTime? createdAt = DateTime.tryParse(feed['created_at']);
            double? field1 = double.tryParse(feed['field1']);

            if (createdAt != null && field1 != null) {
              DataEntry dataEntry = DataEntry(createdAt, field1);
              dataEntries.add(dataEntry);
            }
          }
        }
      }
    }
  } catch (e) {
    // print('Error decoding JSON: $e');
  }
  if (value == "Weekly") {
    return getWeeklyDataPravahTotal(dataEntries);
  } else if (value == "Monthly") {
    return getMonthlyDataPravahTotal(dataEntries);
  }
  return getDailyDataPravahTotal(dataEntries);
}

List<DataEntry> getDailyDataDebore(List<DataEntry> dataEntries) {
  DateTime currentDate = DateTime.now();
  DateTime startDate = currentDate.subtract(Duration(days: 1));

  List<DataEntry> filteredData =
      dataEntries.where((entry) => entry.date.isAfter(startDate)).toList();
  return filteredData;
}

List<DataEntry> getDailyDataStarr(List<DataEntry> dataEntries) {
  DateTime currentDate = DateTime.now();
  DateTime startDate = currentDate.subtract(Duration(days: 1));

  List<DataEntry> filteredData =
      dataEntries.where((entry) => entry.date.isAfter(startDate)).toList();
  return filteredData;
}

List<DataEntry> getDailyDataPravahRate(List<DataEntry> dataEntries) {
  DateTime currentDate = DateTime.now();
  DateTime startDate = currentDate.subtract(Duration(days: 1));

  List<DataEntry> filteredData =
      dataEntries.where((entry) => entry.date.isAfter(startDate)).toList();
  return filteredData;
}

List<DataEntry> getDailyDataPravahTotal(List<DataEntry> dataEntries) {
  DateTime currentDate = DateTime.now();
  DateTime startDate = currentDate.subtract(Duration(days: 1));

  List<DataEntry> filteredData =
      dataEntries.where((entry) => entry.date.isAfter(startDate)).toList();
  return filteredData;
}

List<DataEntry> getWeeklyDataDebore(List<DataEntry> dataEntries) {
  DateTime currentDate = DateTime.now();
  DateTime startDate = currentDate.subtract(Duration(days: 7));

  List<DataEntry> filteredData =
      dataEntries.where((entry) => entry.date.isAfter(startDate)).toList();

  return filteredData;
}

List<DataEntry> getWeeklyDataStarr(List<DataEntry> dataEntries) {
  DateTime currentDate = DateTime.now();
  DateTime startDate = currentDate.subtract(Duration(days: 7));

  List<DataEntry> filteredData =
      dataEntries.where((entry) => entry.date.isAfter(startDate)).toList();

  return filteredData;
}

List<DataEntry> getWeeklyDataPravahRate(List<DataEntry> dataEntries) {
  DateTime currentDate = DateTime.now();
  DateTime startDate = currentDate.subtract(Duration(days: 7));

  List<DataEntry> filteredData =
      dataEntries.where((entry) => entry.date.isAfter(startDate)).toList();

  return filteredData;
}

List<DataEntry> getWeeklyDataPravahTotal(List<DataEntry> dataEntries) {
  DateTime currentDate = DateTime.now();
  DateTime startDate = currentDate.subtract(Duration(days: 7));

  List<DataEntry> filteredData =
      dataEntries.where((entry) => entry.date.isAfter(startDate)).toList();
  return filteredData;
}

List<DataEntry> getMonthlyDataDebore(List<DataEntry> dataEntries) {
  DateTime currentDate = DateTime.now();
  DateTime startDate = currentDate.subtract(Duration(days: 30));

  List<DataEntry> filteredData =
      dataEntries.where((entry) => entry.date.isAfter(startDate)).toList();

  return filteredData;
}

List<DataEntry> getMonthlyDataStarr(List<DataEntry> dataEntries) {
  DateTime currentDate = DateTime.now();
  DateTime startDate = currentDate.subtract(Duration(days: 30));

  List<DataEntry> filteredData =
      dataEntries.where((entry) => entry.date.isAfter(startDate)).toList();

  return filteredData;
}

List<DataEntry> getMonthlyDataPravahRate(List<DataEntry> dataEntries) {
  DateTime currentDate = DateTime.now();
  DateTime startDate = currentDate.subtract(Duration(days: 30));

  List<DataEntry> filteredData =
      dataEntries.where((entry) => entry.date.isAfter(startDate)).toList();

  return filteredData;
}

List<DataEntry> getMonthlyDataPravahTotal(List<DataEntry> dataEntries) {
  DateTime currentDate = DateTime.now();
  DateTime startDate = currentDate.subtract(Duration(days: 30));

  List<DataEntry> filteredData =
      dataEntries.where((entry) => entry.date.isAfter(startDate)).toList();
  return filteredData;
}

class DataEntry {
  final DateTime date;
  final double value;

  DataEntry(this.date, this.value);
}
