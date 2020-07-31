enum SocketMessageOrigin {
  FLUTTER,
  SERVER
}

class SocketMessage {

  final SocketMessageOrigin origin;
  final String message;

  SocketMessage(this.origin, this.message);

}