import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

import '../../values/values.dart';
import 'put_file_type.dart';

class PutFile {
  final FilePickerResult filePicker;

  PutFile({
    required this.filePicker,
  });

  String? get path => filePicker.paths.first;

  String get filename => basename(filePicker.paths.first ?? '');

  String get fileExtension => filePicker.files.first.extension ?? '';

  String get randomFilename {
    final now = DateTime.now();
    return '${Strings.photoFileUploadName}_${now.millisecondsSinceEpoch.toString()}.$fileExtension';
  }

  String get proofOfPayment {
    return '${Strings.photoFileUploadName}.$fileExtension';
  }

  PutFileType get fileType {
    return fileExtension.replaceAll('.', '').trim().fromPutFileType;
  }

  String get mediaType {
    return fileType.toMediaType;
  }

  File? get file {
    final cachedFile = filePicker.files.first;
    return File(cachedFile.path!);
  }
}
