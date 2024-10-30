import 'package:flutter/material.dart';
import 'package:hydrow/backend/backend.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:dio/dio.dart';

class DeboreResponseWidget extends StatelessWidget {
  final List<String> deboreKeyList;
  final List<String> deboreNameList;
  const DeboreResponseWidget({
    super.key,
    required this.deboreKeyList,
    required this.deboreNameList,
  });

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
                  return ListTile(
                    title: Text(deboreKeyList[index]),
                    leading: Text(deboreNameList[index]),
                  );
                },
                itemCount: deboreKeyList.length),
          ),
          ElevatedButton(
            onPressed: () async {
              Map<String, dynamic> errorCodes = await findTimeWiseErrorCode(
                  'errorCodeDboreTesting', deboreKeyList);
              print(errorCodes);
            },
            child: const Text("Read db"),
          ),
        ],
      ),
    );
  }
}
