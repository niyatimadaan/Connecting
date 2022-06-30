import 'dart:async';
import 'dart:isolate';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'fetchDB.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bottom_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// void main() async {
//   runZonedGuarded<Future<void>>(() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp();
//     // The following lines are the same as previously explained in "Handling uncaught errors"
//     FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
//
//     runApp(tryfirestore());
//   }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  await FirebaseCrashlytics.instance.recordError(
    'No error',
    StackTrace.empty,
    reason: 'a non-fatal error',
  );
  runApp(tryfirestore());
}



class tryfirestore extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
        fatal: true,
      );
    }).sendPort);

    // Set a key to a string.
    FirebaseCrashlytics.instance.setCustomKey('str_key', 'error',);
    // try {
    //   throw 'error_example';
    // } catch (e, s) {
    //   FirebaseCrashlytics.instance.recordError(e, s);
    // }
    // Set a key to a boolean.

    FirebaseCrashlytics.instance.log('1.0');
    //FirebaseCrashlytics.instance.logException("Woo");
    FirebaseCrashlytics.instance.setUserIdentifier("12345");


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: navigationBar(),
    );
  }
}