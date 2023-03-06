class GetBannerDataModel {
  int? httpCode;
  bool? success;
  String? message;
  List<BannerData>? data;

  GetBannerDataModel({this.httpCode, this.success, this.message, this.data});

  GetBannerDataModel.fromJson(Map<String, dynamic> json) {
    httpCode = json['httpCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BannerData>[];
      json['data'].forEach((v) {
        data!.add(BannerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['httpCode'] = this.httpCode;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerData {
  String? bannerPosition;
  String? bannerImage;
  int? storeId;

  BannerData({this.bannerPosition, this.bannerImage, this.storeId});

  BannerData.fromJson(Map<String, dynamic> json) {
    bannerPosition = json['banner_position'];
    bannerImage = json['banner_image'];
    storeId = json['store_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_position'] = this.bannerPosition;
    data['banner_image'] = this.bannerImage;
    data['store_id'] = this.storeId;
    return data;
  }
}
