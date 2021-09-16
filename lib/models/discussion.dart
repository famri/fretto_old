import './interlocutor.dart';
import './message.dart';

class Discussion {
  final int id;
  final bool active;
  final DateTime dateTime;
  Message latestMessage;
  final Interlocutor client;
  final Interlocutor transporter;

  Discussion(
      {required this.id,
      required this.active,
      required this.dateTime,
      required this.latestMessage,
      required this.client,
      required this.transporter});

  factory Discussion.fromJson(Map<String, dynamic> json) {
    return Discussion(
        id: json["id"],
        active: json["active"],
        dateTime: DateTime.parse(json["dateTime"]),
        latestMessage: Message.fromJson(json["latestMessage"]),
        client: Interlocutor.fromJson(json["client"] as Map<String, dynamic>),
        transporter:
            Interlocutor.fromJson(json["transporter"] as Map<String, dynamic>));
  }
}
