abstract class ResponseDataObjectSerialization<T> {
  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}

class ResponseDataObjectModel<T extends ResponseDataObjectSerialization> {
  ResponseDataObjectModel({
    this.data,
    this.message,
    this.success,
  });

  factory ResponseDataObjectModel.fromJson(
    T model,
    Map<String, dynamic> json,
  ) =>
      ResponseDataObjectModel(
        data: json["data"] == null
            ? null
            : model.fromJson(json["data"] as Map<String, dynamic>) as T,
        message: json["message"] == null ? null : json["message"] as String,
        success: json["success"] == null ? null : json["success"] as bool,
      );

  T? data;
  String? message;
  bool? success;

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
      };
}

class ResponseDataArrayModel<T extends ResponseDataObjectSerialization> {
  ResponseDataArrayModel({
    this.data,
    this.message,
    this.success,
  });

  factory ResponseDataArrayModel.fromJson(T model, Map<String, dynamic> json) =>
      ResponseDataArrayModel(
        message: json["message"] == null ? null : json["message"] as String,
        success: json["success"] == null ? null : json["success"] as bool,
        data: json["data"] == null
            ? null
            : List<T>.from(
                (json["data"] as List<dynamic>).map(
                  (x) => model.fromJson(x as Map<String, dynamic>),
                ),
              ),
      );

  List<T>? data;
  String? message;
  bool? success;

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data?.map((e) => e.toJson()).toList(),
      };
}
