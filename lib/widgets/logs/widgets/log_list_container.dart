import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/constants/strings.dart';
import 'package:skype_flutter_clone/models/log.dart';
import 'package:skype_flutter_clone/resources/local_db/repository/log_repository.dart';
import 'package:skype_flutter_clone/screens/chat_screens/widgets/cached_image.dart';
import 'package:skype_flutter_clone/screens/page_views/widgets/quiet_box.dart';
import 'package:skype_flutter_clone/utils/utils.dart';

import '../../custom_tile.dart';

class LogListContainer extends StatefulWidget {
  const LogListContainer({Key? key}) : super(key: key);

  @override
  State<LogListContainer> createState() => _LogListContainerState();
}

class _LogListContainerState extends State<LogListContainer> {
  getIcon(String callStatus) {
    Icon icon;
    double iconSize = 15;

    switch (callStatus) {
      case CALL_STATUS_DIALLED:
        icon = Icon(
          Icons.call_made,
          size: iconSize,
          color: Colors.green,
        );
        break;
      case CALL_STATUS_MISSED:
        icon = Icon(
          Icons.call_missed,
          size: iconSize,
          color: Colors.red,
        );
        break;
      default:
        icon = Icon(
          Icons.call_received,
          size: iconSize,
          color: Colors.grey,
        );
        break;
    }
    return Container(
      margin: EdgeInsets.only(right: 5),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LogRepository.getLogs(),
        builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasData) {
        List<dynamic> logList = snapshot.data;
        if (logList.isNotEmpty) {
          return ListView.builder(
            itemCount: logList.length,
              itemBuilder: (context, index) {
            Log _log = logList[index];
            var hasDialled = _log.callStatus == CALL_STATUS_DIALLED;
            return CustomTile(
              leading: CachedImage(
                  hasDialled ? _log.receiverPic : _log.callerPic,
                  isRound: true,
                  radius: 45),
              mini: false,
              title: Text(
                hasDialled ? _log.receiverName : _log.callerName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              icon: getIcon(_log.callStatus),
              subtitle: Text(
                Utils.formatDateString(_log.timestamp),
                style: TextStyle(fontSize: 13),
              ),
              onLongPress: () => showDialog(context: context, builder: (context) => AlertDialog(
                title: Text("Delete this log?"),
                content: Text("Are you sure you want to delete this log?"),
                actions: [
                  TextButton(onPressed: () async {
                    Navigator.maybePop(context);
                    await LogRepository.deleteLogs(index);
                    if (mounted) {
                      setState(() {});
                    }
                  }, child: Text("Yes")),
                  TextButton(onPressed: () {
                    Navigator.maybePop(context);
                  }, child: Text("No")),

                ],
              )),
            );
          });
        }
      }
      return QuietBox(
          heading: "This is where all your calls are listed.",
          subtitle: "Calling people all over the world with just one click!");
    });
  }
}
