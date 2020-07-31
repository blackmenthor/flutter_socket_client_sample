import 'package:flutter/material.dart';
import 'package:flutter_socket_sample/app/app.dart';
import 'package:flutter_socket_sample/core/kickoff_controller.dart';
import 'package:flutter_socket_sample/core/socket_controller.dart';
import 'package:get_it/get_it.dart';

registerDependency() {
  GetIt getIt = GetIt.I;
  SocketController socketController = SocketController();
  KickOffController kickOffController = KickOffController(socketController);

  getIt.registerSingleton<KickOffController>(kickOffController);
  getIt.registerSingleton<SocketController>(socketController);
}

void main() {
  registerDependency();

  runApp(App());
}