class RentersModel {
  String? status;
  String? sId;
  User? user;
  String? host;
  String? event;
  String? eventSlot;
  String? startDateTime;
  String? endDateTime;
  double? price;
  int? numOfPeople;
  String? bookingFor;
  List<MoreInfo>? moreInfo;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RentersModel(
      {this.status,
        this.sId,
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
        this.createdAt,
        this.updatedAt,
        this.iV});

  RentersModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString(); // Convert to String if it's not already
    sId = json['_id']?.toString();      // Convert to String if it's not already
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    host = json['host']?.toString();    // Convert to String if it's not already
    event = json['event']?.toString();  // Convert to String if it's not already
    eventSlot = json['eventSlot']?.toString(); // Convert to String if it's not already
    startDateTime = json['startDateTime']?.toString();
    endDateTime = json['endDateTime']?.toString();

    // Handle price as double, converting int if necessary
    price = json['price'] != null ? (json['price'] is int ? (json['price'] as int).toDouble() : json['price']) : null;

    numOfPeople = json['numOfPeople']; // No conversion needed as it's already int
    bookingFor = json['bookingFor']?.toString();

    if (json['moreInfo'] != null) {
      moreInfo = <MoreInfo>[];
      json['moreInfo'].forEach((v) {
        moreInfo!.add(MoreInfo.fromJson(v));
      });
    }

    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    iV = json['__v']; // No conversion needed as it's already int
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
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
  String? profileImage;
  String? phoneNumber;

  User(
      {this.name,
        this.email,
        this.address,
        this.profileImage,
        this.phoneNumber});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    address = json['address'];
    profileImage = json['profile_image'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['profile_image'] = profileImage;
    data['phoneNumber'] = phoneNumber;
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
