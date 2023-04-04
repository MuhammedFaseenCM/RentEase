// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderModel on _OrderModel, Store {
  Computed<double>? _$averageRatingComputed;

  @override
  double get averageRating =>
      (_$averageRatingComputed ??= Computed<double>(() => super.averageRating,
              name: '_OrderModel.averageRating'))
          .value;

  late final _$ratingAtom = Atom(name: '_OrderModel.rating', context: context);

  @override
  double get rating {
    _$ratingAtom.reportRead();
    return super.rating;
  }

  @override
  set rating(double value) {
    _$ratingAtom.reportWrite(value, super.rating, () {
      super.rating = value;
    });
  }

  late final _$ratingsAtom =
      Atom(name: '_OrderModel.ratings', context: context);

  @override
  ObservableList<double> get ratings {
    _$ratingsAtom.reportRead();
    return super.ratings;
  }

  @override
  set ratings(ObservableList<double> value) {
    _$ratingsAtom.reportWrite(value, super.ratings, () {
      super.ratings = value;
    });
  }

  late final _$fetchRatingsAsyncAction =
      AsyncAction('_OrderModel.fetchRatings', context: context);

  @override
  Future<void> fetchRatings(
      {required dynamic ownerEmail, required dynamic title}) {
    return _$fetchRatingsAsyncAction
        .run(() => super.fetchRatings(ownerEmail: ownerEmail, title: title));
  }

  late final _$_OrderModelActionController =
      ActionController(name: '_OrderModel', context: context);

  @override
  void setRating(double value) {
    final _$actionInfo = _$_OrderModelActionController.startAction(
        name: '_OrderModel.setRating');
    try {
      return super.setRating(value);
    } finally {
      _$_OrderModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
rating: ${rating},
ratings: ${ratings},
averageRating: ${averageRating}
    ''';
  }
}
