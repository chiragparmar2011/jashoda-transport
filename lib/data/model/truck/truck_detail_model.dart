import 'package:jashoda_transport/data/model/response_model.dart';

class TruckDetailModel extends ResponseDataObjectSerialization<TruckDetailModel> {
  TruckDetails? truckDetails;
  String? createdAt;

  TruckDetailModel({this.truckDetails, this.createdAt});

  TruckDetailModel.fromJson(Map<String, dynamic> json) {
    truckDetails = json['truck_details'] != null
        ? TruckDetails.fromJson(json['truck_details'])
        : null;
    createdAt = json['createdAt'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (truckDetails != null) {
      data['truck_details'] = truckDetails!.toJson();
    }
    data['createdAt'] = createdAt;
    return data;
  }

  @override
  TruckDetailModel fromJson(Map<String, dynamic> json) {
    return TruckDetailModel.fromJson(json);
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

class Dimensions extends ResponseDataObjectSerialization<Dimensions> {
  int? l;
  int? w;
  int? h;

  Dimensions({this.l, this.w, this.h});

  Dimensions.fromJson(Map<String, dynamic> json) {
    l = json['L'];
    w = json['W'];
    h = json['H'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['L'] = l;
    data['W'] = w;
    data['H'] = h;
    return data;
  }

  @override
  Dimensions fromJson(Map<String, dynamic> json) {
    return Dimensions.fromJson(json);
  }
}
