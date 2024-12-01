import 'package:flutter/material.dart';
import 'package:jashoda_transport/ui/auth/mobile/enter_mo_number_screen.dart';
import 'package:jashoda_transport/ui/auth/mobile/otp_verification_screen.dart';
import 'package:jashoda_transport/ui/auth/register/registration_screen.dart';
import 'package:jashoda_transport/ui/dashboard/new/create_new_calculation_screen.dart';
import 'package:jashoda_transport/ui/dashboard/calculation/saved_calculation_screen.dart';
import 'package:jashoda_transport/ui/vehicle/vehicle_loaded_screen.dart';
import 'package:jashoda_transport/ui/dashboard/dashboard_screen.dart';
import 'package:jashoda_transport/ui/dashboard/home/home_screen.dart';
import 'package:jashoda_transport/ui/dashboard/profile/profile_screen.dart';
import 'package:jashoda_transport/ui/onboard/onboard_screen.dart';
import 'package:jashoda_transport/ui/profile_section/edit_profile_screen.dart';
import 'package:jashoda_transport/ui/splash/splash_screen.dart';

class MyRoutes {
  static const String splashScreen = '/';
  static const String onboardScreen = '/onboardScreen';
  static const String inputMoNumberScreen = '/inputMoNumberScreen';
  static const String otpVerificationScreen = '/otpVerificationScreen';
  static const String registrationScreen = '/registrationScreen';
  static const String dashboardScreen = '/dashboardScreen';
  static const String homeScreen = '/homeScreen';
  static const String createCalculationScreen = '/createCalculationScreen';
  static const String savedCalculationScreen = '/savedCalculationScreen';
  static const String profileScreen = '/profileScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String vehicleLoadedScreen = '/vehicleLoadedScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case onboardScreen:
        return MaterialPageRoute(
          builder: (context) => OnBoardScreen(),
        );
      case inputMoNumberScreen:
        return MaterialPageRoute(
          builder: (context) => EnterMoNumberScreen(),
        );
      case otpVerificationScreen:
        Map<String, dynamic> argsMap =
            settings.arguments as Map<String, dynamic>;
        String phoneNumber = argsMap['phoneNumber'];
        return MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(
            phoneNumber: phoneNumber,
          ),
        );
      case registrationScreen:
        return MaterialPageRoute(
          builder: (context) => RegistrationScreen(),
        );
      case dashboardScreen:
        return MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case createCalculationScreen:
        return MaterialPageRoute(
          builder: (context) => CreateNewCalculationScreen(),
        );
      case savedCalculationScreen:
        return MaterialPageRoute(
          builder: (context) => SavedCalculationScreen(),
        );
      case profileScreen:
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        );
      case editProfileScreen:
        return MaterialPageRoute(
          builder: (context) => EditProfileScreen(),
        );
      case vehicleLoadedScreen:
        return MaterialPageRoute(
          builder: (context) => VehicleLoadedScreen(),
        );
      default:
    }
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Text("no route defined"),
      ),
    );
  }
}
