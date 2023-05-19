//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'HomePage.dart';
import 'Screens/Gather/Canspeakfuntly.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'globals.dart' as globals;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  globals.appNavgaitor = GlobalKey<NavigatorState>();
  izinleriIste();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  //const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String oneSingalAppId = "63505b10-3492-426b-9dc3-4a5f2c5ddca9";

  @override
  void initState() {
    super.initState();
    OneSignal.shared.setLogLevel(
      OSLogLevel.debug,
      OSLogLevel.none,
    );
    OneSignal.shared.setAppId(
      oneSingalAppId,
    );
  }

  Future<void> configOneSignel() async {
    OneSignal.shared.setAppId(oneSingalAppId);
    var status = await OneSignal.shared.getDeviceState().then((change) {});
    String tokenId = status.subscriptionStatus.userId;
    OneSignal.shared.promptUserForPushNotificationPermission().then(
          (accepted) {},
        );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'English Spoken Cafe',
      navigatorKey: globals.appNavgaitor,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: const [
            HomePages(),
          ],
        ),
      ),
    );
  }
}
