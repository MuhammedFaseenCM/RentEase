import 'package:flutter/material.dart';
import 'package:get/get.dart';



class AddressController extends GetxController {
  TextEditingController houseNameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  GlobalKey<FormState> addressKey = GlobalKey<FormState>();

  
  TextEditingController stateController = TextEditingController();

  FocusNode focusNode = FocusNode();

  String selectedState = '';


  void setSelectedState(String value) {
    stateController.text = value;
  }
}
