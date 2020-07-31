import 'package:flutter_socket_sample/core/socket_controller.dart';

class KickOffController {

  final SocketController socketController;

  KickOffController(this.socketController);

  kickOff() {
    // RUN OPERATION UPON APP INITIALIZATION
    socketController.init();
  }

  destroy() {
    // RUN OPERATION BEFORE APP DESTROYED
    socketController.destroy();
  }

}