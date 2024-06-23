import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:teledocuser/controllers/appoiment/appoimnet_controller.dart';
import 'package:teledocuser/controllers/payment/payment.dart';
import 'package:teledocuser/firebase_options.dart';
import 'package:teledocuser/controllers/auth/controller.dart';
import 'package:teledocuser/views/widgets/splash_screen/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'video_call_channel',
        channelName: 'Video Call Notifications',
        channelDescription: 'Notification channel for video call',
        defaultColor: Colors.teal,
        ledColor: Colors.white,
      ),
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(Authcontroller());
        Get.put(PaymentController());
        Get.put(AppointmentController());
      }),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const SplashPage(),
    );
  }
}
