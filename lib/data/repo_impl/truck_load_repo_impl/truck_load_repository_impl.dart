import 'package:dio/dio.dart';
import 'package:jashoda_transport/core/utils/app_url.dart';
import 'package:jashoda_transport/data/model/create_load_model.dart';
import 'package:jashoda_transport/data/model/new/box.dart';
import 'package:jashoda_transport/data/model/response_model.dart';
import 'package:jashoda_transport/data/model/truck/truck_detail_model.dart';
import 'package:jashoda_transport/data/services/app_interceptor_service.dart';
import 'package:jashoda_transport/data/services/network_api_service.dart';
import 'package:jashoda_transport/domain/repo/truck/truck_load_base_repository.dart';

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

  Future<CreateLoadModel?> submitBoxDataRepo({String? userId, List<Box>? boxes}) async {
    Map<String, dynamic> requestData = {
      'userId':userId.toString(),
      'boxGroups':  boxes?.map((box) => box.toJson()).toList(),
    };
    final response = await networkApiService.post(
      data: requestData,
      endPoint: AppUrl.loadCalculation,
    );
    final result = ResponseDataObjectModel.fromJson(CreateLoadModel(), response.data);
    return result.data;
  }
}
