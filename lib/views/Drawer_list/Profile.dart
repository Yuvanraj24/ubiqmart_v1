import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String name;
  final String mobileNum;
  final String email;
  final String dob;
  const Profile(
      {Key? key,
      required this.name,
      required this.mobileNum,
      required this.email,
      required this.dob})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Profile"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 40, left: 80, right: 60),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/customer_info_background.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 30)),
            RichText(
              text: TextSpan(
                  text: 'Full Name  :  ',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w800,
                      fontSize: 18),
                  children: [
                    TextSpan(
                      text: '${name}',
                      style:
                          TextStyle(color: Colors.brown.shade600, fontSize: 16),
                    )
                  ]),
            ),
            SizedBox(height: 12),
            // RichText(
            //   text: TextSpan(
            //       text: 'Mobile Number  :  ',
            //       style: TextStyle(
            //           color: Colors.black54,
            //           fontWeight: FontWeight.w800,
            //           fontSize: 18),
            //       children: [
            //         TextSpan(
            //           text: '${mobileNum}',
            //           style:
            //               TextStyle(color: Colors.brown.shade600, fontSize: 16),
            //         )
            //       ]),
            // ),
            // SizedBox(height: 5),
            // RichText(
            //   text: TextSpan(
            //       text: 'Email  :  ',
            //       style: TextStyle(
            //           color: Colors.black54,
            //           fontWeight: FontWeight.w800,
            //           fontSize: 18),
            //       children: [
            //         TextSpan(
            //           text: '${email}',
            //           style:
            //               TextStyle(color: Colors.brown.shade600, fontSize: 16),
            //         )
            //       ]),
            // ),
            // SizedBox(height: 5),
            RichText(
              text: TextSpan(
                  text: 'Date of Birth  :  ',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w800,
                      fontSize: 18),
                  children: [
                    TextSpan(
                      text: '${dob}',
                      style:
                          TextStyle(color: Colors.brown.shade600, fontSize: 16),
                    )
                  ]),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.black54,
                ),
                SizedBox(width: 15),
                Text(
                  "${mobileNum}",
                  style: TextStyle(
                      color: Colors.brown.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                )
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.mail,
                  color: Colors.black54,
                ),
                SizedBox(width: 15),
                Text(
                  "${email}",
                  style: TextStyle(
                      color: Colors.brown.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
