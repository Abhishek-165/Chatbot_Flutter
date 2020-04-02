import 'package:flutter/material.dart';
import 'constants.dart';

import 'package:flutter_dialogflow/flutter_dialogflow.dart';
import 'message_bubble.dart';

void main() => runApp(ChatScreen());

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();

  var query;
  var data;
  List<MessageBubble> message = [];

  void Response() async {
    final messageBubble = MessageBubble(text: query, isMe: true);

    Dialogflow dialogflow = Dialogflow(token: "YOUR_TOKEN_KEY");
    AIResponse response = await dialogflow.sendQuery(query);
    setState(() {
      data = response.getMessageResponse();
      final botMessage = MessageBubble(text: data, isMe: false);
      message.add(messageBubble);
      message.add(botMessage);
      print(message);
    });
    /*  mess.add(response.getMessageResponse().toString());
    print(mess);*/
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromARGB(255, 232, 56, 77), // Main Color,
          accentColor: Color.fromARGB(255, 216, 27, 97),
          fontFamily: 'hpsimplified'),
      home: Scaffold(
        appBar: AppBar(
          leading: null,
          title: Text('MedBot'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: message.length,
                  itemBuilder: (BuildContext context, int index) {
                    return message[index];
                  },
                ),
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        onChanged: (value) {
                          query = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Response();
                        messageController.clear();
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
