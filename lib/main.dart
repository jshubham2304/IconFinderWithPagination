import 'package:flutter/material.dart';
import 'package:iconfinder/view/pages/home_screen.dart';
import 'package:iconfinder/view_model/category_respository.dart';
import 'package:iconfinder/view_model/icon_set_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CatgeoryRepo>(
            create: (_) => CatgeoryRepo(),
          ),
          ChangeNotifierProvider<IconSetRepository>(
            create: (_) => IconSetRepository(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Consumer2<CatgeoryRepo, IconSetRepository>(
            builder:
                (context, CatgeoryRepo repo, IconSetRepository repository, _) {
              return HomeScreen();
            },
          ),
        ));
  }
}
