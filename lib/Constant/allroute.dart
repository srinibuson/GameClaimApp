import 'package:get/get_navigation/get_navigation.dart';
import 'package:Claimit_app/Constant/constantroute.dart';
import 'package:Claimit_app/Pages/Dashboard/dashboard.dart';
import 'package:Claimit_app/Pages/Dashboard/widget/itemdetails.dart';
import 'package:Claimit_app/Pages/Login/login_screen.dart';

class Routes {
  static List<GetPage> allRoute = [
    GetPage<dynamic>(
      name: ConstantRoute.loginpage,
      page: () => LoginScreen(),
      transition: Transition.fade,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage<dynamic>(
      name: ConstantRoute.dashboard,
      page: () => DashboardScreen(),
      transition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage<dynamic>(
      name: ConstantRoute.itemdetails,
      page: () => ItemDetailsPage(),
      transition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage<dynamic>(
      name: ConstantRoute.loginpage,
      page: () => LoginScreen(),
      transition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    ),
  ];
}
