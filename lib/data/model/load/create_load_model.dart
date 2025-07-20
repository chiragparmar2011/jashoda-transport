import 'package:jashoda_transport/data/model/response_model.dart';

class CreateLoadModel extends ResponseDataObjectSerialization<CreateLoadModel> {
  SelectedTruck? selectedTruck;
  LoadingPlan? loadingPlan;
  Efficiency? efficiency;
  List<SafetyChecklist>? safetyChecklist;
  List<AlternativeTrucks>? alternativeTrucks;
  BoxDetailsItems? boxDetailsItems;

  CreateLoadModel({
    this.selectedTruck,
    this.loadingPlan,
    this.efficiency,
    this.safetyChecklist,
    this.alternativeTrucks,
    this.boxDetailsItems,
  });

  CreateLoadModel.fromJson(Map<String, dynamic> json) {
    selectedTruck = json['selectedTruck'] != null
        ? SelectedTruck.fromJson(json['selectedTruck'])
        : null;
    loadingPlan = json['loadingPlan'] != null
        ? LoadingPlan.fromJson(json['loadingPlan'])
        : null;
    efficiency = json['efficiency'] != null
        ? Efficiency.fromJson(json['efficiency'])
        : null;
    if (json['safetyChecklist'] != null) {
      safetyChecklist = <SafetyChecklist>[];
      json['safetyChecklist'].forEach((v) {
        safetyChecklist?.add(SafetyChecklist.fromJson(v));
      });
    }
    if (json['alternativeTrucks'] != null) {
      alternativeTrucks = <AlternativeTrucks>[];
      json['alternativeTrucks'].forEach((v) {
        alternativeTrucks?.add(AlternativeTrucks.fromJson(v));
      });
    }
    boxDetailsItems = json['boxDetails'] != null
        ? BoxDetailsItems.fromJson(json['boxDetails'])
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (selectedTruck != null) {
      data['selectedTruck'] = selectedTruck?.toJson();
    }
    if (loadingPlan != null) {
      data['loadingPlan'] = loadingPlan?.toJson();
    }
    if (efficiency != null) {
      data['efficiency'] = efficiency?.toJson();
    }
    if (safetyChecklist != null) {
      data['safetyChecklist'] =
          safetyChecklist?.map((v) => v.toJson()).toList();
    }
    if (alternativeTrucks != null) {
      data['alternativeTrucks'] =
          alternativeTrucks?.map((v) => v.toJson()).toList();
    }
    if (boxDetailsItems != null) {
      data['boxDetails'] = boxDetailsItems?.toJson();
    }
    return data;
  }

  @override
  CreateLoadModel fromJson(Map<String, dynamic> json) {
    return CreateLoadModel.fromJson(json);
  }
}

class SelectedTruck extends ResponseDataObjectSerialization<SelectedTruck> {
  String? name;
  Dimensions? dimensions;
  int? maxWeight;

  SelectedTruck({this.name, this.dimensions, this.maxWeight});

  SelectedTruck.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(json['dimensions'])
        : null;
    maxWeight = json['maxWeight'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (dimensions != null) {
      data['dimensions'] = dimensions?.toJson();
    }
    data['maxWeight'] = maxWeight;
    return data;
  }

  @override
  SelectedTruck fromJson(Map<String, dynamic> json) {
    return SelectedTruck.fromJson(json);
  }
}

class Dimensions extends ResponseDataObjectSerialization<Dimensions> {
  double? length;
  double? width;
  double? height;

  Dimensions({this.length, this.width, this.height});

  Dimensions.fromJson(Map<String, dynamic> json) {
    length = (json['length'] as num).toDouble();
    width = (json['width'] as num).toDouble();
    height = (json['height'] as num).toDouble();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    return data;
  }

  @override
  Dimensions fromJson(Map<String, dynamic> json) {
    return Dimensions.fromJson(json);
  }
}

class LoadingPlan extends ResponseDataObjectSerialization<LoadingPlan> {
  List<Zones>? zones;
  List<Instructions>? instructions;
  List<Steps>? steps;

  LoadingPlan({
    this.zones,
    this.instructions,
    this.steps,
  });

  LoadingPlan.fromJson(Map<String, dynamic> json) {
    if (json['zones'] != null) {
      zones = <Zones>[];
      json['zones'].forEach((v) {
        zones?.add(Zones.fromJson(v));
      });
    }
    if (json['instructions'] != null) {
      instructions = <Instructions>[];
      json['instructions'].forEach((v) {
        instructions?.add(Instructions.fromJson(v));
      });
    }
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps?.add(Steps.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (zones != null) {
      data['zones'] = zones?.map((v) => v.toJson()).toList();
    }
    if (instructions != null) {
      data['instructions'] = instructions?.map((v) => v.toJson()).toList();
    }
    if (steps != null) {
      data['steps'] = steps?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  LoadingPlan fromJson(Map<String, dynamic> json) {
    return LoadingPlan.fromJson(json);
  }
}

class Zones extends ResponseDataObjectSerialization<Zones> {
  int? zoneNumber;
  Position? position;
  DimensionsDepth? dimensionsDepth;
  BoxDetails? boxDetails;

  Zones({
    this.zoneNumber,
    this.position,
    this.dimensionsDepth,
    this.boxDetails,
  });

  Zones.fromJson(Map<String, dynamic> json) {
    zoneNumber = json['zoneNumber'];
    position =
        json['position'] != null ? Position.fromJson(json['position']) : null;
    dimensionsDepth = json['dimensions'] != null
        ? DimensionsDepth.fromJson(json['dimensions'])
        : null;
    boxDetails = json['boxDetails'] != null
        ? BoxDetails.fromJson(json['boxDetails'])
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zoneNumber'] = zoneNumber;
    if (position != null) {
      data['position'] = position?.toJson();
    }
    if (dimensionsDepth != null) {
      data['dimensions'] = dimensionsDepth?.toJson();
    }
    if (boxDetails != null) {
      data['boxDetails'] = boxDetails?.toJson();
    }
    return data;
  }

  @override
  Zones fromJson(Map<String, dynamic> json) {
    return Zones.fromJson(json);
  }
}

class Position extends ResponseDataObjectSerialization<Position> {
  double? x;
  double? y;
  double? z;

  Position({this.x, this.y, this.z});

  Position.fromJson(Map<String, dynamic> json) {
    x = (json['x'] as num).toDouble();
    y = (json['y'] as num).toDouble();
    z = (json['z'] as num).toDouble();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['x'] = x;
    data['y'] = y;
    data['z'] = z;
    return data;
  }

  @override
  Position fromJson(Map<String, dynamic> json) {
    return Position.fromJson(json);
  }
}

class DimensionsDepth extends ResponseDataObjectSerialization<DimensionsDepth> {
  double? width;
  double? height;
  double? depth;

  DimensionsDepth({this.width, this.height, this.depth});

  DimensionsDepth.fromJson(Map<String, dynamic> json) {
    width = (json['width'] as num).toDouble();
    height = (json['height'] as num).toDouble();
    depth = (json['depth'] as num).toDouble();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    data['depth'] = depth;
    return data;
  }

  @override
  DimensionsDepth fromJson(Map<String, dynamic> json) {
    return DimensionsDepth.fromJson(json);
  }
}

class BoxDetails extends ResponseDataObjectSerialization<BoxDetails> {
  int? quantity;
  Dimensions? dimensions;
  double? weight;
  bool? stackable;

  BoxDetails({this.quantity, this.dimensions, this.weight, this.stackable});

  BoxDetails.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(json['dimensions'])
        : null;
    weight = (json['weight'] as num).toDouble();
    stackable = json['stackable'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    if (dimensions != null) {
      data['dimensions'] = dimensions?.toJson();
    }
    data['weight'] = weight;
    data['stackable'] = stackable;
    return data;
  }

  @override
  BoxDetails fromJson(Map<String, dynamic> json) {
    return BoxDetails.fromJson(json);
  }
}

class Instructions extends ResponseDataObjectSerialization<Instructions> {
  int? step;
  String? instruction;
  String? warning;
  String? zone;
  String? weightWarning;

  Instructions({
    this.step,
    this.instruction,
    this.warning,
    this.zone,
    this.weightWarning,
  });

  Instructions.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    instruction = json['instruction'];
    warning = json['warning'];
    zone = json['zone'];
    weightWarning = json['weightWarning'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['step'] = step;
    data['instruction'] = instruction;
    data['warning'] = warning;
    data['zone'] = zone;
    data['weightWarning'] = weightWarning;
    return data;
  }

  @override
  Instructions fromJson(Map<String, dynamic> json) {
    return Instructions.fromJson(json);
  }
}

class Steps extends ResponseDataObjectSerialization<Steps> {
  int? stepNumber;
  String? action;
  Details? details;
  List<String>? safetyNotes;

  Steps({this.stepNumber, this.action, this.details, this.safetyNotes});

  Steps.fromJson(Map<String, dynamic> json) {
    stepNumber = json['stepNumber'];
    action = json['action'];
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
    safetyNotes = json['safetyNotes'].cast<String>();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stepNumber'] = stepNumber;
    data['action'] = action;
    if (details != null) {
      data['details'] = details?.toJson();
    }
    data['safetyNotes'] = safetyNotes;
    return data;
  }

  @override
  Steps fromJson(Map<String, dynamic> json) {
    return Steps.fromJson(json);
  }
}

class Details extends ResponseDataObjectSerialization<Details> {
  String? boxDimensions;
  String? boxWeight;
  String? zoneLocation;
  String? runningWeight;

  Details({
    this.boxDimensions,
    this.boxWeight,
    this.zoneLocation,
    this.runningWeight,
  });

  Details.fromJson(Map<String, dynamic> json) {
    boxDimensions = json['boxDimensions'];
    boxWeight = json['boxWeight'];
    zoneLocation = json['zoneLocation'];
    runningWeight = json['runningWeight'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['boxDimensions'] = boxDimensions;
    data['boxWeight'] = boxWeight;
    data['zoneLocation'] = zoneLocation;
    data['runningWeight'] = runningWeight;
    return data;
  }

  @override
  Details fromJson(Map<String, dynamic> json) {
    return Details.fromJson(json);
  }
}

class Efficiency extends ResponseDataObjectSerialization<Efficiency> {
  VolumeAnalysis? volumeAnalysis;
  WeightAnalysis? weightAnalysis;
  double? overallEfficiency;

  Efficiency({
    this.volumeAnalysis,
    this.weightAnalysis,
    this.overallEfficiency,
  });

  Efficiency.fromJson(Map<String, dynamic> json) {
    volumeAnalysis = json['volumeAnalysis'] != null
        ? VolumeAnalysis.fromJson(json['volumeAnalysis'])
        : null;
    weightAnalysis = json['weightAnalysis'] != null
        ? WeightAnalysis.fromJson(json['weightAnalysis'])
        : null;
    overallEfficiency = json['overallEfficiency'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (volumeAnalysis != null) {
      data['volumeAnalysis'] = volumeAnalysis?.toJson();
    }
    if (weightAnalysis != null) {
      data['weightAnalysis'] = weightAnalysis?.toJson();
    }
    data['overallEfficiency'] = overallEfficiency;
    return data;
  }

  @override
  Efficiency fromJson(Map<String, dynamic> json) {
    return Efficiency.fromJson(json);
  }
}

class VolumeAnalysis extends ResponseDataObjectSerialization<VolumeAnalysis> {
  int? totalVolume;
  double? truckVolume;
  double? volumeUtilization;
  double? unusedVolume;
  bool? isEfficient;

  VolumeAnalysis({
    this.totalVolume,
    this.truckVolume,
    this.volumeUtilization,
    this.unusedVolume,
    this.isEfficient,
  });

  VolumeAnalysis.fromJson(Map<String, dynamic> json) {
    totalVolume = json['totalVolume'];
    truckVolume = json['truckVolume'];
    volumeUtilization = json['volumeUtilization'];
    unusedVolume = json['unusedVolume'];
    isEfficient = json['isEfficient'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalVolume'] = totalVolume;
    data['truckVolume'] = truckVolume;
    data['volumeUtilization'] = volumeUtilization;
    data['unusedVolume'] = unusedVolume;
    data['isEfficient'] = isEfficient;
    return data;
  }

  @override
  VolumeAnalysis fromJson(Map<String, dynamic> json) {
    return VolumeAnalysis.fromJson(json);
  }
}

class WeightAnalysis extends ResponseDataObjectSerialization<WeightAnalysis> {
  int? totalWeight;
  int? maxWeight;
  double? weightUtilization;
  int? remainingCapacity;
  bool? isEfficient;

  WeightAnalysis({
    this.totalWeight,
    this.maxWeight,
    this.weightUtilization,
    this.remainingCapacity,
    this.isEfficient,
  });

  WeightAnalysis.fromJson(Map<String, dynamic> json) {
    totalWeight = json['totalWeight'];
    maxWeight = json['maxWeight'];
    weightUtilization = json['weightUtilization'];
    remainingCapacity = json['remainingCapacity'];
    isEfficient = json['isEfficient'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalWeight'] = totalWeight;
    data['maxWeight'] = maxWeight;
    data['weightUtilization'] = weightUtilization;
    data['remainingCapacity'] = remainingCapacity;
    data['isEfficient'] = isEfficient;
    return data;
  }

  @override
  WeightAnalysis fromJson(Map<String, dynamic> json) {
    return WeightAnalysis.fromJson(json);
  }
}

class SafetyChecklist extends ResponseDataObjectSerialization<SafetyChecklist> {
  String? id;
  String? label;
  bool? critical;

  SafetyChecklist({this.id, this.label, this.critical});

  SafetyChecklist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    critical = json['critical'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['critical'] = critical;
    return data;
  }

  @override
  SafetyChecklist fromJson(Map<String, dynamic> json) {
    return SafetyChecklist.fromJson(json);
  }
}

class AlternativeTrucks
    extends ResponseDataObjectSerialization<AlternativeTrucks> {
  String? name;
  Dimensions? dimensions;
  double? volumeUtilization;
  double? weightUtilization;
  double? maxWeight;

  AlternativeTrucks({
    this.name,
    this.dimensions,
    this.volumeUtilization,
    this.weightUtilization,
    this.maxWeight,
  });

  AlternativeTrucks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(json['dimensions'])
        : null;
    volumeUtilization = (json['volumeUtilization'] as num).toDouble();
    weightUtilization = (json['weightUtilization'] as num).toDouble();
    maxWeight = (json['maxWeight'] as num).toDouble();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (dimensions != null) {
      data['dimensions'] = dimensions?.toJson();
    }
    data['volumeUtilization'] = volumeUtilization;
    data['weightUtilization'] = weightUtilization;
    data['maxWeight'] = maxWeight;
    return data;
  }

  @override
  AlternativeTrucks fromJson(Map<String, dynamic> json) {
    return AlternativeTrucks.fromJson(json);
  }
}

class BoxDetailsItems extends ResponseDataObjectSerialization<BoxDetailsItems> {
  int? totalBoxes;
  int? totalItems;
  List<Boxes>? boxes;

  BoxDetailsItems({this.totalBoxes, this.totalItems, this.boxes});

  BoxDetailsItems.fromJson(Map<String, dynamic> json) {
    totalBoxes = json['totalBoxes'];
    totalItems = json['totalItems'];
    if (json['boxes'] != null) {
      boxes = <Boxes>[];
      json['boxes'].forEach((v) {
        boxes?.add(Boxes.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalBoxes'] = totalBoxes;
    data['totalItems'] = totalItems;
    if (boxes != null) {
      data['boxes'] = boxes?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  BoxDetailsItems fromJson(Map<String, dynamic> json) {
    return BoxDetailsItems.fromJson(json);
  }
}

class Boxes extends ResponseDataObjectSerialization<Boxes> {
  int? boxNumber;
  Dimensions? dimensions;
  double? weight;
  int? quantity;
  bool? stackable;

  Boxes({
    this.boxNumber,
    this.dimensions,
    this.weight,
    this.quantity,
    this.stackable,
  });

  Boxes.fromJson(Map<String, dynamic> json) {
    boxNumber = json['boxNumber'];
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(json['dimensions'])
        : null;
    weight = (json['weight'] as num).toDouble();
    quantity = json['quantity'];
    stackable = json['stackable'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['boxNumber'] = boxNumber;
    if (dimensions != null) {
      data['dimensions'] = dimensions?.toJson();
    }
    data['weight'] = weight;
    data['quantity'] = quantity;
    data['stackable'] = stackable;
    return data;
  }

  @override
  Boxes fromJson(Map<String, dynamic> json) {
    return Boxes.fromJson(json);
  }
}
