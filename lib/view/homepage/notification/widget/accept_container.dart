import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rentease/model/acceptmodel/accept_model.dart';
import 'package:rentease/model/chat_model.dart';
import 'package:rentease/view/chats/page/message_controller.dart';
import 'package:rentease/view/homepage/notification/notify_controller.dart';
import 'package:rentease/view/homepage/profile/profile.dart';

class AcceptContainer extends GetView<NotifyController> {
  final String docId;
  final SendAcceptModel sendAccept;
  AcceptContainer({
    super.key,
    required this.docId,
    required this.sendAccept,
  });
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
                        ? "${sendAccept.ownerName.toUpperCase()} accepted the request"
                        : "${sendAccept.ownerName.toUpperCase()} rejected the request",
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
                                // child: Center(
                                //   child: BlurHash(
                                //     imageFit: BoxFit.cover,
                                //     duration: const Duration(seconds: 4),
                                //     curve: Curves.bounceInOut,
                                //     hash: 'LHA-Vc_4s9ad4oMwt8t7RhXTNGRj',
                                //     image: sendAccept.image1,
                                //   ),
                                // ),
                                );
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
                                        Get.find<MessageController>().chat =
                                            Chat(
                                                message: '',
                                                dateTime: DateTime.now(),
                                                names: [
                                              sendAccept.ownerName,
                                              sendAccept.userName
                                            ],
                                                participants: [
                                              sendAccept.ownerEmail,
                                              sendAccept.userEmail
                                            ],);
                                        Get.toNamed(RoutesName.message);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kBlue900,
                                        side: BorderSide.none,
                                        shape: const StadiumBorder()),
                                    child: Text(
                                      sendAccept.payment != 'success'
                                          ? "Payments"
                                          : "Message",
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
            _buildDelete(),
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
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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

  GetBuilder _buildDelete() {
    return GetBuilder<NotifyController>(
        id: NotifyController.reBuildDelete,
        builder: (context) {
          return Positioned(
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
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(50.0)),
              ),
              child: Center(
                child: IconButton(
                    onPressed: () {
                      controller.deleteRes(docId: docId);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: kwhiteColor,
                    )),
              ),
            ),
          );
        });
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
              status: "accept",
              ownerName: sendAccept.ownerName,
              userName: sendAccept.userName)
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
