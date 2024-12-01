import 'package:jashoda_transport/data/model/truck/truck_detail_model.dart';

abstract class TruckLoadBaseRepository {
  Future<List<TruckDetailModel>?> recentCalculation(String userID);

  Future<List<TruckDetailModel>?> savedCalculation(String userID);
}
