class CheckUserModel {
  bool? success;
  String? message;
  String? data;
  User? user;

  CheckUserModel({this.success, this.message, this.data, this.user});

  CheckUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['data'] = this.data;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? shopId;
  String? name;
  String? email;
  String? countryCode;
  String? phoneNumber;
  String? dateOfBirth;
  String? avatar;
  String? address;
  String? customerLatitude;
  String? customerLongitude;
  String? country;
  String? city;
  String? state;
  String? zip;
  String? comment;
  String? companyName;
  String? account;
  int? activeStatus;
  int? customersOtp;
  String? createdAt;
  String? updatedAt;
  String? token;

  User(
      {this.id,
      this.shopId,
      this.name,
      this.email,
      this.countryCode,
      this.phoneNumber,
      this.dateOfBirth,
      this.avatar,
      this.address,
      this.customerLatitude,
      this.customerLongitude,
      this.country,
      this.city,
      this.state,
      this.zip,
      this.comment,
      this.companyName,
      this.account,
      this.activeStatus,
      this.customersOtp,
      this.createdAt,
      this.updatedAt,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shop_id'];
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    avatar = json['avatar'];
    address = json['address'];
    customerLatitude = json['customer_latitude'];
    customerLongitude = json['customer_longitude'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    comment = json['comment'];
    companyName = json['company_name'];
    account = json['account'];
    activeStatus = json['active_status'];
    customersOtp = json['customers_otp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_id'] = this.shopId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone_number'] = this.phoneNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['avatar'] = this.avatar;
    data['address'] = this.address;
    data['customer_latitude'] = this.customerLatitude;
    data['customer_longitude'] = this.customerLongitude;
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['comment'] = this.comment;
    data['company_name'] = this.companyName;
    data['account'] = this.account;
    data['active_status'] = this.activeStatus;
    data['customers_otp'] = this.customersOtp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    return data;
  }
}
