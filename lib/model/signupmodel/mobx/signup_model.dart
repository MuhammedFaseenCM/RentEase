import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

part 'signup_model.g.dart';

class SignUpModel = _SignUpModelBase with _$SignUpModel;

abstract class _SignUpModelBase with Store {
  TextEditingController signupemailController = TextEditingController();
  TextEditingController signuppasswordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @observable
  TextEditingController codeController = TextEditingController();

  late TwilioFlutter twilioFlutter;
  var sendOTP;

  @observable
  String userOtp = '';

  @action
  void updateUserOtp(String value) {
    if (value != null) {
      userOtp = value;
      print("\n\nn\n\n\n\n\n\n\n\n\$value \n\n\n\n\n\n\n\n\nn\n\n");
    } else {
      userOtp = '54545S';
    }
  }

  @observable
  bool isEmailVerified = false;

  @observable
  bool canSendEmail = false;

  @observable
  Timer? timer;

  @action
  Future<void> verifyEmail({required context}) async {
    // await FirebaseAuth.instance.currentUser!.reload();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(const Duration(seconds: 3), (_) {
        checkEmailVerified(context: context);
      });
    }
  }

  @action
  Future<void> checkEmailVerified({required context}) async {
    await FirebaseAuth.instance.currentUser!.reload();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @action
  Future<void> sendVerificationEmail() async {
    try {
      canSendEmail = false;
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification().then((value) => canSendEmail = true);
    } on Exception catch (e) {
      //
    }
  }

  @observable
  bool _passwordVisible = false;

  @computed
  bool get passwordVisible => _passwordVisible;

  final ImagePicker picker = ImagePicker();

  @action
  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
  }

  @observable
  String picture = '';

  @action
  Future<void> pickImage({required source, required context}) async {
    final image = await picker.pickImage(source: source);
    if (image == null) {
      return;
    }
    picture = image.path;
    Navigator.of(context).pop();
  }

  @action
  void clearAll() {
    fullnameController.clear();
    numberController.clear();
    emailController.clear();
    passwordController.clear();
    confirmpasswordController.clear();
    locationController.clear();
    picture = '';
  }

  @observable
  GlobalKey<FormState> signupformKey = GlobalKey<FormState>();

  @action
  Future<void> sendSMS({required context}) async {
    // showDialog(
    //   context: context,
    //   builder: (context) => const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );
    // twilioFlutter = TwilioFlutter(
    //     accountSid: 'ACeae936b8d46e4887da2a5e209a80e114',
    //     authToken: '29cf8b1b494d423cfeb9b5a76cebfaf6',
    //     twilioNumber: '+15856562282');

    // var rnd = Random();
    // var digits = rnd.nextInt(900000) + 100000;
    // sendOTP = digits;
    // print(sendOTP);
    // final value = await twilioFlutter.sendSMS(
    //     toNumber: "+${country.phoneCode}${numberController.text.trim()}",
    //     messageBody:
    //         "\nHello This is your RentEase 6 digit otp code to verify your phone number : $digits");
    // if (value == 201) {
    //   Get.to(() => OtpScreen(
    //         number: numberController.text.trim(),
    //         otp: sendOTP,
    //       ));
    // }
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  ///[verfy otp]
  @action
  void verifyOTP() {
    if (sendOTP.toString() == codeController.text.trim()) {
      print("OTP verified successfully");
    } else {
      print("OTP didn't match");
    }
  }

  TextEditingController get passwordController => signuppasswordController;

  set passwordController(TextEditingController value) {
    signuppasswordController = value;
  }

  TextEditingController get emailController => signupemailController;

  set emailController(TextEditingController value) {
    signupemailController = value;
  }
}
