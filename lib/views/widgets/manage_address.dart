import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageAddress extends StatelessWidget {
  const ManageAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.h, bottom: 15.h, left: 10.w),
      width: 330,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Chennai',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          SizedBox(height: 25),
          Text('#12, Rth street, Asambakkam,',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
          SizedBox(
            height: 2.h,
          ),
          Text('12, I floor, 4th Street, New Colony,',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
          SizedBox(
            height: 2.h,
          ),
          Text('Adambakkam, Chennai, Tamil Nadu,',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
          SizedBox(
            height: 2.h,
          ),
          Text('600088, India',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(width: 2.w, color: Colors.orange.shade300),
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
