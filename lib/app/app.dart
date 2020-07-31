import 'package:flutter/material.dart';
import 'package:flutter_socket_sample/core/kickoff_controller.dart';
import 'package:flutter_socket_sample/ui/home_page.dart';
import 'package:get_it/get_it.dart';

class App extends StatefulWidget {

  KickOffController kickOffController;

  App() {
    kickOffController = GetIt.I.get<KickOffController>();
  }

  // This widget is the root of your application.
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App>{

  @override
  void initState() {
    super.initState();
    widget.kickOffController.kickOff();
  }

  @override
  void dispose() {
    widget.kickOffController.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Flutter Chat'),
    );
  }
}