import 'package:rentease/view/chats/page/message_binding.dart';
import 'package:rentease/view/chats/page/message_screen.dart';
import 'package:rentease/view/homepage/orders/pages/review_binding.dart';
import 'package:rentease/view/homepage/orders/pages/review_screen.dart';

import 'route.dart';

class Routes {
  Routes._();

  static final Routes instance = Routes._();

  List<GetPage> getGetxPages() {
    return [
      GetPage(
        name: RoutesName.login,
        page: () => const LoginPage(),
        binding: LoginBinding(),
      ),
      GetPage(
        name: RoutesName.splash,
        page: () => const SplashScreen(),
        binding: SplashBinding(),
      ),
      GetPage(
        name: RoutesName.signup,
        page: () => const SignUpScreen(),
        binding: SignupBinding(),
      ),
      GetPage(
        name: RoutesName.home,
        page: () => const MainScreen(),
        binding: MainBinding(),
      ),
      GetPage(
        name: RoutesName.chat,
        page: () => const ChatScreen(),
        transition: Transition.rightToLeft,
        binding: ChatBinding(),
      ),
      GetPage(
        name: RoutesName.address,
        page: () => const AddressScreen(),
        binding: AddressBinding(),
      ),
      GetPage(
        name: RoutesName.review,
        page: () => const ReviewScreen(),
        binding: ReviewBindings(),
      ),
      GetPage(
        name: RoutesName.message,
        page: () => const MessageScreen(),
        binding: MessageBinding(),
      )
    ];
  }
}
