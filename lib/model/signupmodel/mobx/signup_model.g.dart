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

  late final _$pickImageAsyncAction =
      AsyncAction('_SignUpModelBase.pickImage', context: context);

  @override
  Future<void> pickImage({required dynamic source, required dynamic context}) {
    return _$pickImageAsyncAction
        .run(() => super.pickImage(source: source, context: context));
  }

  late final _$_SignUpModelBaseActionController =
      ActionController(name: '_SignUpModelBase', context: context);

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
  String toString() {
    return '''
picture: ${picture},
signupformKey: ${signupformKey},
passwordVisible: ${passwordVisible}
    ''';
  }
}
