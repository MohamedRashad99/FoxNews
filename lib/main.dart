import 'package:container/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utilities/app_them.dart';
import 'shared_ui/navigation_drawer.dart';

main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // bool seen=prefs.getBool('seen');
  // Widget _screen ;
  // if(seen != null || seen== false){
  //   _screen=OnBoarding();
  // }else{
  //   _screen=HomeScreen();
  // }


  //runApp(NewsApp(_screen));
  runApp(NewsApp());
}
class NewsApp extends StatelessWidget {
  // final Widget _screen;
  //
  // NewsApp(this._screen);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
      //home : this._screen,
      home : OnBoarding(),
    );
  }
}


