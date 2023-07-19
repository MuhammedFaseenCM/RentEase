import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rentease/view/core/string_consts.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreService _firestoreService = FirestoreService();
 

  int selectedIndex = 0;

 
  String selectedCategory = "Electronics";


  void changeCategory(int index) {
    selectedIndex = index;
  }

  Stream<QuerySnapshot> get documentStream {
    return _firestoreService.getDocuments(selectedCategory);
  }

  
  void selectCategory(String category) {
    selectedCategory = category;
  }
}

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getDocuments(String selectedCategory) {
    return _firestore
        .collection(appName)
        .where('category', isEqualTo: selectedCategory)
        .snapshots();
  }
}
