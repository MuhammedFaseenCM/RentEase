import 'package:rentease/view/homepage/profile/profile_controller.dart';

import 'profile.dart';

class ProfileScreen extends GetWidget<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: controller.docRef
              .doc(FirebaseAuth.instance.currentUser!.email.toString())
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(wrongText),
              );
            }
            if (snapshot.hasData) {
              DocumentSnapshot<Map<String, dynamic>>? querySnapshot =
                  snapshot.data;
              Map<String, dynamic>? data = querySnapshot!.data();

              return Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: boxDecoration,
                  child: Column(
                    children: [
                      kheight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.welcome.toUpperCase(),
                            style: TextStyle(
                                fontSize: 18.0,
                                color: kOrange900,
                                fontWeight: FontWeight.bold),
                          ),
                          kwidth10,
                          Flexible(
                            child: Text(
                              data![nameInMapText] ?? nameNullText,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  color: kblackColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      kheight10,
                      Text(
                        data[emailInMapText] ??
                            "${FirebaseAuth.instance.currentUser!.email}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: kblackColor,
                        ),
                      ),
                      kheight20,
                      SizedBox(
                        width: 230.0,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => const EditProfile());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kOrange900,
                                side: BorderSide.none,
                                shape: const StadiumBorder()),
                            child: Text(
                              AppLocalizations.of(context)!.editProfile,
                              maxLines: 1,
                              style: const TextStyle(color: kwhiteColor),
                            )),
                      ),
                      kheight20,
                      ListTileWidget(
                        title: AppLocalizations.of(context)!.myGadget,
                        icon: Icons.local_grocery_store_rounded,
                        onTap: () {
                          Get.to(() => const MyGadgetsScreen());
                        },
                      ),
                      kheight20,
                      ListTileWidget(
                        title: AppLocalizations.of(context)!.myBookings,
                        icon: Icons.menu_book_outlined,
                        onTap: () {
                          Get.to(() => const MyBookingScreen());
                        },
                      ),
                      kheight20,
                      ListTileWidget(
                        title: AppLocalizations.of(context)!.savedAddresses,
                        icon: Icons.location_on,
                        onTap: () {
                          Get.toNamed(RoutesName.address);
                        },
                      ),
                      kheight20,
                      ListTileWidget(
                        title: AppLocalizations.of(context)!.termsAndPolicies,
                        icon: Icons.assignment,
                        onTap: () {
                          Get.to(() => const TermsAndPoliciesScreen());
                        },
                      ),
                      kheight20,
                      ListTileWidget(
                        title: AppLocalizations.of(context)!.about,
                        icon: Icons.info,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AboutUsWidget();
                            },
                          );
                        },
                      ),
                      kheight20,
                      kheight20,
                      const LogoutButton()
                    ],
                  ));
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              );
            }
          }),
    );
  }
}
