  import 'package:flutter/material.dart';
  import '../presentation/add_log_harian_screen/add_log_harian_screen.dart';
  import '../presentation/edit_log_harian_screen/edit_log_harian_screen.dart';
  import '../presentation/logbookpage_screen/logbookpage_screen.dart';
  import '../presentation/mainpage_screen/mainpage_screen.dart';
  import '../presentation/login_screen/login.dart'; // Import halaman login

  class AppRoutes {
    static const String mainpageScreen = '/mainpage_screen';
    static const String logbookpageScreen = '/logbookpage_screen';
    static const String addLogHarianScreen = '/addLogHarianScreen/:internshipId';

    static const String editLogHarianScreen = '/edit_log_harian_screen';
    // static const String detailLogHarianScreen = '/detail_log_harian_screen';
    static const String appNavigationScreen = '/app_navigation_screen';
    static const String initialRoute = '/initialRoute';
    static const String loginScreen = '/login'; // Tambahkan halaman login ke routes

    static Map<String, WidgetBuilder> routes = {
      mainpageScreen: (context) => MainpageScreen(),
      logbookpageScreen: (context) => LogbookpageScreen(),
      addLogHarianScreen: (context) => AddLogHarianScreen(),
      editLogHarianScreen: (context) => EditLogHarianScreen(),
      // detailLogHarianScreen: (context) => DetailLogHarianScreen(),
      // appNavigationScreen: (context) => AppNavigationScreen(),
      initialRoute: (context) => LoginScreen(), // Atur halaman login sebagai initial route
      loginScreen: (context) => LoginScreen(), // Tambahkan halaman login ke routes
    };
  }