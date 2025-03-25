import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../values/values.dart';

abstract class Helper {
  static Future<void> launchTo(
    String url, {
    bool useWebView = false,
    bool forceSafariVC = false,
  }) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: forceSafariVC);
    } else {
      print('Erro to launch, app not found');
    }

    if (useWebView) {
      await launch(url, forceWebView: true);
    }
  }

  static Future<void> enterInContactWithMaria() async {
    if (Platform.isIOS) {
      await launchTo(Strings.whatsAppLinkInIOS, forceSafariVC: false);
    } else {
      await launchTo(Strings.whatsAppLinkInAndroid);
    }
  }

  static void copyToClipboard(String message) async {
    await Clipboard.setData(ClipboardData(text: message));
  }

  static void showSnackBarCopiedToClipboard(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Durations.splashAnimation,
      backgroundColor: AppColors.secondary,
      content: Text(Strings.copiedCode(message)),
    ));
  }

  static DateTime packgeStatusParseToDateTime(
    String statusDate,
    String statusTime,
  ) {
    final dateStr = statusDate.split('/').map((it) => int.parse(it)).toList();
    final hourStr = statusTime.split(':').map((it) => int.parse(it)).toList();

    return DateTime(
      dateStr.last,
      dateStr[1],
      dateStr.first,
      hourStr.first,
      hourStr.last,
    );
  }
}
