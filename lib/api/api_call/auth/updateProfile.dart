import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ubiqmart_v1/api/values/api_base.dart';

import '../../../model/updateProfile_apiModel.dart';

updateProfile(name, email, address, latitude, longitude, city, zip, state,
    country, dob, shop_id) async {
  final storage = FlutterSecureStorage();
  var token = await storage.read(key: 'jwt');
  print("token $token");
  var headers = {'Authorization': 'Bearer $token'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('${BaseApi.baseUrl}update-profile'));
  request.fields.addAll({
    'name': '$name',
    'email': '$email',
    'address': '$address',
    'latitude': '$latitude',
    'longitude': '$longitude',
    'country': '$country',
    'city': '$city',
    'zip': '$zip',
    'state': '$state',
    'date_of_birth': '$dob',
    'shop_id': '$shop_id'
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var resData = await response.stream.bytesToString();
    print("resData updateProfile ${resData}");
    var updateProfileModel = UpdateProfile.fromJson(json.decode(resData));
    print("Update profile model ${updateProfileModel.data!.name}");
  } else {
    print(response.reasonPhrase);
  }
}
