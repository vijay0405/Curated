import 'package:curated/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/mainDrawer.dart';
import './providers/videosList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: VideosList(),
          ),
        ],
        child: Consumer<VideosList>(
            builder: (ctx, auth, _) => MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(
                      primarySwatch: Colors.red,
                      accentColor: Colors.amber,
                      canvasColor: Color.fromRGBO(255, 254, 229, 1),
                      fontFamily: 'Raleway',
                      textTheme: ThemeData.light().textTheme.copyWith(
                          body1:
                              TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                          body2:
                              TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                          title: TextStyle(
                              fontSize: 20,
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.bold))),
                  home: MyHomePage(),
                )));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: MainDrawer(),
      body: HomeScreen(),
    );
  }
}
