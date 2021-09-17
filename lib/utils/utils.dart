import 'dart:io';
import 'dart:math';

import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/src/types/image_source.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skype_flutter_clone/enum/user_state.dart';

class Utils {
  static String getUsername(String email) => "live:${email.split('@')[0]}";

  static String getInitials(String displayName) {
    List<String> split = displayName.split(" ");
    return split[0][0] + split[1][0];
  }

  static pickImage({required ImageSource source}) async {
    XFile? selectedImage = await ImagePicker().pickImage(source: source);
    return compressImage(File(selectedImage!.path));
  }

  static compressImage(File selectedImage) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    var random = Random().nextInt(1000);
    Im.Image image = Im.decodeImage(selectedImage.readAsBytesSync())!;
    Im.copyResize(image, width: 500, height: 500);
    var i = Im.encodeJpg(image, quality: 85);
    File f = File('$path/img_$random.jpg')..writeAsBytesSync(i);
    return f;
  }

  static int stateTuNum(UserState userState) {
    switch (userState) {
      case UserState.Offline:
        return 0;
        case UserState.Online:
        return 1;
      default:
        return 2;
    }
  }

  static UserState numToState(int num) {
    switch (num) {
      case 0:
        return UserState.Offline;
      case 1:
        return UserState.Online;
      default:
        return UserState.Waiting;
    }
  }
}
