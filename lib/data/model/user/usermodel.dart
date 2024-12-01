import 'package:jashoda_transport/data/model/response_model.dart';

class UserModel extends ResponseDataObjectSerialization<UserModel> {
  String? name;
  String? email;
  String? companyName;
  String? industryType;
  bool? isDeleted;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserModel({
    this.name,
    this.email,
    this.companyName,
    this.industryType,
    this.isDeleted,
    this.sId,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    companyName = json['company_name'];
    industryType = json['industry_type'];
    isDeleted = json['is_deleted'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['company_name'] = companyName;
    data['industry_type'] = industryType;
    data['is_deleted'] = isDeleted;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) {
   return UserModel.fromJson(json);
  }
}
