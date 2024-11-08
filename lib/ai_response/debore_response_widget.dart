/*
import 'package:flutter/material.dart';
import 'package:hydrow/backend/backend.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:dio/dio.dart';
import 'package:hydrow/services/repos/chat_repo.dart';

class DeboreResponseWidget extends StatelessWidget {
  // final List<String> deboreKeyList;
  // final List<String> deboreNameList;
  final Map<String, String> keysNameMap;
  const DeboreResponseWidget({
    super.key,
    // required this.deboreKeyList,
    // required this.deboreNameList,
    required this.keysNameMap,
  });
  void generateChatResponse(
      {required String input, required String keysName}) async {
    await ChatRepo.chatTextGenerationRepo(input, keysName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gemini response"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final key = keysNameMap.keys.elementAt(index);
                  final value = keysNameMap[key]!;
                  return ListTile(
                    title: Text(key),
                    leading: Text(value),
                  );
                },
                itemCount: keysNameMap.length),
          ),
          ElevatedButton(
            onPressed: () async {
              // Map<String, dynamic> errorCodes = await findTimeWiseErrorCode(
              //     'errorCodeDboreTesting', deboreKeyList);
              Map<String, dynamic> errorCodes = await findTimeWiseErrorCode2(
                  'errorCodeDboreTesting', keysNameMap);
              print(errorCodes);
              print(keysNameMap);
              generateChatResponse(
                  input: errorCodes.toString(), keysName: keysNameMap.toString());
            },
            child: const Text("Read db"),
          ),
        ],
      ),
    );
  }
}
*/