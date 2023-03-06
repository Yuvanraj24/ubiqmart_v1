import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ubiqmart_v1/api/api_call/auth/updateProfile.dart';
import 'package:ubiqmart_v1/views/main_screen.dart';

class ManageProfile extends StatefulWidget {
  const ManageProfile({Key? key}) : super(key: key);

  @override
  State<ManageProfile> createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController mobCtrl = TextEditingController();
  TextEditingController mailCtrl = TextEditingController();
  TextEditingController dobCtrl = TextEditingController();

  TextStyle headStyle = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Form(
        key: _formKey,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Full Name', style: headStyle),
                SizedBox(height: 10.h),
                textFormField(nameCtrl),
                SizedBox(height: 30.h),
                Text('Mobile Number', style: headStyle),
                SizedBox(height: 10.h),
                textFormField(mobCtrl),
                SizedBox(height: 30.h),
                Text('Email ID', style: headStyle),
                SizedBox(height: 10.h),
                textFormField(mailCtrl),
                SizedBox(height: 30.h),
                Text('Date of Birth', style: headStyle),
                SizedBox(height: 10.h),
                textFormField(dobCtrl),
                SizedBox(height: 20.h),
                SizedBox(height: 20.h),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 50)),
                      onPressed: () async {
                        final storage = FlutterSecureStorage();
                        updateProfile(
                            nameCtrl.text,
                            mailCtrl.text,
                            'Block K, Annanagar East ',
                            "11.0168",
                            "76.9558",
                            "Coimbatore",
                            "641109",
                            "Tamil Nadu",
                            "India",
                            dobCtrl.text,
                            0);
                        await storage.write(key: 'loginStatus', value: 'yes');
                        String? userId = await storage.read(key: 'user_id');
                        print("user id in manage profile print $userId");

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MainScreen(userId: userId.toString())));
                      },
                      child: Text("Next")),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget textFormField(
    TextEditingController controller,
  ) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          border: OutlineInputBorder()),
    );
  }
}
