class ReviewModel {
  String? sId;
  User? user;
  String? track;
  double? rating;
  String? review;
  String? createdAt;
  String? updatedAt;

  ReviewModel(
      {this.sId,
        this.user,
        this.track,
        this.rating,
        this.review,
        this.createdAt,
        this.updatedAt});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    track = json['track'];
    rating = double.parse(json['rating'].toString());
    review = json['review'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['track'] = track;
    data['rating'] = rating;
    data['review'] = review;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class User {
  String? name;
  String? profileImage;

  User({this.name, this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
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
