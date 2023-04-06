import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:rentease/controller/profile/mybookings/my_bookings_control.dart';
import 'package:rentease/controller/update/update_item.dart';
import 'package:rentease/model/bookingmodel/booking_model.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});
  static MyBookingController myGadget = MyBookingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBarWidget(title: AppLocalizations.of(context)!.myBookings),
        ),
        body: CustomContainer(
          child: StreamBuilder<QuerySnapshot>(
              stream: myGadget.query
                  .where('ownerEmail',
                      isEqualTo:
                          FirebaseAuth.instance.currentUser!.email.toString())
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  QuerySnapshot? querySnapshot = snapshot.data;
                  List<QueryDocumentSnapshot> documents = querySnapshot!.docs;

                  if (documents.isEmpty) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.menu_book_sharp),
                        kwidth10,
                        Text(
                          "No bookings yet",
                          style: TextStyle(
                              color: kblackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ],
                    );
                  }
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final bookings = Booking.fromSnapshot(documents[index]);

                      return GadgetContainer(
                          bookings: bookings,
                          documents: documents,
                          index: index);
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      wrongText,
                      style: TextStyle(
                          color: kblackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }
}

class GadgetContainer extends StatelessWidget {
  final List<QueryDocumentSnapshot> documents;
  final Booking bookings;
  final int index;
  const GadgetContainer(
      {super.key,
      required this.documents,
      required this.index,
      required this.bookings});
  static final myGadget = MyBookingController();
  static final updateGadget = UpdateController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kheight20,
        Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(5.0),
          height: 100.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: kwhiteColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, blurRadius: 5.0, spreadRadius: 5.0)
              ]),
          child: Row(
            children: [
              MyGadgetImageContainer(
                image: bookings.image1,
                size: 80.0,
              ),
              kwidth20,
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kheight20,
                    Text(
                      bookings.title,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    kheight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Current user :",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w400),
                        ),
                        Flexible(
                          child: Text(
                            bookings.userEmail,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MyGadgetImageContainer extends StatelessWidget {
  final double? size;
  final String image;
  const MyGadgetImageContainer({super.key, required this.image, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 5.0, spreadRadius: 5.0)
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(image,
            fit: BoxFit.cover, height: size ?? 100.0, width: size ?? 100.0,
            loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Container(
                decoration: BoxDecoration(
                  color: kgrey,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: size ?? 100.0,
                height: size ?? 100.0,
                child: Center(
                  child: BlurHash(
                    imageFit: BoxFit.cover,
                    duration: const Duration(seconds: 4),
                    curve: Curves.bounceInOut,
                    hash: 'LHA-Vc_4s9ad4oMwt8t7RhXTNGRj',
                    image: image,
                  ),
                ));
          }
        }, errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              color: kgrey,
              borderRadius: BorderRadius.circular(20.0),
            ),
            width: size ?? 100.0,
            height: size ?? 100.0,
            child: const Center(
              child: Icon(
                Icons.error,
                color: kwhiteColor,
                size: 30.0,
              ),
            ),
          );
        }),
      ),
    );
  }
}
