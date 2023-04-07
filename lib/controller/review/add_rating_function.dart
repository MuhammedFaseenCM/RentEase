import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rentease/model/ordermodel/order_model.dart';
import 'package:rentease/model/paidmodel/paidgadgetmodel.dart';
import 'package:rentease/view/core/const_colors.dart';

Future<void>   addRating({required MyOrderModel myOrderModel,required value})async{
  OrderModel orderModel = OrderModel();
   final reviewRatingDoc = orderModel.collection.doc(
                                "${FirebaseAuth.instance.currentUser!.email.toString()}_${myOrderModel.title}");

                            reviewRatingDoc.get().then((snapshot) {
                              if (snapshot.exists) {
                                reviewRatingDoc.update({
                                  'rating': value,
                                  'ownerEmail': myOrderModel.ownerEmail,
                                  'title': myOrderModel.title
                                }).catchError((error) {
                                  print(error);
                                });
                              } else {
                                reviewRatingDoc.set({
                                  'rating': value,
                                  'ownerEmail': myOrderModel.ownerEmail,
                                  'title': myOrderModel.title
                                });
                              }
                            });

                            Get.snackbar("Thanks for the rating", "",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: kgreenColor,
                                colorText: kwhiteColor);
}