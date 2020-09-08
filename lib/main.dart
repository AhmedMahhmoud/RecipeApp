import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Models/RecipeModelProvider.dart';
import 'Views/Home.dart';
import 'Views/WebScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RecipeProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: AnimatedSplashScreen(
          nextScreen: HomePage(),
          splash: Container(
            width: 400,
            height: 300,
            child: Image.asset(
              "lib/assets/assets/images.png",
              fit: BoxFit.fill,
            ),
          ),
          splashTransition: SplashTransition.scaleTransition,
          backgroundColor: Color(0xff17293D),
          duration: 3000,
        ),
      ),
    );
  }
}
