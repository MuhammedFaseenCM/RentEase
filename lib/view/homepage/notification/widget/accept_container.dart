import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rentease/controller/notification/notify_control.dart';
import 'package:rentease/model/acceptmodel/accept_model.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';

class AcceptContainer extends StatelessWidget {
  final String docId;
  //final Map resMap;
  final SendAcceptModel sendAccept;
  AcceptContainer({super.key, required this.docId, required this.sendAccept});
  static final notifyControl = NotifyController();
  final razorPay = Razorpay();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kheight20,
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              height: 180.0,
              decoration: BoxDecoration(
                  color: kwhiteColor,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 5.0, spreadRadius: 5.0)
                  ]),
              child: Column(
                children: [
                  kheight10,
                  Text(
                    sendAccept.status == 'accept'
                        ? "${sendAccept.ownerEmail} accepted the request"
                        : "${sendAccept.ownerEmail} rejected the request",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  kheight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(sendAccept.image1,
                            height: 100.0, width: 120.0, fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Container(
                                decoration: BoxDecoration(
                                  color: kgrey,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                width: 120.0,
                                height: 100.0,
                                child: Center(
                                  child: BlurHash(
                                    imageFit: BoxFit.cover,
                                    duration: const Duration(seconds: 4),
                                    curve: Curves.bounceInOut,
                                    hash: 'LHA-Vc_4s9ad4oMwt8t7RhXTNGRj',
                                    image: sendAccept.image1,
                                  ),
                                ));
                          }
                        }, errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: kgrey,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            width: 120.0,
                            height: 100.0,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sendAccept.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          kheight5,
                          Text(
                            "$rupee${sendAccept.plan}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15.0),
                          ),
                          sendAccept.status == 'accept'
                              ? SizedBox(
                                  width: 130.0,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      var amount = int.parse(sendAccept.plan);
                                      if (sendAccept.payment != 'success') {
                                        await checkout(
                                            amount: amount,
                                            title: sendAccept.title);
                                      } else if (sendAccept.payment ==
                                          'success') {
                                        try {
                                          FirebaseFirestore.instance
                                              .collection("PaidGadgets")
                                              .doc(docId)
                                              .set({
                                            'payment': 'success',
                                            'title': sendAccept.title,
                                            'plan': sendAccept.plan,
                                            'ownerEmail': sendAccept.ownerEmail,
                                            'userEmail': sendAccept.userEmail,
                                            'image1': sendAccept.image1
                                          });
                                        } catch (e) {}
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            sendAccept.payment != 'success'
                                                ? kBlue900
                                                : kgrey,
                                        side: BorderSide.none,
                                        shape: const StadiumBorder()),
                                    child: Text(
                                      sendAccept.payment != 'success'
                                          ? "Payments"
                                          : "Paid",
                                      maxLines: 1,
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  width: 130.0,
                                ),
                          kwidth10,
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 5.0, spreadRadius: 5.0)
                  ],
                  color: kgrey,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50.0)),
                ),
                child: Center(
                  child: IconButton(
                      onPressed: () {
                        notifyControl.deleteRes(docId: docId);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: kwhiteColor,
                      )),
                ),
              ),
            ),
            sendAccept.payment == 'success'
                ? Positioned(
                    bottom: 0.0,
                    child: Container(
                      //   padding: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      height: 30.0,
                      decoration: BoxDecoration(
                          color: kgreenColor,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                                spreadRadius: 5.0)
                          ]),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.check,
                              color: kwhiteColor,
                            ),
                            kwidth10,
                            Text(
                              "Payment completed",
                              style:
                                  TextStyle(color: kwhiteColor, fontSize: 15.0),
                            ),
                          ],
                        ),
                      ),
                    ))
                : const SizedBox()
          ],
        ),
        kheight20
      ],
    );
  }

  checkout({required amount, required title}) {
    var options = {
      'key': 'rzp_test_gzeebjVBIEAqNT',
      'amount': amount * 100,
      'name': title,
      'description': 'Hercules',
      'timeout': 120,
      'prefill': {'contact': '7034032788', 'email': 'faseencm0@gmail.com'}
    };

    try {
      razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      razorPay.open(options);
    } catch (e) {
      //
    }
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) {
    try {
      final sendResponse = SendAcceptModel(
              title: sendAccept.title,
              userEmail: sendAccept.userEmail,
              image1: sendAccept.image1,
              ownerEmail: sendAccept.ownerEmail,
              payment: 'success',
              plan: sendAccept.plan,
              status: "accept")
          .acceptToMap();
      FirebaseFirestore.instance
          .collection("SendRes")
          .doc(docId)
          .update({'payment': 'success'}).then((value) => FirebaseFirestore
              .instance
              .collection("PaidGadgets")
              .doc(docId)
              .set(sendResponse));
    } catch (e) {
      //
    }
  }

  _handlePaymentError(PaymentFailureResponse response) {
    try {
      FirebaseFirestore.instance
          .collection("SendRes")
          .doc(docId)
          .update({'payment': 'failure'});
    } catch (e) {
      //
    }
  }
}
