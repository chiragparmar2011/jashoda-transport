import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
import 'package:jashoda_transport/core/routes/app_routes.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';
import 'package:jashoda_transport/getit_injector.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _prefs = injector.get<SharedPreferenceHelper>();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      getUserDetail();
    });
    super.initState();
  }

  void getUserDetail() async {
    if (_prefs.getUser() != null) {
      navigationTo(MyRoutes.dashboardScreen);
    } else {
      navigationTo(MyRoutes.onboardScreen);
    }
  }

  void navigationTo(String path) {
    Navigator.pushReplacementNamed(context, path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: ImageAssets(
            image: AssetsPath.splash,
            height: 230,
            width: 370,
          ),
        ),
      ),
    );
  }
}
