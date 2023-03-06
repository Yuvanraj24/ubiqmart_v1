import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ubiqmart_v1/model/checkUser_apiModel.dart';
import 'package:ubiqmart_v1/views/main_screen.dart';
import 'package:ubiqmart_v1/views/manage_profile.dart';
import '../api/api_call/auth/checkUser.dart';
import '../values/color.dart';
import '../values/constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final otpKeY = GlobalKey<FormState>();

  //OtP Controller declare
  final pin1Controller = TextEditingController();
  final pin2Controller = TextEditingController();
  final pin3Controller = TextEditingController();
  final pin4Controller = TextEditingController();

  FocusNode mobFocus = FocusNode();

  CheckUserModel checkUserRes = CheckUserModel();
  String userType = 'Login';

  String otp = '';
  String mobile = '';

  Map loginMap = {};

  String countryCode = "91";
  TextEditingController mobCtrl = TextEditingController();
  Map registerMap = {};
  String? customerOtp = '';

  saveTokenId(String token, int id) async {
    SharedPreferences tokenPref = await SharedPreferences.getInstance();
    tokenPref.setString('savedToken', token);
    tokenPref.setInt('user_id', id);
  }

  saveTokenLocalStorage(String token, int id) async {
    const storage = FlutterSecureStorage();
    print('login save token : $token');
    print("user id is :--> ${id}");
    await storage.write(key: 'jwt', value: token);
    await storage.write(key: 'user_id', value: id.toString());
    print("printing the yuvan token key : ${await storage.read(key: 'jwt')}");
    print(
        "printing the yuvan user....id key : ${await storage.read(key: 'user_id')}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    mobFocus.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(left: 18.sp, right: 18.sp),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 70.h),
                Text("UbiqMart",
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.green,
                    )),
                SizedBox(height: 35.h),
                Container(
                    height: 120.h,
                    width: 100.w,
                    color: Colors.blue,
                    margin: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset(MyConstants.brand),
                    )),
                SizedBox(height: 25.h),
                Text(
                  "Welcome You",
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 60.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode:
                              true, // optional. Shows phone code before the country name.
                          onSelect: (Country country) {
                            setState(() {
                              countryCode = country.phoneCode;
                            });
                            print('Select country: ${country.phoneCode}');
                          },
                        );
                      },
                      child: Container(
                          height: 46.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.12),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                              "+${countryCode}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      height: 46.h,
                      width: 265.w,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        controller: mobCtrl,
                        onChanged: (value) async {
                          if (value.length == 10) {
                            print("mobile number validation works..!");
                            String mobileNumber = mobCtrl.text.toString();
                            // print('checkuser ${mobileNumber.length}');
                            // print(
                            //     'checkuser function is ${await checkUser(countryCode, mobileNumber)}');

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: MyColors.greenAccent));
                                });
                            checkUserRes =
                                (await checkUser(countryCode, mobileNumber))!;
                            Navigator.of(context).pop();
                            FocusManager.instance.primaryFocus?.unfocus();

                            customerOtp =
                                checkUserRes.user!.customersOtp.toString();
                            print("cus user data ${checkUserRes.user!.name}");
                            saveTokenLocalStorage(
                                checkUserRes.user!.token.toString(),
                                checkUserRes.user!.id!);
                            saveTokenId(checkUserRes.user!.token.toString(),
                                checkUserRes.user!.id!);
                            if (checkUserRes.message == 'User already exists' &&
                                checkUserRes.user!.name != "") {
                              userType = 'Login';

                              print("log... ${userType}");
                            } else if (checkUserRes.user!.name == null) {
                              setState(() {
                                userType = 'Register';
                              });

                              print("reg ${userType}");
                            }
                            setState(() {
                              pin1Controller.text = customerOtp![0];
                              pin2Controller.text = customerOtp![1];
                              pin3Controller.text = customerOtp![2];
                              pin4Controller.text = customerOtp![3];
                            });
                            // FocusScope.of(context).nextFocus();
                          }
                        },
                        cursorWidth: 2,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 1.12.w)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 1.12.w)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 42.h,
                      width: 38.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.black, width: 1.12),
                      ),
                      child: TextFormField(
                        controller: pin1Controller,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 42.h,
                      width: 36.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.black, width: 1.12),
                      ),
                      child: TextFormField(
                        controller: pin2Controller,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 42.h,
                      width: 36.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.black, width: 1.12),
                      ),
                      child: TextFormField(
                        controller: pin3Controller,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 42.h,
                      width: 36.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.black, width: 1.12),
                      ),
                      child: TextFormField(
                        controller: pin4Controller,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          } else {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 60.h),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 16.sp),
                      fixedSize: Size(120.w, 42.h),
                    ),
                    onPressed: () async {
                      if (userType == 'Register') {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManageProfile()));
                      } else if (userType == 'Login' &&
                          checkUserRes.message == 'User already exists') {
                        final storage = FlutterSecureStorage();

                        var userId = await storage.read(key: 'user_id');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MainScreen(userId: "$userId")));
                      }
                    },
                    child: Text(userType))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
