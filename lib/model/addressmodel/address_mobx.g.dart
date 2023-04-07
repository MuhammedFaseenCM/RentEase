// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddressMobx on _AddressMobx, Store {
  late final _$stateControllerAtom =
      Atom(name: '_AddressMobx.stateController', context: context);

  @override
  TextEditingController get stateController {
    _$stateControllerAtom.reportRead();
    return super.stateController;
  }

  @override
  set stateController(TextEditingController value) {
    _$stateControllerAtom.reportWrite(value, super.stateController, () {
      super.stateController = value;
    });
  }

  late final _$selectedStateAtom =
      Atom(name: '_AddressMobx.selectedState', context: context);

  @override
  String get selectedState {
    _$selectedStateAtom.reportRead();
    return super.selectedState;
  }

  @override
  set selectedState(String value) {
    _$selectedStateAtom.reportWrite(value, super.selectedState, () {
      super.selectedState = value;
    });
  }

  late final _$_AddressMobxActionController =
      ActionController(name: '_AddressMobx', context: context);

  @override
  void setSelectedState(String value) {
    final _$actionInfo = _$_AddressMobxActionController.startAction(
        name: '_AddressMobx.setSelectedState');
    try {
      return super.setSelectedState(value);
    } finally {
      _$_AddressMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
stateController: ${stateController},
selectedState: ${selectedState}
    ''';
  }
}
