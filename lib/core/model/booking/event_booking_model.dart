class EventHistoryRunningModel {
  String? sId;
  String? user;
  String? host;
  Event? event;
  EventSlot? eventSlot;
  String? startDateTime;
  String? endDateTime;
  int? price;
  String? currency;
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
        this.currency,
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
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
    eventSlot = json['eventSlot'] != null
        ? new EventSlot.fromJson(json['eventSlot'])
        : null;
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    price = json['price'] is int
        ? json['price']
        : (json['price'] is double ? json['price'].toInt() : null);
    numOfPeople = json['numOfPeople'] is int
        ? json['numOfPeople']
        : (json['numOfPeople'] is double ? json['numOfPeople'].toInt() : null);
    currency = json['currency'];
    bookingFor = json['bookingFor'];
    if (json['moreInfo'] != null) {
      moreInfo = <MoreInfo>[];
      json['moreInfo'].forEach((v) {
        moreInfo!.add(new MoreInfo.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['host'] = this.host;
    if (this.event != null) {
      data['event'] = this.event!.toJson();
    }
    if (this.eventSlot != null) {
      data['eventSlot'] = this.eventSlot!.toJson();
    }
    data['startDateTime'] = this.startDateTime;
    data['endDateTime'] = this.endDateTime;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['numOfPeople'] = this.numOfPeople;
    data['bookingFor'] = this.bookingFor;
    if (this.moreInfo != null) {
      data['moreInfo'] = this.moreInfo!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['eventName'] = this.eventName;
    data['address'] = this.address;
    data['startDateTime'] = this.startDateTime;
    data['endDateTime'] = this.endDateTime;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['maxPeople'] = this.maxPeople;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    data['_id'] = this.sId;
    return data;
  }
}

