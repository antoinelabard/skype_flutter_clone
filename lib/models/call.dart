/// This class is intended to store and retrieve all the information related to a
/// call between 2 users. It allows to manage call data without dealing with the
/// map given by the database.
class Call {
  late String callerId;
  late String callerName;
  late String callerPic;
  late String receiverId;
  late String receiverName;
  late String receiverPic;
  late String channelId;
  late bool hasDialed;

  Call({
    required this.callerId,
    required this.callerName,
    required this.callerPic,
    required this.receiverId,
    required this.receiverName,
    required this.receiverPic,
    required this.channelId,
    this.hasDialed = false,
  });

  toMap() {
    var map = Map<String, dynamic>();
    map["callerId"] = callerId;
    map["callerName"] = callerName;
    map["callerPic"] = callerPic;
    map["receiverId"] = receiverId;
    map["receiverName"] = receiverName;
    map["receiverPic"] = receiverPic;
    map["channelId"] = channelId;
    map["hasDialed"] = hasDialed;
    return map;
  }

  Call.fromMap(Map map) {
    this.callerId = map["callerId"];
    this.callerName = map["callerName"];
    this.callerPic = map["callerPic"];
    this.receiverId = map["receiverId"];
    this.receiverName = map["receiverName"];
    this.receiverPic = map["receiverPic"];
    this.channelId = map["channelId"];
    this.hasDialed = map["hasDialed"];
  }
}
