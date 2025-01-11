class ManageModel {
  String? sId;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ManageModel(
      {this.sId, this.description, this.createdAt, this.updatedAt, this.iV});

  ManageModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
