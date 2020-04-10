import 'package:flutter/material.dart';
import 'screens/screens.dart';
import 'theme.dart';
import 'strings.dart';

void main() => runApp(App());

class App extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.title,
      initialRoute: "/log_in",
      theme: AppTheme,
      routes: {
        "/log_in": (context) => LogIn(),
        "/log_in/sign_up" : (context) => SignUp(),
        "/map_explore": (context) => MapExplore(),
        "/map_explore/store_info" : (context) => StoreInfo(),
        "/map_explore/store_info/report" : (context) => Report(),
        "/map_explore/store_info/report/infinity" : (context) => Infinity()
      },
    );
  }
}
