import 'package:dio/dio.dart';
import 'package:jashoda_transport/core/error/error_handler.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
import 'package:jashoda_transport/core/utils/app_url.dart';
import 'package:jashoda_transport/data/model/CreatLoadModel.dart';
import 'package:jashoda_transport/data/model/new/box.dart';
import 'package:jashoda_transport/data/model/response_model.dart';
import 'package:jashoda_transport/data/model/truck/truck_detail_model.dart';
import 'package:jashoda_transport/data/model/user/usermodel.dart';
import 'package:jashoda_transport/data/services/app_interceptor_service.dart';
import 'package:jashoda_transport/data/services/network_api_service.dart';
import 'package:jashoda_transport/domain/repo/auth/auth_base_repository.dart';
import 'package:jashoda_transport/domain/repo/truck/truck_load_base_repository.dart';
import 'package:jashoda_transport/getit_injector.dart';

class TruckLoadRepositoryImpl extends TruckLoadBaseRepository {
  NetworkApiService networkApiService = NetworkApiService(Dio()..interceptors.add(AppInterceptor()));

  @override
  Future<List<TruckDetailModel>?> recentCalculation(String userID) async {
    final response = await networkApiService.get(
      endPoint: "${AppUrl.recentCalculation}/$userID",
    );

    final result = ResponseDataArrayModel.fromJson(TruckDetailModel(), response.data);
    return result.data;
  }

  @override
  Future<List<TruckDetailModel>?> savedCalculation(String userID) async {
    final response = await networkApiService.get(
      endPoint: "${AppUrl.getTruckDetail}/$userID",
    );

    final result = ResponseDataArrayModel.fromJson(TruckDetailModel(), response.data);
    return result.data;
  }

  Future<Creatloadmodel?> submitBoxDataRepo({String? userId, List<Box>? boxes}) async {
    Map<String, dynamic> requestData = {
      'userId':userId.toString(),
      'boxGroups':  boxes?.map((box) => box.toJson()).toList(),
    };
    final response = await networkApiService.post(
      data: requestData,
      endPoint: AppUrl.loadCalculation,
    );
    final result = ResponseDataObjectModel.fromJson(Creatloadmodel(), response.data);
    return result.data;
  }
}
