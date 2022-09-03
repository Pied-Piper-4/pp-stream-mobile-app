import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pp_stream_mobile_app/app.dart';
import 'package:pp_stream_mobile_app/firebase_options.dart';
import 'package:pp_stream_mobile_app/utils/interfaces/user.dart';
import 'package:pp_stream_mobile_app/utils/shared_preferences.dart';

Future<void> main() async {
  await init();
  final UserLogged? userData = await PPStreamSharedPreference.initState();
  runApp(
    App(
      userLoggedAndData: userData,
    ),
  );
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
}
