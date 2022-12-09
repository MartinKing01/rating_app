// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'chip_list.dart';
import 'beer_list.dart';
import 'list_page.dart';

var db = FirebaseFirestore.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final globalScaffoldKey = GlobalKey<ScaffoldState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return MaterialApp(
          scaffoldMessengerKey: scaffoldMessengerKey,
          title: 'BeeR',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('hu', ''),
          ],
          scrollBehavior: MyCustomScrollBehavior(),
          theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: const Color(0xFFFFD02B),
              cardColor: const Color(0xFFFFD02B),
              fontFamily: 'Poppins',
              chipTheme: const ChipThemeData(
                side: BorderSide(),
                backgroundColor: Colors.white,
                selectedColor: Color(0xFFFFD02B),
                showCheckmark: true,
              ),
              iconTheme: const IconThemeData(
                  color: Colors.white
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(constraints.maxHeight/100))),
                      textStyle: const TextStyle(
                        color: Colors.white,
                      )))),
          home: SafeArea(child: ListPage(key: UniqueKey())),
        );
      },
    );
  }
}
