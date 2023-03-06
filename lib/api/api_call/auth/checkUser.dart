import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ubiqmart_v1/api/values/api_base.dart';
import 'package:ubiqmart_v1/model/checkUser_apiModel.dart';

Future<CheckUserModel?> checkUser(countryCode, mobileNumber) async {
  var request = http.MultipartRequest('POST',
      Uri.parse('${BaseApi.baseUrl}check-user?phone_number=${mobileNumber}'));
  request.fields.addAll(
      {'country_code': '${countryCode}', 'phone_number': '${mobileNumber}'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print("Status 200 is success");
    var resData = await response.stream.bytesToString();
    print("printing response data ${resData}");
    var checkUserModel = CheckUserModel.fromJson(json.decode(resData));
    print("checkkk ---- ${checkUserModel.data}");
    print("checkkk 111 ---- ${checkUserModel.message}");
    return checkUserModel;
  } else {
    print(response.reasonPhrase);
    return null;
  }
}
