import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:rentease/view/core/string_consts.dart';
part 'home_mobx.g.dart';

class HomeMobx = _HomeMobx with _$HomeMobx;

abstract class _HomeMobx with Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreService _firestoreService = FirestoreService();
  @observable
  int selectedIndex = 0;

  @observable
  String selectedCategory = "Electronics";

  @action
  void changeCategory(int index) {
    selectedIndex = index;
  }

  @computed
  Stream<QuerySnapshot> get documentStream {
    return _firestoreService.getDocuments(selectedCategory);
  }

  @action
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
