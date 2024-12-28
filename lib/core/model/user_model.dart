class UserModel {
  String? sId;
  AuthId? authId;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? address;
  String? profileImage;
  String? phoneNumber;

  UserModel(
      {this.sId,
        this.authId,
        this.name,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.address,
        this.profileImage,
        this.phoneNumber});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    authId =
    json['authId'] != null ? AuthId.fromJson(json['authId']) : null;
    name = json['name'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    address = json['address'];
    profileImage = json['profile_image'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (authId != null) {
      data['authId'] = authId!.toJson();
    }
    data['name'] = name;
    data['email'] = email;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['address'] = address;
    data['profile_image'] = profileImage;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}

class AuthId {
  String? sId;
  String? name;
  String? email;
  String? role;
  bool? isBlocked;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AuthId(
      {this.sId,
        this.name,
        this.email,
        this.role,
        this.isBlocked,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.iV});

  AuthId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    isBlocked = json['isBlocked'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    data['isBlocked'] = isBlocked;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
