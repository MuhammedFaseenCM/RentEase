import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/notification/notify_control.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/notification/widget/gadget_approval.dart';
import 'package:rentease/view/homepage/notification/widget/gadget_request.dart';
import 'package:rentease/view/homepage/notification/widget/req_buttons_widget.dart';
import 'package:rentease/view/homepage/notification/widget/user_details.dart';

class NotifyScreen extends StatelessWidget {
  const NotifyScreen({super.key});
  static final notifyControl = NotifyController();
  @override
  Widget build(BuildContext context) {
    notifyControl.notfyIconController = false;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kwhiteColor,
            bottom: TabBar(
              isScrollable: true,
              labelColor: kwhiteColor,
              labelStyle: kTextStyle,
              unselectedLabelColor: kblackColor,
              unselectedLabelStyle: kTextStyle,
              tabs: const [
                Tab(child: Text("Rental Requests")),
                Tab(child: Text("Rental approvals")),
              ],
              indicator: BoxDecoration(
                  color: kbluegreyColor,
                  borderRadius: BorderRadius.circular(50.0)),
            ),
          ),
          body: const TabBarView(children: [
            GadgetRequests(),
            GadgetApproval(),
          ])),
    );
  }
}

class NotifyContainer extends StatelessWidget {
  final Map map;
  final String docId;
  const NotifyContainer({super.key, required this.docId, required this.map});
  static final notifyControl = NotifyController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kheight20,
        InkWell(
          onTap: () {
            Get.to(() => UserRequestDetails(
                  docId: docId,
                  reqMap: map,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          map['userEmail'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on),
                            Text(
                              map['address']['city'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        kheight10,
                        Text(
                          map['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        kheight5,
                        Text(
                          map['plan'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15.0),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(map['image1'],
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
                                  image: map['image1'],
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
                    )
                  ],
                ),
                kheight10,
                ReqButtonsWidget(map: map, docId: docId)
              ],
            ),
          ),
        ),
        kheight20
      ],
    );
  }
}
