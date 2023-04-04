import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rentease/controller/signout/signout_function.dart';
import 'package:rentease/model/signupmodel/mobx/signup_model.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/home_page.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});
  static final SignUpModel signupmodel = SignUpModel();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return signupmodel.isEmailVerified
          ? const MainScreen()
          : Scaffold(
              appBar: const PreferredSize(
                  preferredSize: Size.fromHeight(60),
                  child: AppBarWidget(title: appName)),
              body: FutureBuilder(
                future: signupmodel.verifyEmail(context: context),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // The verification is complete, so show the main UI.
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'A verification email has been sent to your email',
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.center,
                            ),
                            kheight20,
                            ElevatedButton.icon(
                              onPressed: () {
                                signupmodel.canSendEmail
                                    ? signupmodel.sendVerificationEmail()
                                    : null;
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kOrange900,
                                  minimumSize: const Size.fromHeight(50)),
                              icon: const Icon(Icons.mail),
                              label: const Text("Resend Email"),
                            ),
                            kheight20,
                            TextButton(
                                onPressed: () {
                                  signupmodel.timer?.cancel();
                                  signOutFunc(context: context);
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50)),
                                child: const Text(
                                  cancelText,
                                  style: TextStyle(fontSize: 15.0),
                                ))
                          ],
                        ),
                      ),
                    );
                  } else {
                    // The verification is still in progress, so show a loading spinner.
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            );
    });
  }

  // Future checkEmailVerified() async {

  //   signupmodel.isEmailVerified = FirebaseAuth.instance.currentUser;
  // }
}
