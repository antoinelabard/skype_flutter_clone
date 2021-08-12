import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype_flutter_clone/constants/strings.dart';
import 'package:skype_flutter_clone/models/call.dart';

class Callmethods {
  final CollectionReference callCollection =
      FirebaseFirestore.instance.collection(CALL_COLLECTION);

  Future<bool> makeCall({required Call call}) async {
    try {
      call.hasDialed = true;
      var hasDialedMap = call.toMap();
      call.hasDialed = false;
      var hasNotDialedMap = call.toMap();

      await callCollection.doc(call.callerId).set(hasDialedMap);
      await callCollection.doc(call.receiverId).set(hasNotDialedMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endCall({required Call call}) async {
    try {
      await callCollection.doc(call.callerId).delete();
      await callCollection.doc(call.receiverId).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
