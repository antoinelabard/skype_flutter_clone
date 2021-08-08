import 'dart:io';
import 'dart:math';

import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/src/types/image_source.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  static String getUsername(String email) => "live:${email.split('@')[0]}";

  static String getInitials(String displayName) {
    List<String> split = displayName.split(" ");
    return split[0][0] + split[1][0];
  }

  pickImage(ImageSource source) async {
    File selectedImage = await ImagePicker().pickImage(source: source) as File;
    return compressImage(selectedImage);
  }

  static compressImage(File selectedImage) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    var random = Random().nextInt(1000);
    Im.Image image = Im.decodeImage(selectedImage.readAsBytesSync())!;
    Im.copyResize(image, width: 500, height: 500);
    return new File('$path/img_$random.jpg')
        .writeAsBytesSync(Im.encodeJpg(image, quality: 85));
  }
}
