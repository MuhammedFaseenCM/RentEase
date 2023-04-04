// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeMobx on _HomeMobx, Store {
  Computed<Stream<QuerySnapshot<Object?>>>? _$documentStreamComputed;

  @override
  Stream<QuerySnapshot<Object?>> get documentStream =>
      (_$documentStreamComputed ??= Computed<Stream<QuerySnapshot<Object?>>>(
              () => super.documentStream,
              name: '_HomeMobx.documentStream'))
          .value;

  late final _$selectedIndexAtom =
      Atom(name: '_HomeMobx.selectedIndex', context: context);

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  late final _$selectedCategoryAtom =
      Atom(name: '_HomeMobx.selectedCategory', context: context);

  @override
  String get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(String value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  late final _$_HomeMobxActionController =
      ActionController(name: '_HomeMobx', context: context);

  @override
  void changeCategory(int index) {
    final _$actionInfo = _$_HomeMobxActionController.startAction(
        name: '_HomeMobx.changeCategory');
    try {
      return super.changeCategory(index);
    } finally {
      _$_HomeMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectCategory(String category) {
    final _$actionInfo = _$_HomeMobxActionController.startAction(
        name: '_HomeMobx.selectCategory');
    try {
      return super.selectCategory(category);
    } finally {
      _$_HomeMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedIndex: ${selectedIndex},
selectedCategory: ${selectedCategory},
documentStream: ${documentStream}
    ''';
  }
}
