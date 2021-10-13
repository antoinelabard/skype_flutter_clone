import 'package:uuid/uuid.dart';

/// Stores and retrieve all the information related to a previous call between 2
/// users. It allows to manage call log data without dealing with the map given
/// by the database.
class Log {
  late String logId;
  late String callerName;
  late String callerPic;
  late String receiverName;
  late String receiverPic;
  late String callStatus;
  late String timestamp;

  Log({
    this.callerName = "",
    this.callerPic = "",
    this.receiverName = "",
    this.receiverPic = "",
    this.callStatus = "",
    this.timestamp = "",
  }) {
    logId = Uuid().v4().toString();
  }

  // to map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> logMap = Map();
    logMap["log_id"] = logId;
    logMap["caller_name"] = callerName;
    logMap["caller_pic"] = callerPic;
    logMap["receiver_name"] = receiverName;
    logMap["receiver_pic"] = receiverPic;
    logMap["call_status"] = callStatus;
    logMap["timestamp"] = timestamp;
    return logMap;
  }

  Log.fromMap(Map logMap) {
    this.logId = logMap["log_id"];
    this.callerName = logMap["caller_name"];
    this.callerPic = logMap["caller_pic"];
    this.receiverName = logMap["receiver_name"];
    this.receiverPic = logMap["receiver_pic"];
    this.callStatus = logMap["call_status"];
    this.timestamp = logMap["timestamp"];
  }
}
