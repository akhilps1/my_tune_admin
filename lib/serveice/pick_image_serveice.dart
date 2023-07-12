import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import 'package:image_picker_web/image_picker_web.dart';

import '../failures/main_failures.dart';

class PickImageServeice {
  static Future<Either<MainFailures, Uint8List>> pickImage() async {
    const maxFileSize = 1024 * 199;

    Uint8List? pickedImageBytes = await ImagePickerWeb.getImageAsBytes();
    if (pickedImageBytes != null) {
      if (pickedImageBytes.length <= maxFileSize) {
        return right(pickedImageBytes);
      } else {
        return left(
          MainFailures.fileSizeExeedFailure(value: pickedImageBytes.length),
        );
      }
    } else {
      return left(
        const MainFailures.imagePickerFailure(),
      );
    }
  }
}
