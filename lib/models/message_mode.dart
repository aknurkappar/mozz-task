class Message {
  final int id;
  final int senderId;
  final int receiverId;
  final DateTime dateTime;
  final String text;
  final String imageURL;
  final bool seen;

  const Message(
      {required this.id,
      required this.senderId,
      required this.receiverId,
      required this.dateTime,
      required this.text,
      required this.imageURL,
      required this.seen
      });
}
