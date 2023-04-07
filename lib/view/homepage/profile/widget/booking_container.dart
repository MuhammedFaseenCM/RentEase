import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rentease/controller/profile/mybookings/my_bookings_control.dart';
import 'package:rentease/controller/update/update_item.dart';
import 'package:rentease/model/bookingmodel/booking_model.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/profile/widget/image_container.dart';

class BookingContainer extends StatelessWidget {
  final List<QueryDocumentSnapshot> documents;
  final Booking bookings;
  final int index;
  const BookingContainer(
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