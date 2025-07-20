import 'package:jashoda_transport/data/model/load/create_load_model.dart';
import 'package:jashoda_transport/data/model/response_model.dart';

class TruckListModel extends ResponseDataObjectSerialization<TruckListModel> {
  TruckDetails? truckDetails;
  String? truckId;
  String? createdAt;

  TruckListModel({this.truckDetails, this.truckId, this.createdAt});

  TruckListModel.fromJson(Map<String, dynamic> json) {
    truckDetails = json['truck_details'] != null
        ? TruckDetails.fromJson(json['truck_details'])
        : null;
    truckId = json['_id'];
    createdAt = json['createdAt'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (truckDetails != null) {
      data['truck_details'] = truckDetails?.toJson();
    }
    data['_id'] = truckId;
    data['createdAt'] = createdAt;
    return data;
  }

  @override
  TruckListModel fromJson(Map<String, dynamic> json) {
    return TruckListModel.fromJson(json);
  }
}

class TruckDetails extends ResponseDataObjectSerialization<TruckDetails> {
  Dimensions? dimensions;
  String? name;
  int? totalWeight;
  int? maxLoad;

  TruckDetails({this.dimensions, this.name, this.totalWeight, this.maxLoad});

  TruckDetails.fromJson(Map<String, dynamic> json) {
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(json['dimensions'])
        : null;
    name = json['name'];
    totalWeight = json['total_weight'];
    maxLoad = json['max_load'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dimensions != null) {
      data['dimensions'] = dimensions!.toJson();
    }
    data['name'] = name;
    data['total_weight'] = totalWeight;
    data['max_load'] = maxLoad;
    return data;
  }

  @override
  TruckDetails fromJson(Map<String, dynamic> json) {
    return TruckDetails.fromJson(json);
  }
}