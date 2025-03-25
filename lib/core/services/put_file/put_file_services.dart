import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf_compressor/pdf_compressor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as compresss;
import 'package:file_picker/file_picker.dart';

import '../../client/client.dart';
import '../../values/values.dart';

import 'put_file.dart';
import 'put_file_type.dart';

abstract class PutFileService {
  Future<File?> compressFile(PutFile putFile);
  Future<PutFile> getFile({PutFileType? ignore});

  Future<String> getPrivacyPolicyFile();
}

class PutFileServiceImpl implements PutFileService {
  final int maxSizeFile = 9 * 1024 * 1024;
  final List<PutFileType> defaultAllowedExtensions = [
    PutFileType.pdf,
    PutFileType.jpg,
    PutFileType.png,
  ];

  @override
  Future<PutFile> getFile({PutFileType? ignore}) async {
    final allowedExtensions = getAllowedExtensions(ignore: ignore);

    final result = await FilePicker.platform.pickFiles(
      withReadStream: true,
      type: FileType.custom,
      allowCompression: true,
      allowedExtensions: allowedExtensions,
    );

    if (result == null) {
      throw InvalidFile(
        message: Strings.addMoreOneFile,
      );
    }

    if (result.files.first.size > maxSizeFile) {
      throw InvalidFile(
        message: Strings.errorFileMaxSize,
      );
    }

    return PutFile(filePicker: result);
  }

  List<String> getAllowedExtensions({PutFileType? ignore}) {
    if (ignore == null) {
      return defaultAllowedExtensions.map((it) => it.value).toList();
    }

    final copyExtensionsList =
        defaultAllowedExtensions.where((it) => it != ignore).toList();
    return copyExtensionsList.map((it) => it.value).toList();
  }

  @override
  Future<File?> compressFile(PutFile putFile) async {
    switch (putFile.fileType) {
      case PutFileType.pdf:
        return await compressPdfFile(putFile);
      case PutFileType.jpg:
      case PutFileType.jpeg:
      case PutFileType.png:
        return compressImageFile(putFile);
    }
  }

  File? compressImageFile(PutFile putFile) {
    final image = compresss.decodeImage(putFile.file!.readAsBytesSync());
    if (image == null) return null;

    final smallerImage = compresss.copyResize(image, width: 400, height: 400);

    final encodeJpg = compresss.encodeJpg(smallerImage, quality: 85);
    return File(putFile.path ?? '')..writeAsBytesSync(encodeJpg);
  }

  Future<File?> compressPdfFile(PutFile putFile) async {
    final outputPath = await createTemporaryPath();

    await PdfCompressor.compressPdfFile(
      putFile.path!,
      outputPath,
      CompressQuality.LOW,
    );

    return File(outputPath).create(recursive: true);
  }

  Future<String> createTemporaryPath() async {
    late final Directory? diretory;

    if (Platform.isIOS) {
      diretory = await getTemporaryDirectory();
    } else {
      diretory = await getExternalStorageDirectory();
    }

    final outputPath = '${diretory!.path}/compress';
    final saveDir = Directory(outputPath);

    if (!await saveDir.exists()) {
      await saveDir.create(recursive: true);
    }

    final now = DateTime.now();
    return '$outputPath/${now.millisecondsSinceEpoch}.pdf';
  }

  @override
  Future<String> getPrivacyPolicyFile() async {
    final data = await rootBundle.loadString(Strings.termOfUseFilePath);
    return data;
  }
}
