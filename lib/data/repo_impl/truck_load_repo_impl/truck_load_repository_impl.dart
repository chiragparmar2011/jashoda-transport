import 'package:dio/dio.dart';
import 'package:jashoda_transport/core/utils/app_url.dart';
import 'package:jashoda_transport/data/model/load/create_load_model.dart';
import 'package:jashoda_transport/data/model/load/box.dart';
import 'package:jashoda_transport/data/model/response_model.dart';
import 'package:jashoda_transport/data/model/truck/truck_detail_model.dart';
import 'package:jashoda_transport/data/model/truck/truck_list_model.dart';
import 'package:jashoda_transport/data/services/app_interceptor_service.dart';
import 'package:jashoda_transport/data/services/network_api_service.dart';
import 'package:jashoda_transport/domain/repo/truck/truck_load_base_repository.dart';

class TruckLoadRepositoryImpl extends TruckLoadBaseRepository {
  NetworkApiService networkApiService =
      NetworkApiService(Dio()..interceptors.add(AppInterceptor()));

  @override
  Future<List<TruckListModel>?> recentCalculation(String userID) async {
    final response = await networkApiService.get(
      endPoint: "${AppUrl.recentCalculation}/$userID",
    );

    final result =
        ResponseDataArrayModel.fromJson(TruckListModel(), response.data);
    return result.data;
  }

  @override
  Future<List<TruckListModel>?> savedCalculation(String userID) async {
    final response = await networkApiService.get(
      endPoint: "${AppUrl.fetchTruckDetail}/$userID",
    );

    final result =
        ResponseDataArrayModel.fromJson(TruckListModel(), response.data);
    return result.data;
  }

  Future<CreateLoadModel?> submitBoxDataRepo({
    String? userId,
    List<Box>? boxes,
  }) async {
    Map<String, dynamic> requestData = {
      'userId': userId,
      'boxGroups': boxes?.map((box) => box.toJson()).toList(),
    };
    final response = await networkApiService.post(
      data: requestData,
      endPoint: AppUrl.loadCalculation,
    );

    if (response.data['success'] == false) {
      throw Exception(response.data['message']);
    }

    final result =
        ResponseDataObjectModel.fromJson(CreateLoadModel(), response.data);
    return result.data;
  }

  Future<CreateLoadModel?> saveTruckLoad({
    String? userId,
    Map<String, dynamic>? truckDetails,
    List<Box>? boxes,
  }) async {
    Map<String, dynamic> requestData = {
      'userId': userId,
      'truck_details': truckDetails,
      'boxGroups': boxes?.map((box) => box.toJson()).toList(),
    };
    final response = await networkApiService.post(
      data: requestData,
      endPoint: AppUrl.saveTruckLoad,
    );

    if (response.data['success'] == false) {
      throw Exception(response.data['message']);
    }

    final result =
        ResponseDataObjectModel.fromJson(CreateLoadModel(), response.data);
    return result.data;
  }

  @override
  Future<TruckDetailModel?> fetchSingleTruck(String truckId) async {
    final response = await networkApiService.get(
      endPoint: "${AppUrl.fetchSingleTruck}/$truckId",
    );

    final result =
        ResponseDataObjectModel.fromJson(TruckDetailModel(), response.data);
    return result.data;
  }
}
