import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/cubit/auth/inputNumber/input_mo_number_cubit.dart';
import 'package:jashoda_transport/cubit/auth/otp_verification/otp_verification_cubit.dart';
import 'package:jashoda_transport/cubit/auth/registration/registration_cubit.dart';
import 'package:jashoda_transport/cubit/bottomnav/bottom_nav_cubit.dart';
import 'package:jashoda_transport/cubit/dashboard/calculation/calculation_cubit.dart';
import 'package:jashoda_transport/cubit/dashboard/home/home_cubit.dart';
import 'package:jashoda_transport/cubit/dashboard/profile/editprofile/edit_profile_cubit.dart';
import 'package:jashoda_transport/cubit/onboard/onboard_cubit.dart';
import 'package:jashoda_transport/getit_injector.dart' as di;

class MyBlocProvider extends StatelessWidget {
  const MyBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.injector<OnboardCubit>()),
        BlocProvider(create: (context) => di.injector<EnterMoNumberCubit>()),
        BlocProvider(create: (context) => di.injector<OtpVerificationCubit>()),
        BlocProvider(create: (context) => di.injector<RegistrationCubit>()),
        BlocProvider(create: (context) => di.injector<BottomNavCubit>()),
        BlocProvider(create: (context) => di.injector<HomeCubit>()),
        BlocProvider(create: (context) => di.injector<CalculationCubit>()),
        BlocProvider(create: (context) => di.injector<EditProfileCubit>()),
      ],
      child: child,
    );
  }
}
