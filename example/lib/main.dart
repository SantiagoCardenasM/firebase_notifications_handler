import 'package:flutter/material.dart';
import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: add firebase_core and call
  // await Firebase.initializeApp();
  runApp(_MainApp());
}

String? fcmToken;

class _MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: FirebaseNotificationsHandler.navigatorKey,
      home: _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseNotificationsHandler(
      onOpenNotificationArrive: (_, payload) {
        print("Notification received while app is open with payload $payload");
      },
      onTap: (navigatorState, appState, payload) {
        print("Notification tapped with $appState & payload $payload");

        navigatorState.currentState!.pushNamed('newRouteName');
        // OR
        final context = navigatorState.currentContext!;
        Navigator.pushNamed(context, 'newRouteName');
      },
      onFCMTokenInitialize: (_, token) => fcmToken = token,
      onFCMTokenUpdate: (_, token) {
        fcmToken = token;
        // await User.updateFCM(token);
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Text(
              '_HomeScreen',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
      ),
    );
  }
}
