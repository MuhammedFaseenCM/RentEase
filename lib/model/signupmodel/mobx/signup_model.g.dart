// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpModel on _SignUpModelBase, Store {
  Computed<bool>? _$passwordVisibleComputed;

  @override
  bool get passwordVisible =>
      (_$passwordVisibleComputed ??= Computed<bool>(() => super.passwordVisible,
              name: '_SignUpModelBase.passwordVisible'))
          .value;

  late final _$codeControllerAtom =
      Atom(name: '_SignUpModelBase.codeController', context: context);

  @override
  TextEditingController get codeController {
    _$codeControllerAtom.reportRead();
    return super.codeController;
  }

  @override
  set codeController(TextEditingController value) {
    _$codeControllerAtom.reportWrite(value, super.codeController, () {
      super.codeController = value;
    });
  }

  late final _$userOtpAtom =
      Atom(name: '_SignUpModelBase.userOtp', context: context);

  @override
  String get userOtp {
    _$userOtpAtom.reportRead();
    return super.userOtp;
  }

  @override
  set userOtp(String value) {
    _$userOtpAtom.reportWrite(value, super.userOtp, () {
      super.userOtp = value;
    });
  }

  late final _$isEmailVerifiedAtom =
      Atom(name: '_SignUpModelBase.isEmailVerified', context: context);

  @override
  bool get isEmailVerified {
    _$isEmailVerifiedAtom.reportRead();
    return super.isEmailVerified;
  }

  @override
  set isEmailVerified(bool value) {
    _$isEmailVerifiedAtom.reportWrite(value, super.isEmailVerified, () {
      super.isEmailVerified = value;
    });
  }

  late final _$canSendEmailAtom =
      Atom(name: '_SignUpModelBase.canSendEmail', context: context);

  @override
  bool get canSendEmail {
    _$canSendEmailAtom.reportRead();
    return super.canSendEmail;
  }

  @override
  set canSendEmail(bool value) {
    _$canSendEmailAtom.reportWrite(value, super.canSendEmail, () {
      super.canSendEmail = value;
    });
  }

  late final _$timerAtom =
      Atom(name: '_SignUpModelBase.timer', context: context);

  @override
  Timer? get timer {
    _$timerAtom.reportRead();
    return super.timer;
  }

  @override
  set timer(Timer? value) {
    _$timerAtom.reportWrite(value, super.timer, () {
      super.timer = value;
    });
  }

  late final _$_passwordVisibleAtom =
      Atom(name: '_SignUpModelBase._passwordVisible', context: context);

  @override
  bool get _passwordVisible {
    _$_passwordVisibleAtom.reportRead();
    return super._passwordVisible;
  }

  @override
  set _passwordVisible(bool value) {
    _$_passwordVisibleAtom.reportWrite(value, super._passwordVisible, () {
      super._passwordVisible = value;
    });
  }

  late final _$pictureAtom =
      Atom(name: '_SignUpModelBase.picture', context: context);

  @override
  String get picture {
    _$pictureAtom.reportRead();
    return super.picture;
  }

  @override
  set picture(String value) {
    _$pictureAtom.reportWrite(value, super.picture, () {
      super.picture = value;
    });
  }

  late final _$signupformKeyAtom =
      Atom(name: '_SignUpModelBase.signupformKey', context: context);

  @override
  GlobalKey<FormState> get signupformKey {
    _$signupformKeyAtom.reportRead();
    return super.signupformKey;
  }

  @override
  set signupformKey(GlobalKey<FormState> value) {
    _$signupformKeyAtom.reportWrite(value, super.signupformKey, () {
      super.signupformKey = value;
    });
  }

  late final _$verifyEmailAsyncAction =
      AsyncAction('_SignUpModelBase.verifyEmail', context: context);

  @override
  Future<void> verifyEmail({required dynamic context}) {
    return _$verifyEmailAsyncAction
        .run(() => super.verifyEmail(context: context));
  }

  late final _$checkEmailVerifiedAsyncAction =
      AsyncAction('_SignUpModelBase.checkEmailVerified', context: context);

  @override
  Future<void> checkEmailVerified({required dynamic context}) {
    return _$checkEmailVerifiedAsyncAction
        .run(() => super.checkEmailVerified(context: context));
  }

  late final _$sendVerificationEmailAsyncAction =
      AsyncAction('_SignUpModelBase.sendVerificationEmail', context: context);

  @override
  Future<void> sendVerificationEmail() {
    return _$sendVerificationEmailAsyncAction
        .run(() => super.sendVerificationEmail());
  }

  late final _$pickImageAsyncAction =
      AsyncAction('_SignUpModelBase.pickImage', context: context);

  @override
  Future<void> pickImage({required dynamic source, required dynamic context}) {
    return _$pickImageAsyncAction
        .run(() => super.pickImage(source: source, context: context));
  }

  late final _$sendSMSAsyncAction =
      AsyncAction('_SignUpModelBase.sendSMS', context: context);

  @override
  Future<void> sendSMS({required dynamic context}) {
    return _$sendSMSAsyncAction.run(() => super.sendSMS(context: context));
  }

  late final _$_SignUpModelBaseActionController =
      ActionController(name: '_SignUpModelBase', context: context);

  @override
  void updateUserOtp(String value) {
    final _$actionInfo = _$_SignUpModelBaseActionController.startAction(
        name: '_SignUpModelBase.updateUserOtp');
    try {
      return super.updateUserOtp(value);
    } finally {
      _$_SignUpModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePasswordVisibility() {
    final _$actionInfo = _$_SignUpModelBaseActionController.startAction(
        name: '_SignUpModelBase.togglePasswordVisibility');
    try {
      return super.togglePasswordVisibility();
    } finally {
      _$_SignUpModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearAll() {
    final _$actionInfo = _$_SignUpModelBaseActionController.startAction(
        name: '_SignUpModelBase.clearAll');
    try {
      return super.clearAll();
    } finally {
      _$_SignUpModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void verifyOTP() {
    final _$actionInfo = _$_SignUpModelBaseActionController.startAction(
        name: '_SignUpModelBase.verifyOTP');
    try {
      return super.verifyOTP();
    } finally {
      _$_SignUpModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
codeController: ${codeController},
userOtp: ${userOtp},
isEmailVerified: ${isEmailVerified},
canSendEmail: ${canSendEmail},
timer: ${timer},
picture: ${picture},
signupformKey: ${signupformKey},
passwordVisible: ${passwordVisible}
    ''';
  }
}
