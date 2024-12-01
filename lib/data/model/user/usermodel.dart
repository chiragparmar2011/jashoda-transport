import 'package:jashoda_transport/data/model/response_model.dart';

class UserModel extends ResponseDataObjectSerialization<UserModel> {
  String? name;
  String? email;
  String? companyName;
  String? phoneNumber;
  String? industryType;
  bool? isDeleted;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? profilePicture;

  UserModel({
    this.name,
    this.email,
    this.companyName,
    this.phoneNumber,
    this.industryType,
    this.isDeleted,
    this.sId,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.profilePicture
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    companyName = json['company_name'];
    phoneNumber = json['phone_number'];
    industryType = json['industry_type'];
    isDeleted = json['is_deleted'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    profilePicture = json['profile_picture'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['company_name'] = companyName;
    data['phone_number'] = phoneNumber;
    data['industry_type'] = industryType;
    data['is_deleted'] = isDeleted;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['profile_picture'] = profilePicture;
    return data;
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) {
   return UserModel.fromJson(json);
  }
}
