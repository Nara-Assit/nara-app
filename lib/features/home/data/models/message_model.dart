enum MessageType { text, voice }

enum MessageStatus { success, failure }

class MessageModel {
  final int? id;
  final MessageType type;
  final String content;
  final String sender;
  final int timestamp;
  final MessageStatus status;
  final String? originalText;

  MessageModel({
    this.id,
    required this.type,
    required this.content,
    required this.sender,
    this.status = MessageStatus.success,
    this.originalText,
    int? timestamp,
  }) : timestamp = timestamp ?? DateTime.now().millisecondsSinceEpoch;

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      type: map['type'] == 'text' ? MessageType.text : MessageType.voice,
      content: map['content'],
      sender: map['sender'],
      timestamp: map['timestamp'],
      originalText: map['originalText'],
      status: _statusFromString(map['status']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type == MessageType.text ? 'text' : 'voice',
      'content': content,
      'sender': sender,
      'timestamp': timestamp,
      'originalText': originalText,
      'status': status.name,
    };
  }

  static MessageStatus _statusFromString(String? status) {
    switch (status) {
      case 'failure':
        return MessageStatus.failure;
      case 'success':
        return MessageStatus.success;
      default:
        return MessageStatus.success;
    }
  }
}
