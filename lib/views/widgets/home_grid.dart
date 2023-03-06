import 'package:flutter/material.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: MediaQuery.of(context).size.width / 3.2,
          height: 150,
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
    );
  }
}
