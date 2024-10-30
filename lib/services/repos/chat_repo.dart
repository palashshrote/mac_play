import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hydrow/services/constants.dart';
import 'package:hydrow/services/models/chat_message_model.dart';

class ChatRepo {
  // static chatTextGenerationRepo(List<ChatMessageModel> previousMessages) async {

  static Future<String> chatTextGenerationRepo(String input, String keysName) async {
    try {
      Dio dio = Dio();

      final response = await dio.post(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${API_KEY}',
        data: {
          // "contents": previousMessages.map((e) => e.toMap()).toList(),
          "contents": [
            {
              "role": "user",
              "parts": [
                // {"text": "Can you tell me about How can I improve badminton?"}
                {
                  // "text":
                  //     "Interprete the data below which contains the date and device keys which contains the date and error code -1 means error and 0 means inconsistent data ${input}
                  //     below you can find the name of device which is in a map ${keysName} Can you summarised and use the device name instead of key"
                  "text":
                      '''Interpret the data below till this time, which contains the date and device keys. Error code -1 means error, and 0 means 
                      inconsistent data, and device key with empty data then it means that device is working perfectly fine 
                      till now: $input. Below, you can find the name of the device in a map: $keysName. Can you summarize and 
                      use the device name instead of the key?'''
                }
              ]
            },
          ],
          "generationConfig": {
            "temperature": 0.4,
            "topK": 64,
            "topP": 0.95,
            "maxOutputTokens": 8192,
            "responseMimeType": "text/plain",
          },
        },
      );
      // print(response.toString());
      final Map<String, dynamic> jsonResponse = jsonDecode(response.toString());

      // Access the text inside "candidates" -> "content" -> "parts"
      final String extractedText =
          jsonResponse['candidates'][0]['content']['parts'][0]['text'];

      print(extractedText);
      return extractedText;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }
}
