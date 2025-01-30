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

    // ✅ Ensure `price` is always an `int`
    price = json['price'] is int
        ? json['price']
        : (json['price'] is double ? json['price'].toInt() : null);

    // ✅ Ensure `numOfPeople` is always an `int`
    numOfPeople = json['numOfPeople'] is int
        ? json['numOfPeople']
        : (json['numOfPeople'] is double ? json['numOfPeople'].toInt() : null);

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

    // ✅ Ensure `iV` is always an `int`
    iV = json['__v'] is int ? json['__v'] : (json['__v'] is double ? json['__v'].toInt() : null);
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
    data['price'] = price ?? 0; // Ensures price is never null
    data['numOfPeople'] = numOfPeople ?? 1; // Default to 1 person if null
    data['bookingFor'] = bookingFor;
    if (moreInfo != null) {
      data['moreInfo'] = moreInfo!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV ?? 0; // Ensures version is always an int
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
