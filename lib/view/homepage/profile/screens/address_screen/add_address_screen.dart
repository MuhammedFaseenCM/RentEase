import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/view/address/address_controller.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/main_screen.dart';

class AddAddressWidget extends StatelessWidget {
  final bool? isEditAddress;
  final Map<String, dynamic>? addressMap;
  final int? index;
  const AddAddressWidget(
      {super.key, this.isEditAddress = false, this.addressMap, this.index});
  static final AddressController addressModel = AddressController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(title: "Add address"),
      ),
      body: CustomContainer(
        child: SingleChildScrollView(
          child: Form(
            key: addressModel.addressKey,
            child: Column(children: [
              kheight20,
              kheight20,
              TextFormField(
                controller: addressModel.houseNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "House.no/name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please provide the necessary details";
                  }
                  return null;
                },
              ),
              kheight20,
              TextFormField(
                controller: addressModel.areaController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Road name,Area,Colony"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please provide the necessary details";
                  }
                  return null;
                },
              ),
              kheight20,
              TextFormField(
                controller: addressModel.cityController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "City"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please provide the necessary details";
                  }
                  return null;
                },
              ),
              kheight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 120.0,
                    child: TextFormField(
                      controller: addressModel.pincodeController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Pincode"),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide the necessary details";
                        } else if (value.length != 6) {
                          return 'Pincode should be a 6 digit number';
                        }
                        return null;
                      },
                    ),
                  ),
                  kwidth20,
                SizedBox(
                      width: 120.0,
                      child: TextFormField(
                        controller: addressModel.stateController,
                        onTap: () {
                          showStateSelectorDialog(context: context);
                        },
                        focusNode: addressModel.focusNode,
                        readOnly: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "State"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please provide the necessary details";
                          }
                          return null;
                        },
                      ),
                    
                  ),
                ],
              ),
              kheight20,
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () async {
                    final isValid =
                        addressModel.addressKey.currentState!.validate();
                    if (!isValid) return;

                      addAddress(context: context);
                    
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: kOrange900),
                  child: const Text("Save address"),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }


  void addAddress({required context}) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    Map<String, dynamic> newAddress = {
      'houseNo': addressModel.houseNameController.text,
      'area': addressModel.areaController.text,
      'city': addressModel.cityController.text,
      'pincode': addressModel.pincodeController.text,
      'state': addressModel.stateController.text
    };
    DocumentReference docRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.email);
    DocumentSnapshot documentSnapshot = await docRef.get();

    if (documentSnapshot.exists) {
      final data = documentSnapshot.data() as Map;
      if (data.containsKey("addresses")) {
        List<Map<String, dynamic>> addresses =
            List.from(documentSnapshot.get('addresses') ?? []);
        addresses.add(newAddress);
        await docRef.update({'addresses': addresses}).then(
            (value) => Get.offAll(const MainScreen()));
      } else {
        List<Map<String, dynamic>> addresses =
            List.from(documentSnapshot.get('addresses') ?? []);
        addresses.add(newAddress);
        await docRef.update({'addresses': addresses}).then(
            (value) => Get.offAll(const MainScreen()));
      }
    } else {}

    Get.snackbar("Address added", "",
        backgroundColor: kgreenColor, colorText: kwhiteColor);
  }



  void showStateSelectorDialog({required context}) async {
    String? result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select a state'),
            content: Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: states.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(states[index]),
                    onTap: () {
                      // Close the dialog and return the selected state to the caller
                      Navigator.of(context).pop(states[index]);
                    },
                  );
                },
              ),
            ),
          );
        });

    if (result != null) {
      addressModel.setSelectedState(result);
      // addressModel.setSelectedState(result);
    }
  }
}

final List<String> states = [
  'Andhra Pradesh',
  'Arunachal Pradesh',
  'Assam',
  'Bihar',
  'Chhattisgarh',
  'Goa',
  'Gujarat',
  'Haryana',
  'Himachal Pradesh',
  'Jharkhand',
  'Karnataka',
  'Kerala',
  'Madhya Pradesh',
  'Maharashtra',
  'Manipur',
  'Meghalaya',
  'Mizoram',
  'Nagaland',
  'Odisha',
  'Punjab',
  'Rajasthan',
  'Sikkim',
  'Tamil Nadu',
  'Telangana',
  'Tripura',
  'Uttar Pradesh',
  'Uttarakhand',
  'West Bengal'
];
