class EventForUserPanelModel {
  String? sId;
  String? host;
  String? eventName;
  List<String>? eventImage;
  String? address;
  Location? location;
  String? description;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  List<String>? slots;
  String? status;

  EventForUserPanelModel(
      {this.sId,
        this.host,
        this.eventName,
        this.eventImage,
        this.address,
        this.location,
        this.description,
        this.startDate,
        this.startTime,
        this.endDate,
        this.endTime,
        this.slots,
        this.status});

  EventForUserPanelModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    host = json['host'];
    eventName = json['eventName'];
    eventImage = json['event_image'].cast<String>();
    address = json['address'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    description = json['description'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    endDate = json['endDate'];
    endTime = json['endTime'];
    slots = json['slots'].cast<String>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['endDate'] = endDate;
    data['endTime'] = endTime;
    data['slots'] = slots;
    data['status'] = status;
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
