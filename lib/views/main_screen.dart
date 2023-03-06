import 'dart:convert' as json;

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ubiqmart_v1/api/api_call/getUserDetails.dart';
import 'package:ubiqmart_v1/model/getdataUser.dart';
import 'package:ubiqmart_v1/views/Drawer_list/Profile.dart';
import '../model/getUser_detailsModel.dart';
import 'Bottom_Navigation_screens/home.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  final String userId;
  const MainScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String _titleName = 'Home';
  getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        {
          _titleName = "Home";
        }
        break;
      case 1:
        {
          _titleName = "Search";
        }
        break;
      case 2:
        {
          _titleName = "Cart";
        }
        break;
      case 3:
        {
          _titleName = "Notification";
        }
    }
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Text("search"),
    Text("cart"),
    Text("notification"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      getAppBarTitle();
    });
  }

  //GetUserDetailModel userDetail = GetUserDetailModel();

  GetUserDataModel? getDataUser;
  getUserDetail() async {
    final storage = FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    print("token $token");
    var headers = {'Authorization': 'Bearer $token'};
    String uri =
        'https://borc.coologeex.com/api/get-current-profile?${widget.userId}';
    final response = await http.get(Uri.parse(uri), headers: headers);
    final jd = json.jsonDecode(response.body);
    print(" pri jd $jd");
    getDataUser = GetUserDataModel.fromJson(jd['data']);
    print("jd : ${getDataUser!.name}");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: getDataUser != null
            ? Scaffold(
                drawer: Drawer(
                    child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(color: Colors.green),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hello ${getDataUser!.name}..!",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 35),
                          ),

                          //Text("Welcome\nTo\nUbiqmart"),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Profile"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(
                                    name: getDataUser!.name.toString(),
                                    mobileNum:
                                        getDataUser!.phoneNumber.toString(),
                                    email: getDataUser!.email.toString(),
                                    dob: getDataUser!.dateOfBirth.toString())));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.book_outlined),
                      title: Text("Manage Address"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_cart),
                      title: Text("Your Orders"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.help),
                      title: Text("Need Help?"),
                      onTap: () {},
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(75, 50),
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          final storage = FlutterSecureStorage();
                          await storage.delete(key: 'jwt');
                          await storage.delete(key: 'loginStatus');
                          setState(() {});
                        },
                        child: Text("Logout"))
                  ],
                )),
                appBar: AppBar(
                  backgroundColor: Colors.green,
                  title: Text("$_titleName"),
                ),
                body: Center(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  unselectedIconTheme: IconThemeData(color: Colors.grey),
                  selectedIconTheme: IconThemeData(color: Colors.green),
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search), label: "Search"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_cart), label: "Cart"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.notifications), label: "Notification"),
                  ],
                ),
              )
            : Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
              ));
  }
}
