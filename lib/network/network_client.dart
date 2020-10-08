import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Network client interact with the python image server.
/// It send a minimal post request to the server over https,
/// after it will parse the response and update the corresponding
///  TextFields.
class NetworkClient {
  static final protocol = "https://";
  static final path = "/api/upload/";
  static final port = "8721";

  static init() {
    /// override the agent to provide support for self signed
    /// certificates.
    ///
    /// Since the server runs local and the certificate is protected
    /// with a password, the security risk is small.
    HttpOverrides.global = new CustomHttpAgent();
  }

  static String buildUrl(final ip) {
    return protocol + ip + ":" + port + path;
  }

  /// Send image via post request to the server and capture the response.
  static Future<void> sendImage(File imageFile, BuildContext context) async {
    init();

    log("Try to upload new image.");
    log("ImageSize: " + imageFile.toString());

    var ret = 0;
    if (ret == 200) {
      log("Uploaded image.");
    } else {
      log("Could not upload image.");
    }
  }
}

class CustomHttpAgent extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
