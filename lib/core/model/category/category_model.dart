class CategoryModel {
  String? sId;
  String? name;
  String? categoryImage;
  String? createdAt;
  String? updatedAt;

  CategoryModel(
      {this.sId,
      this.name,
      this.categoryImage,
      this.createdAt,
      this.updatedAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString() == 'null' ? '' : json['_id'].toString();
    name = json['name'].toString() == 'null' ? '' : json['name'].toString();
    categoryImage = json['category_image'].toString() == 'null'
        ? ''
        : json['category_image'].toString();
    createdAt = json['createdAt'].toString() == 'null'
        ? ''
        : json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString() == 'null'
        ? ''
        : json['updatedAt'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['category_image'] = categoryImage;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
