import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentease/controller/profile/mybookings/my_bookings_control.dart';
import 'package:rentease/model/bookingmodel/booking_model.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:rentease/view/homepage/profile/widget/booking_container.dart';

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

                      return BookingContainer(
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