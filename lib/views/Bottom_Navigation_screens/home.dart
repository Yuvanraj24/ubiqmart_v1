import 'dart:convert' as json;
import 'package:http/http.dart' as http;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ubiqmart_v1/views/widgets/carousel_slider.dart';
import 'package:ubiqmart_v1/views/widgets/home_grid.dart';

import '../../model/getBannerData_apiModel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeIndex = 1;
  int a = 0;
  GetBannerDataModel? getBanData;
  List topBannerData = [];
  List bottomBannerData = [];

  getBannerData(latitude, longitude) async {
    print("gggggg $getBanData");
    final storage = FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    print("token $token");
    var headers = {'Authorization': 'Bearer $token'};
    String url =
        'https://borc.coologeex.com/api/store-banner?latitude=${latitude}&longitude=${longitude}';
    final response = await http.get(Uri.parse(url), headers: headers);
    final jd = json.jsonDecode(response.body);
    print("print Banner Data res body...>>> $jd");

    getBanData = await GetBannerDataModel.fromJson(jd);

    print("heyyyy yuvan : ${getBanData}");
    print("get bannaer... ${getBanData!.data![0].storeId}");
    for (int i = 0; i < getBanData!.data!.length; i++) {
      if (getBanData!.data![i].bannerPosition == "Top Banner") {
        print("top ban check :- ${getBanData!.data![i].bannerPosition}");
        topBannerData.add(getBanData!.data![i].bannerImage);
      } else {
        bottomBannerData.add(getBanData!.data![i]);
      }
    }
    print("top ban ${topBannerData}");
    print("low ban ${bottomBannerData}");
    setState(() {
      a = 1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBannerData(11.0010909, 77.0449782);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: a == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.only(top: 30),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        CarouselSlider.builder(
                            itemCount: topBannerData.length,
                            itemBuilder: (context, index, realIndex) =>
                                carouselItemModel(topBannerData[index]),
                            options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                activeIndex = index;
                                setState(() {});
                                print("index $activeIndex");
                                print("reason..$reason");
                              },
                              initialPage: 1,
                              height: 180.0,
                              enlargeCenterPage: false,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 600),
                              viewportFraction: 0.8,
                            )),
                        SizedBox(height: 16.w),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                indicators(topBannerData.length, activeIndex))
                      ],
                    ),
                    SizedBox(height: 25.h),
                    // Container(
                    //   padding: EdgeInsets.only(left: 2.sp, right: 2.sp),
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Container(
                    //             width: MediaQuery.of(context).size.width / 2.1,
                    //             height: 170,
                    //             decoration: BoxDecoration(
                    //               color: Colors.blue,
                    //               border: Border.all(color: Colors.black54),
                    //               image: DecorationImage(
                    //                 image: NetworkImage(
                    //                     "https://c4.wallpaperflare.com/wallpaper/835/732/63/discounts-interest-joy-girl-wallpaper-preview.jpg"),
                    //                 fit: BoxFit.fill,
                    //               ),
                    //             ),
                    //           ),
                    //           Container(
                    //             width: MediaQuery.of(context).size.width / 2.1,
                    //             height: 170,
                    //             decoration: BoxDecoration(
                    //               color: Colors.red,
                    //               border: Border.all(color: Colors.black54),
                    //               image: DecorationImage(
                    //                 image: NetworkImage(
                    //                     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7vLAuEc9vNDNDiR4mw-NPZJOe4A7ieXkybhHEumcXopd26yKTI58loSxIDOAsuRpS2KQ&usqp=CAU"),
                    //                 fit: BoxFit.fill,
                    //               ),
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //       // HomeGrid(),
                    //     ],
                    //   ),
                    // )
                    GridView.builder(
                      itemCount: 8,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 2.1,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: Colors.black54),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://c4.wallpaperflare.com/wallpaper/835/732/63/discounts-interest-joy-girl-wallpaper-preview.jpg"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )));
  }

  Widget carouselItemModel(imageUrl) {
    return Container(
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }
}
