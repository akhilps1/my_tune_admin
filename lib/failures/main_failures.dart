import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_failures.freezed.dart';

@freezed
class MainFailures with _$MainFailures {
  const factory MainFailures.imagePickerFailure() = _ImagePickerFailure;
  const factory MainFailures.fileSizeExeedFailure({
    required int value,
  }) = _FileSizeExeedFailure;
}
