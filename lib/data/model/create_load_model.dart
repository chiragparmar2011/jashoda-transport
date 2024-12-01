import 'package:jashoda_transport/data/model/response_model.dart';

class CreateLoadModel extends ResponseDataObjectSerialization<CreateLoadModel> {
  TruckDetails? truckDetails;
  String? date;
  BoxDetails? boxDetails;

  CreateLoadModel({this.truckDetails, this.date, this.boxDetails});

  CreateLoadModel.fromJson(Map<String, dynamic> json) {
    truckDetails = json['truckDetails'] != null
        ? TruckDetails.fromJson(json['truckDetails'])
        : null;
    date = json['date'];
    boxDetails = json['boxDetails'] != null
        ? BoxDetails.fromJson(json['boxDetails'])
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (truckDetails != null) {
      data['truckDetails'] = truckDetails!.toJson();
    }
    data['date'] = date;
    if (boxDetails != null) {
      data['boxDetails'] = boxDetails!.toJson();
    }
    return data;
  }

  @override
  CreateLoadModel fromJson(Map<String, dynamic> json) {
    return CreateLoadModel.fromJson(json);
  }
}

class TruckDetails extends ResponseDataObjectSerialization<TruckDetails> {
  String? truckName;
  Dimensions? dimensions;
  int? totalWeight;
  int? maxLoad;

  TruckDetails(
      {this.truckName, this.dimensions, this.totalWeight, this.maxLoad});

  TruckDetails.fromJson(Map<String, dynamic> json) {
    truckName = json['truckName'];
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(json['dimensions'])
        : null;
    totalWeight = json['totalWeight'];
    maxLoad = json['maxLoad'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['truckName'] = truckName;
    if (dimensions != null) {
      data['dimensions'] = dimensions!.toJson();
    }
    data['totalWeight'] = totalWeight;
    data['maxLoad'] = maxLoad;
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

class BoxDetails extends ResponseDataObjectSerialization<BoxDetails> {
  int? totalBoxes;
  int? totalItems;
  List<Boxes>? boxes;

  BoxDetails({this.totalBoxes, this.totalItems, this.boxes});

  BoxDetails.fromJson(Map<String, dynamic> json) {
    totalBoxes = json['totalBoxes'];
    totalItems = json['totalItems'];
    boxes = (json['boxes'] == null || json['boxes'] is! List)
        ? null
        : List<Boxes>.from(
            (json['boxes'] as List).map((data) => Boxes.fromJson(data)));
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalBoxes'] = totalBoxes;
    data['totalItems'] = totalItems;
    data['boxes'] = boxes;
    return data;
  }

  @override
  BoxDetails fromJson(Map<String, dynamic> json) {
    return BoxDetails.fromJson(json);
  }
}

class Boxes extends ResponseDataObjectSerialization<Boxes> {
  int? boxNumber;
  int? items;

  Boxes({this.boxNumber, this.items});

  Boxes.fromJson(Map<String, dynamic> json) {
    boxNumber = json['boxNumber'];
    items = json['items'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['boxNumber'] = boxNumber;
    data['items'] = items;
    return data;
  }

  @override
  Boxes fromJson(Map<String, dynamic> json) {
    return Boxes.fromJson(json);
  }
}
