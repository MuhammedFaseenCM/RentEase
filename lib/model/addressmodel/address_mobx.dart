import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'address_mobx.g.dart';

class AddressModel = _AddressModel with _$AddressModel;

abstract class _AddressModel with Store {
  TextEditingController houseNameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  GlobalKey<FormState> addressKey = GlobalKey<FormState>();

  @observable
  TextEditingController stateController = TextEditingController();

  FocusNode focusNode = FocusNode();

  @observable
  String selectedState = '';

  @action
  void setSelectedState(String value) {
    stateController.text = value;
  }
}
