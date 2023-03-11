import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/view/core/utils.dart';
import 'package:rentease/view/homepage/home_page.dart';
import 'package:rentease/view/loginpage/widgets/login_page_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'RentEase',
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
                child: Text("Something went wrong!"),
              );
            } else if (snapshot.hasData) {
              return const MainScreen();
            } else {
              return const LoginPage();
              //AuthPage();
            }
          },
        ),
      );
}

// class BoxDecWidget extends StatelessWidget {
//   const BoxDecWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BoxDecoration(
//       gradient: LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [Colors.orange[900]!, Colors.orange[800]!, Colors.orange[400]!],
//       ),
//     );

//   }
// }
boxDecoration() => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.orange[900]!, Colors.orange[800]!, Colors.orange[400]!],
      ),
    );
