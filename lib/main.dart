// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rentease/model/languagemodel/lang_model.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:rentease/view/localization/l10n.dart';
import 'package:rentease/view/loginpage/login_screen.dart';
import 'package:rentease/view/signuppage/widget/verify_email.dart';
import 'package:flutter_localizations/src/material_localizations.dart';
import 'package:flutter_localizations/src/cupertino_localizations.dart';
import 'package:flutter_localizations/src/widgets_localizations.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        return Consumer(builder: (context, provider, child) {
          return GetMaterialApp(
            scaffoldMessengerKey: Utils.messengerKey,
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: appName,
            theme: ThemeData(primarySwatch: Colors.blueGrey),
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(wrongText),
                  );
                } else if (snapshot.hasData) {
                  return const VerifyEmailScreen();
                } else {
                  return const LoginPage();
                  //AuthPage();
                }
              },
            ),
            locale: Provider.of<LocaleProvider>(context).locale ??
                const Locale('en'),
            supportedLocales: L10n.all,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
          );
        });
      });
}

const boxDecoration = BoxDecoration(
  color: kwhiteColor,
);
