import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
import 'package:jashoda_transport/cubit/auth/inputNumber/input_mo_number_cubit.dart';
import 'package:jashoda_transport/cubit/auth/otp_verification/otp_verification_cubit.dart';
import 'package:jashoda_transport/cubit/auth/registration/registration_cubit.dart';
import 'package:jashoda_transport/cubit/bottomnav/bottom_nav_cubit.dart';
import 'package:jashoda_transport/cubit/dashboard/calculation/calculation_cubit.dart';
import 'package:jashoda_transport/cubit/dashboard/home/home_cubit.dart';
import 'package:jashoda_transport/cubit/dashboard/profile/editprofile/edit_profile_cubit.dart';
import 'package:jashoda_transport/cubit/onboard/onboard_cubit.dart';
import 'package:jashoda_transport/data/repo_impl/auto_repo_impl/authentication_repository_impl.dart';
import 'package:jashoda_transport/data/repo_impl/truck_load_repo_impl/truck_load_repository_impl.dart';
import 'package:jashoda_transport/data/services/network_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt injector = GetIt.instance;

Future<void> init() async {
  /// CUBIT

  /// Auth
  injector.registerFactory(() => OnboardCubit());
  injector.registerFactory(() => EnterMoNumberCubit(injector<AuthRepositoryImpl>()));
  injector.registerFactory(() => OtpVerificationCubit(injector<AuthRepositoryImpl>()));
  injector.registerFactory(() => RegistrationCubit(injector<AuthRepositoryImpl>()));
  injector.registerFactory(() => BottomNavCubit());
  injector.registerFactory(() => HomeCubit(injector<TruckLoadRepositoryImpl>()));
  injector.registerFactory(() => CalculationCubit(injector<TruckLoadRepositoryImpl>()));
  injector.registerFactory(() => EditProfileCubit(injector<AuthRepositoryImpl>()));

  /// Repository
  injector.registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl());
  injector.registerLazySingleton<TruckLoadRepositoryImpl>(() => TruckLoadRepositoryImpl());

  /// Network Info
  injector
      .registerLazySingleton<NetworkApiService>(() => NetworkApiService(Dio()));

  /// SharedPreferences
  SharedPreferences preferences = await SharedPreferences.getInstance();
  injector.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper(preferences: preferences));
}
