import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../model/getUser_detailsModel.dart';

Future<GetUserDetailModel> getUserDetails(userId) async {
  final storage = FlutterSecureStorage();
  var token = await storage.read(key: 'jwt');
  print("token $token");
  var headers = {'Authorization': 'Bearer $token'};
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://borc.coologeex.com/api/get-current-profile?id=$userId'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var getUserDetailsModel;
  if (response.statusCode == 200) {
    var resData = await response.stream.bytesToString();
    getUserDetailsModel = GetUserDetailModel.fromJson(json.decode(resData));
    print("j de ${json.decode(resData)}");
    print("getUserDetailsModel ${getUserDetailsModel.data!.name}");
    print("getUserDetailsModel ${getUserDetailsModel.data!.email}");
    print("getUserDetailsModel ${getUserDetailsModel}");

    return getUserDetailsModel;
  } else {
    print("get user api else ${response.reasonPhrase}");
    return getUserDetailsModel;
  }
}
