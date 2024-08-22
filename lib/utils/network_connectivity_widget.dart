import 'package:flutter/material.dart';

class NetworkConnectivityWidget extends StatelessWidget {
  const NetworkConnectivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: const Color.fromARGB(255, 84, 78, 78),
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, color: Colors.white, size: 30),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'No internet. Check your internet connection.',
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
