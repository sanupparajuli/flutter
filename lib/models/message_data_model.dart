import 'dart:math';

class MessageData {
  static List<String> introOutputEn = ["Hello", "Hello, I am 1inaMillion Robot", "Hi", "Hi, I am 1inaMillion Robot"];

  static List<String> greetingsOutputEn = [
    "I am fine",
    "I am fine, what about you ?",
    "I am good",
    "I am good, what about you ?"
  ];
  static List<String> helpMessage = [
    "Help me",
    "Sure, How can i help ?",
    "How to donate",
    "Aww!, Please Goto the Donation Page?"
  ];

  static List<String> thankOutputEn = ["Welcome", "Most welcome", "Its my pleasure", "Mention not"];

  /// generates a new Random object
  static final random = Random();

  static String getMessageBot(String msgReq) {
    var outputRobot = "I do not understand what you mean !!!";
    var messageLower = msgReq.toString().toLowerCase();
    if (messageLower.contains("hi") || messageLower.contains("hello")) {
      outputRobot = introOutputEn[random.nextInt(introOutputEn.length)];
      return outputRobot;
    }
    if (messageLower.contains("help me") || messageLower.contains("how di")) {
      outputRobot = helpMessage[random.nextInt(helpMessage.length)];
      return outputRobot;
    }
    if (messageLower.contains("how are you") || messageLower.contains("how are you doing today")) {
      outputRobot = greetingsOutputEn[random.nextInt(greetingsOutputEn.length)];
      return outputRobot;
    }
    if (messageLower.contains("thank") || messageLower.contains("thank you")) {
      outputRobot = thankOutputEn[random.nextInt(thankOutputEn.length)];
      return outputRobot;
    } else {
      return outputRobot;
    }
  }
}
