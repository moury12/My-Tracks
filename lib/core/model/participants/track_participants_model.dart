import '../renter/renters_model.dart';

class TrackParticipantsModel {
  String? sId;
  User? user;
  String? host;
  String? track;
  String? trackSlot;
  String? startDateTime;
  String? endDateTime;
  int? price;
  String? currency;
  int? numOfPeople;
  String? status;
  List<MoreInfo>? moreInfo;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TrackParticipantsModel(
      {this.sId,
      this.user,
      this.host,
      this.track,
      this.trackSlot,
      this.startDateTime,
      this.endDateTime,
      this.price,
      this.currency,
      this.numOfPeople,
      this.status,
      this.moreInfo,
      this.createdAt,
      this.updatedAt,
      this.iV});

  TrackParticipantsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    host = json['host'];
    track = json['track'];
    trackSlot = json['trackSlot'];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    price = json['price'];
    currency = json['currency'];
    numOfPeople = json['numOfPeople'];
    status = json['status'];
    if (json['moreInfo'] != null) {
      moreInfo = <MoreInfo>[];
      json['moreInfo'].forEach((v) {
        moreInfo!.add(MoreInfo.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['host'] = this.host;
    data['track'] = this.track;
    data['trackSlot'] = this.trackSlot;
    data['startDateTime'] = this.startDateTime;
    data['endDateTime'] = this.endDateTime;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['numOfPeople'] = this.numOfPeople;
    data['status'] = this.status;
    if (moreInfo != null) {
      data['moreInfo'] = moreInfo!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? address;
  String? phoneNumber;
  String? profileImage;

  User(
      {this.name,
      this.email,
      this.address,
      this.phoneNumber,
      this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
