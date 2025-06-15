import 'package:flutter/material.dart';
import 'package:jashoda_transport/data/model/create_load_model.dart';
import 'package:jashoda_transport/data/model/user/usermodel.dart';
import 'package:jashoda_transport/ui/auth/mobile/enter_mo_number_screen.dart';
import 'package:jashoda_transport/ui/auth/mobile/otp_verification_screen.dart';
import 'package:jashoda_transport/ui/auth/register/registration_screen.dart';
import 'package:jashoda_transport/ui/dashboard/calculation/saved_calculation_screen.dart';
import 'package:jashoda_transport/ui/dashboard/dashboard_screen.dart';
import 'package:jashoda_transport/ui/dashboard/home/home_screen.dart';
import 'package:jashoda_transport/ui/dashboard/new/create_new_calculation_screen.dart';
import 'package:jashoda_transport/ui/dashboard/profile/profile_screen.dart';
import 'package:jashoda_transport/ui/onboard/onboard_screen.dart';
import 'package:jashoda_transport/ui/profile_section/edit_profile_screen.dart';
import 'package:jashoda_transport/ui/splash/splash_screen.dart';
import 'package:jashoda_transport/ui/vehicle/vehicle_loaded_screen.dart';

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
          builder: (context) => const HomeScreen(),
        );
      case createCalculationScreen:
        return MaterialPageRoute(
          builder: (context) => const CreateNewCalculationScreen(),
        );
      case savedCalculationScreen:
        return MaterialPageRoute(
          builder: (context) => const SavedCalculationScreen(),
        );
      case profileScreen:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );
      case editProfileScreen:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        final UserModel userModel = args['userModel'];
        return MaterialPageRoute(
          builder: (context) => EditProfileScreen(userModel: userModel),
        );
      case vehicleLoadedScreen:
        final Map<String,dynamic> args = settings.arguments as Map<String,dynamic>;
        final CreateLoadModel data = args['data'];
        return MaterialPageRoute(
          builder: (context) => VehicleLoadedScreen(data: data),
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
