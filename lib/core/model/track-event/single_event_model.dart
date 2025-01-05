class SingleEventModel {
  int? totalSeat;
  int? unSold;
  String? sId;
  String? host;
  String? eventName;
  List<String>? eventImage;
  String? address;
  Location? location;
  String? description;
  String? startDate;
  String? startTime;
  String? startDateTime;
  String? endDate;
  String? endTime;
  String? endDateTime;
  List<MoreInfo>? moreInfo;
  List<EventSlots>? slots;
  List<String>? bookings;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SingleEventModel(
      {this.totalSeat,
        this.unSold,
        this.sId,
        this.host,
        this.eventName,
        this.eventImage,
        this.address,
        this.location,
        this.description,
        this.startDate,
        this.startTime,
        this.startDateTime,
        this.endDate,
        this.endTime,
        this.endDateTime,
        this.moreInfo,
        this.slots,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SingleEventModel.fromJson(Map<String, dynamic> json) {
    totalSeat = json['totalSeat'];
    unSold = json['unSold'];
    sId = json['_id'];
    host = json['host'];
    eventName = json['eventName'];

    // Safely handle the event_image key
    eventImage = (json['event_image'] != null && json['event_image'] is List)
        ? List<String>.from(json['event_image'])
        : [];

    address = json['address'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    description = json['description'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    startDateTime = json['startDateTime'];
    endDate = json['endDate'];
    endTime = json['endTime'];
    endDateTime = json['endDateTime'];

    if (json['moreInfo'] != null) {
      moreInfo = <MoreInfo>[];
      json['moreInfo'].forEach((v) {
        moreInfo!.add(MoreInfo.fromJson(v));
      });
    }

    if (json['slots'] != null) {
      slots = <EventSlots>[];
      json['slots'].forEach((v) {
        slots!.add(EventSlots.fromJson(v));
      });
    }

    bookings = json['bookings'] != null
        ? List<String>.from(json['bookings'])
        : [];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalSeat'] = totalSeat;
    data['unSold'] = unSold;
    data['_id'] = sId;
    data['host'] = host;
    data['eventName'] = eventName;
    data['event_image'] = eventImage;
    data['address'] = address;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['description'] = description;
    data['startDate'] = startDate;
    data['startTime'] = startTime;
    data['startDateTime'] = startDateTime;
    data['endDate'] = endDate;
    data['endTime'] = endTime;
    data['endDateTime'] = endDateTime;
    if (moreInfo != null) {
      data['moreInfo'] = moreInfo!.map((v) => v.toJson()).toList();
    }
    if (slots != null) {
      data['slots'] = slots!.map((v) => v.toJson()).toList();
    }
    data['bookings'] = this.bookings;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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

class MoreInfo {
  String? label;
  String? fieldType;
  String? sId;

  MoreInfo({this.label, this.fieldType, this.sId});

  MoreInfo.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    fieldType = json['fieldType'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['fieldType'] = fieldType;
    data['_id'] = sId;
    return data;
  }
}

class EventSlots {
  String? sId;
  String? host;
  String? event;
  String? slotNo;
  int? price;
  int? maxPeople;
  int? currentPeople;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  EventSlots(
      {this.sId,
        this.host,
        this.event,
        this.slotNo,
        this.price,
        this.maxPeople,
        this.currentPeople,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV});

  EventSlots.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    host = json['host'];
    event = json['event'];
    slotNo = json['slotNo'];
    price = json['price'];
    maxPeople = json['maxPeople'];
    currentPeople = json['currentPeople'];
    description = json['description'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['host'] = host;
    data['event'] = event;
    data['slotNo'] = slotNo;
    data['price'] = price;
    data['maxPeople'] = maxPeople;
    data['currentPeople'] = currentPeople;
    data['description'] = description;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
