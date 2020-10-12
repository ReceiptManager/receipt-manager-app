import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:receipt_parser/database/receipt_database.dart';

import '../main.dart';

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
  static sendImage(File imageFile, String ip, BuildContext context) async {
    init();

    log("Try to upload new image.");

    if (ip == null || ip.isEmpty) {
      log("ip appears invalid.");
    }

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(buildUrl(ip));

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);

    var response = await request.send();
    int ret = response.statusCode;
    if (ret == 200) {
      log("Uploaded image.");
    } else {
      log("Could not upload image.");
    }

    Receipt receipt;
    response.stream
        .transform(utf8.decoder)
        .listen((value) {
          Map<String, dynamic> r = jsonDecode(value);
          receipt = Receipt(
              receiptTotal: r['receiptTotal'],
              shopName: r['storeName'],
              category: '',
              receiptDate: DateFormat("dd.MM.yyyy").parse(r['receiptDate']));

          print('StoreName:  ${r['storeName']} ');
          print('ReceiptTotal:  ${r['receiptTotal']} ');
          print('ReceiptDate:  ${r['receiptDate']} ');
        })
        .asFuture()
        .then((_) => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(receipt, true)),
              )
            });
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
