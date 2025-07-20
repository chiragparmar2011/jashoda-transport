import 'package:jashoda_transport/data/model/truck/truck_detail_model.dart';
import 'package:jashoda_transport/data/model/truck/truck_list_model.dart';

abstract class TruckLoadBaseRepository {
  Future<List<TruckListModel>?> recentCalculation(String userID);

  Future<List<TruckListModel>?> savedCalculation(String userID);

  Future<TruckDetailModel?> fetchSingleTruck(String truckId);
}
