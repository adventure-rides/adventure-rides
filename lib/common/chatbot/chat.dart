import 'package:flutter/material.dart';

class AdventureRidesChatbot extends StatelessWidget {
  const AdventureRidesChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatbotScreen(),
    );
  }
}

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<Map<String, String>> messages = [];
  final TextEditingController messageController = TextEditingController();

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      setState(() {
        messages.add({"sender": "user", "text": message});
        messages.add({"sender": "bot", "text": getBotResponse(message)});
      });
      messageController.clear();
    }
  }

  String getBotResponse(String message) {
    // Simple predefined responses
    if (message.toLowerCase().contains("rides")) {
      return "We offer exciting rides like zip-lining, bungee jumping, and safari tours. What are you interested in?";
    } else if (message.toLowerCase().contains("price")) {
      return "Our prices start from \$50. Would you like a detailed price list?";
    } else {
      return "I'm here to help! Please ask about rides, prices, or bookings.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Adventure Rides Chatbot"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isUser = message["sender"] == "user";
                    return Align(
                      alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message["text"] ?? "",
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: "Type your message...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => sendMessage(messageController.text),
                      child: Text("Send"),
                    ),
                  ],
                ),
              ),
            ],
            ),
        );
    }
}
