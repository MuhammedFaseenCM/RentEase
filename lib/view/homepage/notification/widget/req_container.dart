import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/notification/notify_control.dart';
import 'package:rentease/model/addressmodel/address_model.dart';
import 'package:rentease/model/requestmodel/sendreqmodel.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/notification/screens/user_details_screen.dart';
import 'package:rentease/view/homepage/notification/widget/req_buttons_widget.dart';

class RequestContainer extends StatelessWidget {
  
  final String docId;
  final AddressModel address;
  final SendRequestModel sendReq;
  const RequestContainer(
      {super.key,
      required this.docId,
     
      required this.address,
      required this.sendReq});
  static final notifyControl = NotifyController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kheight20,
        InkWell(
          onTap: () {
            Get.to(() => UserRequestDetailsScreen(
                  docId: docId,
                
                  address: address,
                  sendReq: sendReq,
                ));
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            height: 240.0,
            decoration: BoxDecoration(
                color: kwhiteColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 5.0, spreadRadius: 5.0)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kheight10,
                const Center(
                  child: Text(
                    'Rental request for your product',
                  ),
                ),
                kheight10,
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sendReq.userEmail,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on),
                              Text(
                                address.city,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          kheight10,
                          Text(
                            sendReq.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          kheight5,
                          Text(
                            sendReq.plan,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                    kwidth10,
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(sendReq.image1,
                            height: 100.0, width: 100.0, fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Container(
                                decoration: BoxDecoration(
                                  color: kgrey,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                width: 100.0,
                                height: 100.0,
                                child: Center(
                                  child: BlurHash(
                                    imageFit: BoxFit.cover,
                                    duration: const Duration(seconds: 4),
                                    curve: Curves.bounceInOut,
                                    hash: 'LHA-Vc_4s9ad4oMwt8t7RhXTNGRj',
                                    image: sendReq.image1,
                                  ),
                                ));
                          }
                        }, errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: kgrey,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            width: 100.0,
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
                    )
                  ],
                ),
                kheight10,
                ReqButtonsWidget(sendreq: sendReq, docId: docId)
              ],
            ),
          ),
        ),
        kheight20
      ],
    );
  }
}
