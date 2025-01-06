import 'package:track_trek/core/model/participants/event_participants_model.dart';

class TrackParticipantsModel {
  String? sId;
  User? user;
  String? host;
  String? track;
  String? trackSlot;
  String? startDateTime;
  String? endDateTime;
  int? price;
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
        this.numOfPeople,
        this.status,
        this.moreInfo,
        this.createdAt,
        this.updatedAt,
        this.iV});

  TrackParticipantsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    host = json['host'];
    track = json['track'];
    trackSlot = json['trackSlot'];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    price = json['price'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['host'] = host;
    data['track'] = track;
    data['trackSlot'] = trackSlot;
    data['startDateTime'] = startDateTime;
    data['endDateTime'] = endDateTime;
    data['price'] = price;
    data['numOfPeople'] = numOfPeople;
    data['status'] = status;
    if (moreInfo != null) {
      data['moreInfo'] = moreInfo!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}


