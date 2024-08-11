import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salma_hotel_app/models/booking.dart';
import 'package:salma_hotel_app/screens/login.dart';
import 'package:salma_hotel_app/screens/register.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => BookingModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Hotel App'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/cropped-hotel.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.darken),
          )),
          child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              //
              // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
              // action in the IDE, or press "p" in the console), to see the
              // wireframe for each widget.
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'STAR HOTEL APPLICATION',
                  style: TextStyle(
                    color: Color.fromRGBO(248, 237, 227, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(197, 112, 93, 1),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login(
                                    title: "Login",
                                  )));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Color.fromRGBO(248, 237, 227, 1),
                      ),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(197, 112, 93, 1),
                    ),
                    onPressed: () {
                      print("helloo");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register(
                                    title: "Register",
                                  )));
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Color.fromRGBO(248, 237, 227, 1),
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
