import 'package:flutter/material.dart';
import 'package:flutter_socket_sample/core/socket_controller.dart';
import 'package:flutter_socket_sample/core/socket_message.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key) {
    socketController = GetIt.I.get<SocketController>();
  }

  final String title;
  SocketController socketController;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController textEditingController = TextEditingController();

  Widget chatItem(SocketMessage msg) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: msg.origin == SocketMessageOrigin.FLUTTER ? Alignment.centerLeft : Alignment.centerRight,
        child: Row(
          mainAxisAlignment: msg.origin == SocketMessageOrigin.FLUTTER ? MainAxisAlignment.start : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            msg.origin == SocketMessageOrigin.FLUTTER ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                "Anda",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green
                ),
              ),
            ) : Container(),
            Text(
                msg.message
            ),
            msg.origin == SocketMessageOrigin.SERVER ? Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Server",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }

  Widget chatList(BuildContext context) {
    return StreamBuilder<List<SocketMessage>>(
      stream: widget.socketController.messageStream(),
      builder: (context,snapshot) {
        List<SocketMessage> messages = snapshot.data;

        if (messages == null || messages.isEmpty)
          return Center(
            child: Text(
              "Tidak ada pesan",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
          );

        return ListView.builder(
            itemCount: messages.length,
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            itemBuilder: (context, idx) {
              SocketMessage msg = messages[idx];

              return chatItem(msg);
            }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: chatList(context),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 16),
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder()
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 16),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                            String msg = textEditingController.text;

                            if (msg.isNotEmpty) {
                              widget.socketController.sendMessage(msg);
                              textEditingController.clear();
                            }
                        },
                        color: Colors.blue,
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
