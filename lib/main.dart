import 'package:flutter/material.dart';
import 'package:iconfinder/view/pages/home_screen.dart';
import 'package:iconfinder/view_model/category_notifier.dart';
import 'package:iconfinder/view_model/icon_notifier.dart';
import 'package:iconfinder/view_model/icon_set_notifier.dart';
import 'package:iconfinder/view_model/search_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    precacheImage(const AssetImage('assets/images/loader_bike.gif'), context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryNotifier>(
          create: (_) => CategoryNotifier(),
        ),
        ChangeNotifierProvider<IconSetNotifier>(
          create: (_) => IconSetNotifier(),
        ),
        ChangeNotifierProvider<IconNotifier>(
          create: (_) => IconNotifier(),
        ),
        ChangeNotifierProvider<SearchNotifier>(
          create: (_) => SearchNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'Square Boat Task',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'GoogleSans',
          primaryColor: Colors.black,
          accentColor: Colors.black,
          primaryColorDark: Colors.black,
          primaryColorLight: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
