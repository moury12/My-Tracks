class PromoteTrackModel {
  String? track;
  String? bannerImage;

  PromoteTrackModel({this.track, this.bannerImage});

  PromoteTrackModel.fromJson(Map<String, dynamic> json) {
    track = json['track'];
    bannerImage = json['banner_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['track'] = this.track;
    data['banner_image'] = this.bannerImage;
    return data;
  }
}
