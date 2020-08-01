import 'dart:async';

import 'package:flutter_socket_sample/core/socket_message.dart';
import 'package:socket_io_client/socket_io_client.dart';

enum SocketStatus { IDLE, CONNECTING, CONNECTED, ERROR }

class SocketController {
  List<SocketMessage> _tempMessages = [];

  StreamController<SocketStatus> _statusCtrl = StreamController();
  StreamController<List<SocketMessage>> _messageCtrl = StreamController();

  Stream<SocketStatus> statusStream() => _statusCtrl.stream;
  Stream<List<SocketMessage>> messageStream() => _messageCtrl.stream;

  Socket socket;

  init() async {
    print("Initializing Socket...");

    // initial status
    _statusCtrl.add(SocketStatus.IDLE);
    _messageCtrl.add([]);

    socket = io('http://128.199.203.128:4200', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });

    socket.on('connect', (_) {
      print('socket connected');
      socket.emit('join', 'Hello World from Flutter');
    });

    socket.on('messages', (msg) {
      SocketMessage message = SocketMessage(SocketMessageOrigin.SERVER, msg);

      _tempMessages.add(message);
      _messageCtrl.add(_tempMessages);
      print(msg);
    });

    socket.connect();
  }

  sendMessage(String msg) {
    print("sending message");
    socket.emit('messages', msg);
    SocketMessage message = SocketMessage(SocketMessageOrigin.FLUTTER, msg);
    _tempMessages.add(message);
    _messageCtrl.add(_tempMessages);
  }

  destroy() {
    _statusCtrl.close();
    _messageCtrl.close();
    socket.disconnect();
    socket.destroy();
  }
}
