import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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
    HttpOverrides.global = new UnsecureHttpAgent();
  }

  static String buildUrl(final ip) {
    if (ip != null) return protocol + ip + ":" + port + path;
  }

  static toNavigationBar(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomeScreen(null, true)));
  }

  /// Send image via post request to the server and capture the response.
  static sendImage(File imageFile, String ip, BuildContext context,
      [GlobalKey<ScaffoldState> key]) async {
    init();

    log("Try to upload new image.");
    if (ip == null || ip.isEmpty) {
      log("ip appears invalid.");
      key.currentState
        ..showSnackBar(SnackBar(
            content: Text("Server ip is not set."),
            backgroundColor: Colors.red));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(null, true)));
      return;
    }

    var stream = new http.ByteStream(imageFile.openRead());
    stream.cast();

    var length = await imageFile.length();
    var uri = Uri.parse(buildUrl(ip));
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);

    key.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text("Send to: " + uri.toString()),
          backgroundColor: Colors.green));

    try {
      var response = await request.send().timeout(
        Duration(seconds: 3),
        onTimeout: () async {
          key.currentState
            ..showSnackBar(SnackBar(
                content: Text("Server timeout."), backgroundColor: Colors.red));
          await Future.delayed(const Duration(seconds: 2), () {});
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeScreen(null, true)));

          return;
        },
      );

      if (response == null) {
        await Future.delayed(const Duration(seconds: 2), () {});
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen(null, true)));
        return;
      }

      int ret = response.statusCode;
      if (ret != null && ret == 200) {
        log("Uploaded image.");
      } else {
        log("Could not upload image.");
      }

      ReceiptsCompanion receipt;
      response.stream
          .transform(utf8.decoder)
          .listen((value) {
            Map<String, dynamic> r = jsonDecode(value);
            receipt = ReceiptsCompanion(
                total: Value(r['receiptTotal']),
                shop: Value(r['storeName']),
                category: Value(" 2"),
                date: Value(DateFormat("dd.MM.yyyy").parse(r['receiptDate'])));

            print('StoreName:  ${r['storeName']} ');
            print('ReceiptTotal:  ${r['receiptTotal']} ');
            print('ReceiptDate:  ${r['receiptDate']} ');
          })
          .asFuture()
          .then((_) async => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(receipt, true)))
              });

      await Future.delayed(const Duration(seconds: 2), () {});
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(null, true)));
      return;
    } on TimeoutException catch (_) {
      log("[EXCEPTION] get timeout exception" + _.toString());
      key.currentState
        ..showSnackBar(SnackBar(
            content: Text("Server timeout."), backgroundColor: Colors.red));

      return;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(null, true)));
    } on SocketException catch (_) {
      log("[EXCEPTION] get socket exception" + _.toString());
      key.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text("SocketException" + _.message.toString()),
            backgroundColor: Colors.red));
      await Future.delayed(const Duration(seconds: 2), () {});
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(null, true)));
      return;
      return;
    } on HandshakeException catch (_) {
      key.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text("HandshakeException" + _.message.toString()),
            backgroundColor: Colors.red));

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(null, true)));

      return;
    } catch (_) {
      log("[EXCEPTION] get general exception" + _.toString());
      key.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text("GeneralException" + _.message.toString()),
            backgroundColor: Colors.red));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(null, true)));

      return;
    }
  }
}

class UnsecureHttpAgent extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
