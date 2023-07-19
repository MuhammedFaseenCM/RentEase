import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';




 class OrderModel extends GetxController {
 
  double rating = 0;

  final collection = FirebaseFirestore.instance.collection("Review&Rating");

 
  void setRating(double value) {
    rating = value;
  }


  List<double> ratings = [];

  // @computed
  // double get averageRating {
  //   if (ratings.isEmpty) {
  //     return 0;
  //   }

  //   double totalRating = ratings.fold(0, (sum, rating) => sum + rating);
  //   return totalRating / ratings.length;
  // }

  
  Future<void> fetchRatings({required ownerEmail, required title}) async {
    final ratingRef = FirebaseFirestore.instance.collection("Review&Rating");

    QuerySnapshot ratingQuerySnapshot = await ratingRef
        .where('OwnerEmail', isEqualTo: ownerEmail)
        .where('title', isEqualTo: title)
        .get();

    List<double> fetchedRatings =
        ratingQuerySnapshot.docs.map((doc) => doc['rating'] as double).toList();

    ratings.addAll(fetchedRatings);
  }
}
