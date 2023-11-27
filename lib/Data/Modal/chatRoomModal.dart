// ignore_for_file: camel_case_types, file_names

class msgModal {
  String fromId;
  String message;
  String msgId;
  String msgType;
  String read;
  String sent;
  String toId;

  msgModal({
    required this.fromId,
    required this.message,
    required this.msgId,
    this.msgType = 'text',
    required this.toId,
    required this.sent,
    this.read = '',
  });
  factory msgModal.fromJson(Map<String, dynamic> json) {
    return msgModal(
      fromId: json['fromId'],
      message: json['message'],
      msgId: json['msgId'],
      msgType: json['msgType'],
      read: json['read'],
      sent: json['sent'],
      toId: json['toId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'fromId': fromId,
      'message': message,
      'msgId': msgId,
      'msgType': msgType,
      'read': read,
      'sent': sent,
      'toId': toId,
    };
  }
}
