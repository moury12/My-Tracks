class EventHistoryRunningModel {
  String? sId;
  String? user;
  String? host;
  Event? event;
  EventSlot? eventSlot;
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

  EventHistoryRunningModel(
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

  EventHistoryRunningModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    host = json['host'];
    event = json['event'] != null ? Event.fromJson(json['event']) : null;
    eventSlot = json['eventSlot'] != null
        ? EventSlot.fromJson(json['eventSlot'])
        : null;
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
    data['user'] = user;
    data['host'] = host;
    if (event != null) {
      data['event'] = event!.toJson();
    }
    if (eventSlot != null) {
      data['eventSlot'] = eventSlot!.toJson();
    }
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

class Event {
  String? sId;
  String? eventName;
  String? address;
  String? startDateTime;
  String? endDateTime;

  Event(
      {this.sId,
        this.eventName,
        this.address,
        this.startDateTime,
        this.endDateTime});

  Event.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    eventName = json['eventName'];
    address = json['address'];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['eventName'] = eventName;
    data['address'] = address;
    data['startDateTime'] = startDateTime;
    data['endDateTime'] = endDateTime;
    return data;
  }
}

class EventSlot {
  String? sId;
  int? maxPeople;

  EventSlot({this.sId, this.maxPeople});

  EventSlot.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    maxPeople = json['maxPeople'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['maxPeople'] = maxPeople;
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
