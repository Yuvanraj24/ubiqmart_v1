import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:ubiqmart_v1/provider/theme_provider.dart';
import 'package:ubiqmart_v1/views/login.dart';
import 'package:ubiqmart_v1/views/main_screen.dart';

String? token;
String? userId;
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  final storage = FlutterSecureStorage();
  token = await storage.read(key: 'loginStatus');
  userId = await storage.read(key: 'user_id');
  print("The Token on main Function :--> ${token}");
  print("The user id in main func ${userId}");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => ThemeProvider(),
                  )
                ],
                builder: (context, child) => token == "yes"
                    ? MainScreen(
                        userId: userId!,
                      )
                    : Login(),
              ));
        });
  }
}
