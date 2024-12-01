import 'package:jashoda_transport/data/model/response_model.dart';

class Creatloadmodel extends ResponseDataObjectSerialization<Creatloadmodel> {
  TruckDetails? truckDetails;
  String? date;
  BoxDetails? boxDetails;

  Creatloadmodel({this.truckDetails, this.date, this.boxDetails});

  Creatloadmodel.fromJson(Map<String, dynamic> json) {
    truckDetails = json['truckDetails'] != null ? new TruckDetails.fromJson(json['truckDetails']) : null;
    date = json['date'];
    boxDetails = json['boxDetails'] != null ? new BoxDetails.fromJson(json['boxDetails']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.truckDetails != null) {
      data['truckDetails'] = this.truckDetails!.toJson();
    }
    data['date'] = this.date;
    if (this.boxDetails != null) {
      data['boxDetails'] = this.boxDetails!.toJson();
    }
    return data;
  }

  @override
  Creatloadmodel fromJson(Map<String, dynamic> json) {
    return Creatloadmodel.fromJson(json);
  }
}

class TruckDetails {
  String? truckName;
  Dimensions? dimensions;
  int? totalWeight;
  int? maxLoad;

  TruckDetails({this.truckName, this.dimensions, this.totalWeight, this.maxLoad});

  TruckDetails.fromJson(Map<String, dynamic> json) {
    truckName = json['truckName'];
    dimensions = json['dimensions'] != null ? new Dimensions.fromJson(json['dimensions']) : null;
    totalWeight = json['totalWeight'];
    maxLoad = json['maxLoad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['truckName'] = this.truckName;
    if (this.dimensions != null) {
      data['dimensions'] = this.dimensions!.toJson();
    }
    data['totalWeight'] = this.totalWeight;
    data['maxLoad'] = this.maxLoad;
    return data;
  }
}

class Dimensions {
  int? l;
  int? w;
  int? h;

  Dimensions({this.l, this.w, this.h});

  Dimensions.fromJson(Map<String, dynamic> json) {
    l = json['L'];
    w = json['W'];
    h = json['H'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['L'] = this.l;
    data['W'] = this.w;
    data['H'] = this.h;
    return data;
  }
}

class BoxDetails {
  int? totalBoxes;
  int? totalItems;
  List<Boxes>? boxes;

  BoxDetails({this.totalBoxes, this.totalItems, this.boxes});

  BoxDetails.fromJson(Map<String, dynamic> json) {
    totalBoxes = json['totalBoxes'];
    totalItems = json['totalItems'];
    if (json['boxes'] != null) {
      boxes = <Boxes>[];
      json['boxes'].forEach((v) {
        boxes!.add(new Boxes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalBoxes'] = this.totalBoxes;
    data['totalItems'] = this.totalItems;
    if (this.boxes != null) {
      data['boxes'] = this.boxes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Boxes {
  int? boxNumber;
  int? items;

  Boxes({this.boxNumber, this.items});

  Boxes.fromJson(Map<String, dynamic> json) {
    boxNumber = json['boxNumber'];
    items = json['items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['boxNumber'] = this.boxNumber;
    data['items'] = this.items;
    return data;
  }
}
