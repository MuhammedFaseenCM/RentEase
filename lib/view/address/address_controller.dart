import 'address.dart';

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

  Stream<DocumentSnapshot<Map<String, dynamic>>>? stream = FirebaseFirestore
      .instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.email)
      .snapshots();
}
