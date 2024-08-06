import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class AddDeviceCall {
  static Future<ApiCallResponse> call({
    String? apiKey = '',
    String? field1 = '',
    String? field2 = '',
    String? field3 = '',
    String? field4 = '',
    String? field5 = '',
    String? field6 = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'addDevice',
      apiUrl: 'https://api.thingspeak.com/update',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'api_key': apiKey,
        'field1': field1, //tankname
        'field2': field2, //breadth
        'field3': field3, //height
        'field4': field4, //length
        'field5': field5, //radius
        'field6': field6 ??
            field3, // if f6 is null then it will take the value of f3 i.e height
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

// TODO: verify this code
class AddDeviceDeboreCall {
  static Future<ApiCallResponse> call({
    String? apiKey = '', //name we choose when we add a pravah device
    String? field2 = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'addDeviceDebore',
      apiUrl: 'https://api.thingspeak.com/update',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'api_key': apiKey,
        'field2': field2,
      },
      returnBody: true,
    );
  }
}

class AddDevicePravahCall {
  static Future<ApiCallResponse> call({
    String? apiKey = '',
    String? field3 = '', //name we choose when we add a pravah device
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'addDevicePravah',
      apiUrl: 'https://api.thingspeak.com/update',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'api_key': apiKey,
        'field3': field3,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar) {
  jsonVar ??= {};
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return '{}';
  }
}
