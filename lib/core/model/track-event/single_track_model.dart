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
  String? totalLikes; // Changed to String? with conversion
  String? totalReview; // Changed to String? with conversion
  String? createdAt;
  String? updatedAt;
  int? iV; // Changed to int? to match the API response
  String? totalTrackDayInMonth;
  double? rating;

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
    trackDays = json['trackDays']?.cast<String>();
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

    // Convert `int` to `String` if necessary
    totalLikes = json['totalLikes']?.toString();
    totalReview = json['totalReview']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    iV = json['__v']; // Keep as integer
    totalTrackDayInMonth = json['totalTrackDayInMonth']?.toString();
    rating = json['rating']?.toDouble();
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
    data['__v'] = iV; // Serialize as int
    data['totalTrackDayInMonth'] = totalTrackDayInMonth;
    data['rating'] = rating;
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
  String? day;
  String? slotNo;
  String? startTime;
  String? endTime;
  int? price;
  int? maxPeople;
  String? description;

  TrackSlots(
      {this.sId,
      this.host,
      this.track,
      this.day,
      this.slotNo,
      this.startTime,
      this.endTime,
      this.price,
      this.maxPeople,
      this.description});

  TrackSlots.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    host = json['host'];
    track = json['track'];
    day = json['day'];
    slotNo = json['slotNo'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    price = json['price'];
    maxPeople = json['maxPeople'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['host'] = host;
    data['track'] = track;
    data['day'] = day;
    data['slotNo'] = slotNo;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['price'] = price;
    data['maxPeople'] = maxPeople;
    data['description'] = description;
    return data;
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
