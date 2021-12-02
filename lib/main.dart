import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/pages/foods_page.dart';
import 'package:page_transition/page_transition.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  //final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  static final String title = 'Foods SQLite';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.blueGrey.shade900,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      home:SafeArea(child: MyHomePage())

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen.withScreenFunction(
      splash:
            Image.asset(
                'assets/Logo_s.png',
            ),//(Icons.fastfood, color: Colors.white,size: 100,),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.blueGrey.shade900,
        duration: 3000,
        screenFunction: ()async{ return FoodsPage();},
        pageTransitionType: PageTransitionType.fade,
      disableNavigation: true,
    );
  }
}