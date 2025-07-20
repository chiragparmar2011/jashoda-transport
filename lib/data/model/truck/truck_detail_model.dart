import 'package:jashoda_transport/data/model/response_model.dart';
import 'package:jashoda_transport/data/model/truck/truck_list_model.dart';

class TruckDetailModel
    extends ResponseDataObjectSerialization<TruckDetailModel> {
  TruckDetails? truckDetails;
  String? sId;
  String? user;
  List<Boxes>? boxes;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TruckDetailModel({
    this.truckDetails,
    this.sId,
    this.user,
    this.boxes,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  TruckDetailModel.fromJson(Map<String, dynamic> json) {
    truckDetails = json['truck_details'] != null
        ? TruckDetails.fromJson(json['truck_details'])
        : null;
    sId = json['_id'];
    user = json['user'];
    if (json['boxes'] != null) {
      boxes = <Boxes>[];
      json['boxes'].forEach((v) {
        boxes!.add(Boxes.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (truckDetails != null) {
      data['truck_details'] = truckDetails!.toJson();
    }
    data['_id'] = sId;
    data['user'] = user;
    if (boxes != null) {
      data['boxes'] = boxes!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }

  @override
  TruckDetailModel fromJson(Map<String, dynamic> json) {
    return TruckDetailModel.fromJson(json);
  }
}

class Boxes extends ResponseDataObjectSerialization<Boxes> {
  int? boxLength;
  int? boxWidth;
  int? boxHeight;
  int? boxWeight;
  int? boxQuantity;
  bool? isStackable;
  String? sId;

  Boxes({
    this.boxLength,
    this.boxWidth,
    this.boxHeight,
    this.boxWeight,
    this.boxQuantity,
    this.isStackable,
    this.sId,
  });

  Boxes.fromJson(Map<String, dynamic> json) {
    boxLength = json['box_length'];
    boxWidth = json['box_width'];
    boxHeight = json['box_height'];
    boxWeight = json['box_weight'];
    boxQuantity = json['box_quantity'];
    isStackable = json['is_stackable'];
    sId = json['_id'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['box_length'] = boxLength;
    data['box_width'] = boxWidth;
    data['box_height'] = boxHeight;
    data['box_weight'] = boxWeight;
    data['box_quantity'] = boxQuantity;
    data['is_stackable'] = isStackable;
    data['_id'] = sId;
    return data;
  }

  @override
  Boxes fromJson(Map<String, dynamic> json) {
    return Boxes.fromJson(json);
  }
}
