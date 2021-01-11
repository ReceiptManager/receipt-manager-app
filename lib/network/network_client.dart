/*
 *  Copyright (c) 2020 - William Todt
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as mime;
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:receipt_manager/database/receipt_database.dart';
import 'package:receipt_manager/generated/l10n.dart';

import '../main.dart';

/// Network client interact with the python image server.
/// Iimal post request to the server over https,
/// after it will parse the response and update the corresponding
///  TextFields.
class NetworkClient {
  static final _protocol = "https://";
  static final _path = "/api/upload";
  static final _access_token = "?access_token=";
  static final _port = "8721";
  static final _timeout = 120;
  static const int _transactionDuration = 2;

  static init() {
    /// override the agent to provide support for self signed
    /// certificates.
    ///
    /// Since the server runs local and the certificate is protected
    /// with a password, the security risk is small.
    HttpOverrides.global = new SelfSignedHttpAgent();
  }

  static String buildUrl(final ip, final token, final legacyParser, final gaussian, final grayscale, final rotate) {
    if (token == null || token == "")
      return _protocol + ip + ":" + _port + _path + "&legacy_parser=" + getValue(legacyParser) + "&grayscale_image=" + getValue(grayscale)  + "&gaussian_blur=" + getValue(gaussian) + "&rotate=" + getValue(rotate);
    return _protocol + ip + ":" + _port + _path + _access_token + token + "&legacy_parser=" + getValue(legacyParser) + "&grayscale_image=" + getValue(grayscale)  + "&gaussian_blur=" + getValue(gaussian) + "&rotate=" + getValue(rotate);
  }

  /// Convert boolean values to python boolean values
  static String getValue(final bool val) {
    if (val == null || val == false) {
      return "False";
    } else {
      return "True";
    }
  }

  static toNavigationBar(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomeScreen(null, true)));
  }

  /// Send image via post request to the server and capture the response.
  static sendImage(
      File imageFile,
      String ip,
      String token,
      bool sendDebugOutput,
      bool grayscale,
      bool gaussian,
      bool legacyParser,
      bool rotate,
      BuildContext context,
      [GlobalKey<ScaffoldState> key]) async {
    init();

    log("Try to upload new image.");
    if (ip == null || ip.isEmpty) {
      log("ip appears invalid.");
      key.currentState
        ..showSnackBar(SnackBar(
            content: Text(S.of(context).serverIpIsNotSet),
            backgroundColor: Colors.red));
      await Future.delayed(
          const Duration(seconds: _transactionDuration), () {});
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(null, true)));
      return;
    }

    var stream = new http.ByteStream(imageFile.openRead());
    stream.cast();

    var length = await imageFile.length();
    var uri = Uri.parse(buildUrl(ip, token, legacyParser, gaussian, grayscale, rotate));

    log(uri.toString());

    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile(
      'file',
      stream,
      length,
      filename: basename(imageFile.path),
      contentType: mime.MediaType("multipart", "form-data"),
    );
    request.files.add(multipartFile);

    key.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text("Send to: " + uri.toString()),
          backgroundColor: Colors.green));

    try {
      var response = await request.send().timeout(
        Duration(seconds: _timeout),
        onTimeout: () async {
          key.currentState
            ..showSnackBar(SnackBar(
                content: Text(S.of(context).serverTimeout),
                backgroundColor: Colors.red));
          await Future.delayed(
              const Duration(seconds: _transactionDuration), () {});
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeScreen(null, true)));

          return;
        },
      );

      if (response == null) {
        await Future.delayed(
            const Duration(seconds: _transactionDuration), () {});
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
            DateTime _date;

            String parsedString = r['receiptDate'] == null
                ? ""
                : r['receiptDate']
                    .replaceAll('"', '')
                    .replaceAll("\n", '')
                    .split(" ")[0];

            var format = DateFormat(S.of(context).receiptDateFormat);
            try {
              _date = format.parse(parsedString);
            } catch (_) {
              _date = null;
            }

            receipt = ReceiptsCompanion(
                total: Value(r['receiptTotal']),
                shop: Value(r['storeName']),
                category: Value(r['category']),
                date: Value(_date));

            log('StoreName:  ${r['storeName']} ');
            log('ReceiptTotal:  ${r['receiptTotal']} ');
            log('ReceiptDate:  $parsedString');
          })
          .asFuture()
          .then((_) async => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(receipt, true)))
              });
      return;
    } on TimeoutException catch (_) {
      log("[EXCEPTION] get timeout exception" + _.toString());
      String msg = S.of(context).serverTimeout;
      if (sendDebugOutput == null || sendDebugOutput == false) {
        msg = "General exception";
      } else {
        msg = S.of(context).serverTimeout + _.toString();
      }

      key.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text(msg), backgroundColor: Colors.red));

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(null, true)));

      return;
    } on SocketException catch (_) {
      log("Get socket exception" + _.toString());
      String msg = "";
      if (sendDebugOutput == null || sendDebugOutput == false) {
        msg = S.of(context).socketException;
      } else {
        msg = S.of(context).socketException + _.toString();
      }
      key.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text(msg), backgroundColor: Colors.red));
      await Future.delayed(
          const Duration(seconds: _transactionDuration), () {});
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(null, true)));
      return;
    } on HandshakeException catch (_) {
      String msg = "";
      if (sendDebugOutput == null || sendDebugOutput == false) {
        msg = "General exception";
      } else {
        msg = S.of(context).handshakeException + _.toString();
      }

      key.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text(msg), backgroundColor: Colors.red));

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(null, true)));

      return;
    } catch (_) {
      log("[EXCEPTION] get general exception" + _.toString());

      String msg = "";
      if (sendDebugOutput == null || sendDebugOutput == false) {
        msg = S.of(context).generalException;
      } else {
        msg = S.of(context).generalException + _.toString();
      }

      key.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text(msg), backgroundColor: Colors.red));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(null, true)));

      return;
    }
  }
}

class SelfSignedHttpAgent extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
