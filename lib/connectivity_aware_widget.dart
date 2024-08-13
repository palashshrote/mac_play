import 'package:hydrow/before_dashboard.dart';
import 'package:hydrow/dashboard/dashboard_widget.dart';
import 'package:hydrow/flutter_flow/flutter_flow_util.dart';
import 'package:hydrow/log_in_sign_up/log_in_sign_up_widget.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityAwareWidget extends StatefulWidget {
  final AppStateNotifier appStateNotifier;
  ConnectivityAwareWidget({required this.appStateNotifier});
  @override
  _ConnectivityAwareWidgetState createState() => _ConnectivityAwareWidgetState();
}

class _ConnectivityAwareWidgetState extends State<ConnectivityAwareWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<InternetConnectionStatus>(
      stream: InternetConnectionCheckerPlus().onStatusChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final isConnected = snapshot.data == InternetConnectionStatus.connected;

          // If the user is connected and logged in, navigate to the DashboardWidget
          if (isConnected && widget.appStateNotifier.loggedIn) {
            Future.microtask(() => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardWidget()),
            ));
          }

          // Display BeforeDashboard if not connected, or the LogInSignUpWidget if not logged in
          return isConnected
              ? widget.appStateNotifier.loggedIn
              ? DashboardWidget() // This should be a fallback; should not reach here.
              : LogInSignUpWidget()
              : BeforeDashboard();
        } else {
          // Show a loading indicator while the connection status is being checked
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
