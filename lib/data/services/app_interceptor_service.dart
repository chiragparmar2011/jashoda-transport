import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jashoda_transport/core/error/error_handler.dart';
import 'package:jashoda_transport/core/helper/gloabals.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
import 'package:jashoda_transport/core/routes/app_routes.dart';
import 'package:jashoda_transport/core/utils/app_url.dart';
import 'package:jashoda_transport/data/repo_impl/auto_repo_impl/authentication_repository_impl.dart';
import 'package:jashoda_transport/getit_injector.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AppInterceptor extends Interceptor {
  AuthRepositoryImpl? authRepositoryImpl;
  Dio refreshDio = Dio();
  final _prefs = injector.get<SharedPreferenceHelper>();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.baseUrl = AppUrl.baseUrl;
    options.headers["Content-Type"] = "application/json";
    options.headers["Accept"] = "application/json";
    options.connectTimeout = const Duration(milliseconds: 10000);
    options.receiveTimeout = const Duration(milliseconds: 10000);

    String? token = _prefs.getString(_prefs.accessToken);
    String? refreshToken = _prefs.getString(_prefs.refreshToken);
    if (token != null) {
      print("Token is ==>  $token");

      /// Check if token is expired
      bool isTokenExpired = _isTokenExpired(token);
      if (isTokenExpired) {
        print('Inside ifTokenExpired ==>');

        try {
          final response = await refreshDio.post(
            AppUrl.baseUrl,
            options: Options(
              headers: {
                'Authorization': '$refreshToken',
              },
            ),
          );
          if (kDebugMode) {
            print("Response is ==>$response");
          }
          final accessToken = response.data['data']['access_token'];
          _prefs.setAccessToken(accessToken);
          options.headers["Authorization"] = "Bearer $accessToken";
        } catch (e) {
          print("Token refresh failed: $e");
        }
      } else {
        /// Token is still valid, use it for the request
        print('Inside else part of TokenExpired ==>');
        options.headers["Authorization"] = "Bearer $token";
      }
    }
    super.onRequest(options, handler);
  }

  bool _isTokenExpired(String token) {
    print('inside _isTokenExpired');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    print("Decoded Token ==> $decodedToken");
    int expiryDateInSeconds = decodedToken['exp'];
    DateTime expiryDate =
        DateTime.fromMillisecondsSinceEpoch(expiryDateInSeconds * 1000);
    print("Expiry Date ==> $expiryDate");
    print(DateTime.now().isAfter(expiryDate));
    print('Today date is ==> ${DateTime.now()}');
    return DateTime.now().isAfter(expiryDate);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == ResponseCode.UNAUTHORISED) {
      navigateTo(MyRoutes.inputMoNumberScreen);
    }
    super.onError(err, handler);
  }

  void navigateTo(String routeName) {
    MyGlobals.navKey.currentState?.pushNamed(routeName);
  }
}
