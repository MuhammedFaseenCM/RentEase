import 'profile.dart';

class ProfileController extends GetxController {
  final docRef = FirebaseFirestore.instance.collection("Users");

  Future<String> userDetails({required key}) async {
    final userDoc =
        docRef.doc(FirebaseAuth.instance.currentUser!.email.toString());
    final getDoc = await userDoc.get();
    final map = getDoc.data();
    return map![key];
  }

  @override
  void onInit() {
    updateDetails();
    super.onInit();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  //get editName => nameController.text;

  void updateDetails() async {
    nameController.text = await userDetails(key: "name");
    phoneController.text = await userDetails(key: "phoneNumber");
  }

  Future<void> updateDoc(
      {required name, required phone, required location}) async {
    final userDoc =
        docRef.doc(FirebaseAuth.instance.currentUser!.email.toString());
    userDoc.update({
      'name': name,
      'email': FirebaseAuth.instance.currentUser!.email.toString(),
      'phoneNumber': phone,
    }).then((value) {
      Get.back();
      Get.snackbar("Details updated", "",
          backgroundColor: kgreenColor,
          colorText: kwhiteColor,
          snackPosition: SnackPosition.BOTTOM);
    });
  }
}
