import 'package:get/get.dart';

class SingleTrackModel {
  String? sId;
  String? host;
  String? trackName;
  String? category;
  List<String>? trackImage;
  String? address;
  Location? location;
  String? description;
  String? status;
  bool? isPromoted;
  List<String>? trackDays;
  List<Renters>? renters;
  List<TrackSlots>? slots;
  String? totalLikes;
  String? totalReview;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? totalTrackDayInMonth;
  double? rating;

  /// 👇 Add this new property
  List<String>? slotAvailableDates;

  SingleTrackModel({
    this.sId,
    this.host,
    this.trackName,
    this.category,
    this.trackImage,
    this.address,
    this.location,
    this.description,
    this.status,
    this.isPromoted,
    this.trackDays,
    this.renters,
    this.slots,
    this.totalLikes,
    this.totalReview,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.totalTrackDayInMonth,
    this.rating,
    this.slotAvailableDates, // add here
  });

  SingleTrackModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    host = json['host'];
    trackName = json['trackName'];
    category = json['category'];
    trackImage = json['track_image']?.cast<String>();
    address = json['address'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    description = json['description'];
    status = json['status'];
    isPromoted = json['isPromoted'];
    // trackDays = json['trackDays']?.cast<String>();
    if (json['renters'] != null) {
      renters = <Renters>[];
      json['renters'].forEach((v) {
        renters!.add(Renters.fromJson(v));
      });
    }
    if (json['slots'] != null) {
      slots = <TrackSlots>[];
      json['slots'].forEach((v) {
        slots!.add(TrackSlots.fromJson(v));
      });
    }
    totalLikes = json['totalLikes']?.toString();
    totalReview = json['totalReview']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    iV = json['__v'];
    totalTrackDayInMonth = json['totalTrackDayInMonth']?.toString();
    rating = json['rating']?.toDouble();

    /// 👇 parse slotAvailableDates
    slotAvailableDates = (json['slotAvailableDates'] as List?)
        ?.map((e) => e.toString())
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['host'] = host;
    data['trackName'] = trackName;
    data['category'] = category;
    data['track_image'] = trackImage;
    data['address'] = address;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['description'] = description;
    data['status'] = status;
    data['isPromoted'] = isPromoted;
    data['trackDays'] = trackDays;
    if (renters != null) {
      data['renters'] = renters!.map((v) => v.toJson()).toList();
    }
    if (slots != null) {
      data['slots'] = slots!.map((v) => v.toJson()).toList();
    }
    data['totalLikes'] = totalLikes;
    data['totalReview'] = totalReview;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['totalTrackDayInMonth'] = totalTrackDayInMonth;
    data['rating'] = rating;

    /// 👇 serialize slotAvailableDates
    data['slotAvailableDates'] = slotAvailableDates;

    return data;
  }
}

class Location {
  List<double>? coordinates;
  String? type;

  Location({this.coordinates, this.type});

  Location.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<double>();
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coordinates'] = coordinates;
    data['type'] = type;
    return data;
  }
}

class TrackSlots {
  String? sId;
  String? host;
  String? track;
  int? day;
  String? slotNo;
  String? startTime;
  String? endTime;
  String? currency;
  RxBool isSelected = false.obs; // 👈 reactive
  int? price;
  int? maxPeople;
  String? description;

  TrackSlots({
    this.sId,
    this.host,
    this.track,
    this.day,
    this.slotNo,
    this.startTime,
    this.currency,
    this.endTime,
    this.price,
    this.maxPeople,
    this.description,
    bool? isSelected,
  }) {
    this.isSelected.value = isSelected ?? false; // initialize
  }

  TrackSlots.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    host = json['host'];
    track = json['track'];
    day = json['dayNo'];
    slotNo = json['slotNo'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    currency = json['currency'];
    price = json['price'];
    maxPeople = json['maxPeople'];
    description = json['description'];
    isSelected.value = json['isSelected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'host': host,
      'track': track,
      'dayNo': day,
      'slotNo': slotNo,
      'startTime': startTime,
      'endTime': endTime,
      'currency': currency,
      'price': price,
      'maxPeople': maxPeople,
      'description': description,
      'isSelected': isSelected.value, // 👈 save bool value
    };
  }
}

class Renters {
  String? sId;
  String? authId;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? address;
  String? profileImage;

  Renters(
      {this.sId,
      this.authId,
      this.name,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.address,
      this.profileImage});

  Renters.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    authId = json['authId'];
    name = json['name'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    address = json['address'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['authId'] = authId;
    data['name'] = name;
    data['email'] = email;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['address'] = address;
    data['profile_image'] = profileImage;
    return data;
  }
}
