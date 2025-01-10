import '../track-event/single_event_model.dart';

class TrackHistoryRunningModel {
  String? sId;
  String? user;
  String? host;
  String? track;
  TrackSlot? trackSlot;
  String? startDateTime;
  String? endDateTime;
  int? price;
  int? numOfPeople;
  String? status;
  List<MoreInfo>? moreInfo;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TrackHistoryRunningModel(
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

  TrackHistoryRunningModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    host = json['host'];
    track = json['track'];
    trackSlot = json['trackSlot'] != null
        ? TrackSlot.fromJson(json['trackSlot'])
        : null;
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    price = json['price'];
    numOfPeople = json['numOfPeople'];
    status = json['status'];
    if (json['moreInfo'] != null) {
      moreInfo = [];
      json['moreInfo'].forEach((v) {
        moreInfo!.add(MoreInfo.fromJson(v));
      });
    } else {
      moreInfo = []; // Default to empty list
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    data['host'] = host;
    data['track'] = track;
    if (trackSlot != null) {
      data['trackSlot'] = trackSlot!.toJson();
    }
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

class TrackSlot {
  String? day;
  String? slotNo;

  TrackSlot({this.day, this.slotNo});

  TrackSlot.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    slotNo = json['slotNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['slotNo'] = slotNo;
    return data;
  }
}
