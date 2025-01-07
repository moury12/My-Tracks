
import 'package:get/get.dart';

class TrackForUserPanelModel {
  String? sId;
  Host? host;
  String? trackName;
  String? category;
  List<String>? trackImage;
  String? address;
  Location? location;
  String? description;
  String? status;
  bool? isPromoted;
  List<String>? trackDays;
  List<String>? renters;
  List<String>? slots;
  int? totalLikes;
  int? totalReview;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? totalTrackDayInMonth;
  double? rating;
  bool? isLiked;

  TrackForUserPanelModel(
      {this.sId,
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
        this.isLiked =false
      });

  TrackForUserPanelModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    host = json['host'] != null ? new Host.fromJson(json['host']) : null;
    trackName = json['trackName'];
    category = json['category'];
    trackImage = json['track_image'].cast<String>();
    address = json['address'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    description = json['description'];
    status = json['status'];
    isPromoted = json['isPromoted'];
    trackDays = json['trackDays'].cast<String>();
    renters = json['renters'].cast<String>();
    slots = json['slots'].cast<String>();
    totalLikes = json['totalLikes'];
    totalReview = json['totalReview'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    totalTrackDayInMonth = json['totalTrackDayInMonth'];
    rating = json['rating'];
    isLiked = json['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (host != null) {
      data['host'] = host!.toJson();
    }
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
    data['renters'] = renters;
    data['slots'] = slots;
    data['totalLikes'] = totalLikes;
    data['totalReview'] = totalReview;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['totalTrackDayInMonth'] = totalTrackDayInMonth;
    data['rating'] = rating;
    data['isLiked'] = isLiked;
    return data;
  }
}

class Host {
  String? name;
  String? profileImage;

  Host({this.name, this.profileImage});

  Host.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['profile_image'] = profileImage;
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
