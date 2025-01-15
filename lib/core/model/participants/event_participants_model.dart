class EventParticipantsModel {
  String? sId;
  User? user;
  String? host;
  String? event;
  String? eventSlot;
  String? startDateTime;
  String? endDateTime;
  int? price;
  int? numOfPeople;
  String? bookingFor;
  List<MoreInfo>? moreInfo;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  EventParticipantsModel(
      {this.sId,
        this.user,
        this.host,
        this.event,
        this.eventSlot,
        this.startDateTime,
        this.endDateTime,
        this.price,
        this.numOfPeople,
        this.bookingFor,
        this.moreInfo,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV});

  EventParticipantsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    host = json['host'];
    event = json['event'];
    eventSlot = json['eventSlot'];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    price = json['price'];
    numOfPeople = json['numOfPeople'];
    bookingFor = json['bookingFor'];
    if (json['moreInfo'] != null) {
      moreInfo = <MoreInfo>[];
      json['moreInfo'].forEach((v) {
        moreInfo!.add(MoreInfo.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['host'] = host;
    data['event'] = event;
    data['eventSlot'] = eventSlot;
    data['startDateTime'] = startDateTime;
    data['endDateTime'] = endDateTime;
    data['price'] = price;
    data['numOfPeople'] = numOfPeople;
    data['bookingFor'] = bookingFor;
    if (moreInfo != null) {
      data['moreInfo'] = moreInfo!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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
      {
        this.name,
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
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['phoneNumber'] = phoneNumber;
    data['profile_image'] = profileImage;
    return data;
  }
}

class MoreInfo {
  String? label;
  String? value;
  String? sId;

  MoreInfo({this.label, this.value, this.sId});

  MoreInfo.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    data['_id'] = sId;
    return data;
  }
}
