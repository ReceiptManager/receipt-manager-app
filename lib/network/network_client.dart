/*
 * Copyright (c) 2020 - 2021 : William Todt
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart' as mime;
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:receipt_manager/db/receipt_database.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/network/network_client_holder.dart';

import '../main.dart';

/// The [NetworkClient] interact with the python image server.
/// Based on the submitted server ip, port and api token
/// and post request is crafted.
///
/// The server return the parsed receipt via json. This json
/// response is parsed using the [NetworkClient].
///
/// After, a new receipt object is crafted and send to the [ReceiptForm].
/// The receipt form uses this object to fill the corresponding text fields.
class NetworkClient {
  final _https = "https://";
  final _http = "http://";
  final _uploadPath = "/api/upload";
  final _trainingPath = "/api/training";
  final _token = "?access_token=";
  final _port = "8721";
  final _timeout = 120;
  static const int _transactionDuration = 2;

  static final NetworkClient _client = NetworkClient._internal();

  factory NetworkClient() {
    return _client;
  }

  NetworkClient._internal();

  String getAPIUrl(final NetworkClientHolder holder) {
    if (holder.https)

      /// override the agent to provide support for self signed
      /// certificates.
      ///
      /// Since the server runs local and the certificate is protected
      /// with a password, the security risk is small.
      HttpOverrides.global = new SelfSignedHttpAgent();

    String _protocol = holder.https ? _https : _http;
    String _parameters = "&legacy_parser=" +
        getValue(holder.legacyParser) +
        "&grayscale_image=" +
        getValue(holder.grayscale) +
        "&gaussian_blur=" +
        getValue(holder.gaussian) +
        "&rotate=" +
        getValue(holder.rotate);

    if (holder.token == null || holder.token == "") {
      if (holder.reverseProxy)
        return _protocol + holder.ip + _uploadPath + _parameters;

      return _protocol + holder.ip + ":" + _port + _uploadPath + _parameters;
    }

    if (holder.reverseProxy)
      return _protocol +
          holder.domain +
          _uploadPath +
          _token +
          holder.token +
          _parameters;

    return _protocol +
        holder.ip +
        ":" +
        _port +
        _uploadPath +
        _token +
        holder.token +
        _parameters;
  }

  /// Convert boolean values to python boolean values
  String getValue(final bool val) {
    return val == null || val == false ? "False" : "True";
  }

  toHomeScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: _transactionDuration), () {});

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomeScreen(null, true)));
  }

  void showSuccess(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.green,
    ));
  }

  // ignore: non_constant_identifier_names
  void showError(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red,
    ));
  }

  Future<void> redirect(BuildContext context) async {
    await Future.delayed(const Duration(seconds: _transactionDuration), () {});

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomeScreen(null, true)));
  }

  sendTrainingData(NetworkClientHolder holder, BuildContext context) async {
    log("Submit training data.");

    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"company": "${holder.company}", '
        '"date": "${holder.date}",'
        '"total": "${holder.total}"}';

    Response response =
        await post(getTrainingUrl(holder), headers: headers, body: json);

    if (response.statusCode != 200) {
      showError(S.of(context).failedToSubmitTrainingData, context);
    } else {
      showSuccess("Submitted training data", context);
    }
  }

  /// Send image via post request to the server and capture the response.
  sendImage(
      File imageFile, NetworkClientHolder holder, BuildContext context) async {
    log("Try to upload new image.");

    if ((!holder.reverseProxy && (holder.ip == null || holder.ip.isEmpty)) ||
        (holder.reverseProxy &&
            (holder.domain == null || holder.domain.isEmpty))) {
      log("IP appears invalid.");
      showError(S.of(context).serverIpIsNotSet, context);
      redirect(context);
      return;
    }

    var stream = new http.ByteStream(imageFile.openRead());
    stream.cast();

    var length = await imageFile.length();
    var uri = Uri.parse(getAPIUrl(holder));
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

    showSuccess("Send to: " + uri.toString(), context);

    try {
      var response = await request.send().timeout(
        Duration(seconds: _timeout),
        onTimeout: () async {
          showError(S.of(context).serverTimeout, context);
          toHomeScreen(context);

          return;
        },
      );

      if (response == null) {
        toHomeScreen(context);
      }

      int ret = response.statusCode;
      if (ret != null && ret == 200) {
        log("Uploaded image.");
      } else {
        if (ret == 403) {
          showError(S.of(context).invalidAPIToken, context);
          toHomeScreen(context);
        } else {
          showError(S.of(context).generalException, context);
          toHomeScreen(context);
        }
        log("Could not upload image.");
      }

      ReceiptsCompanion receipt;
      response.stream
          .transform(utf8.decoder)
          .listen((value) {
            Map<String, dynamic> r = jsonDecode(value);

            if (r == null) {
              showError(S.of(context).invalidReceipt, context);
              redirect(context);
            }

            DateTime _date;

            log("Receipt item list:");
            if (holder.showItemList == true) {
              for (List<dynamic> receiptItem in r['receiptItems']) {
                log("\t" + receiptItem[0] + " " + receiptItem[1]);
              }
            }

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
                items: Value(holder.showItemList == false
                    ? jsonEncode([])
                    : jsonEncode(r['receiptItems'])),
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
      if (holder.sendDebugOutput == null || holder.sendDebugOutput == false) {
        msg = "General exception";
      } else {
        msg = S.of(context).serverTimeout + _.toString();
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text(msg), backgroundColor: Colors.red));

      toHomeScreen(context);
      return;
    } on SocketException catch (_) {
      log("Get socket exception" + _.toString());
      String msg = "";
      if (holder.sendDebugOutput == null || holder.sendDebugOutput == false) {
        msg = S.of(context).socketException;
      } else {
        msg = S.of(context).socketException + _.toString();
      }

      showError(msg, context);
      toHomeScreen(context);
      return;
    } on HandshakeException catch (_) {
      String msg = "";
      if (holder.sendDebugOutput == null || holder.sendDebugOutput == false) {
        msg = "General exception";
      } else {
        msg = S.of(context).handshakeException + _.toString();
      }

      showError(msg, context);
      toHomeScreen(context);
      return;
    } catch (_) {
      log("[EXCEPTION] get general exception" + _.toString());

      String msg = "";
      if (holder.sendDebugOutput == null || holder.sendDebugOutput == false) {
        msg = S.of(context).generalException;
      } else {
        msg = S.of(context).generalException + _.toString();
      }

      showError(msg, context);
      toHomeScreen(context);
      return;
    }
  }

  getTrainingUrl(NetworkClientHolder holder) {
    String protocol = holder.https ? _https : _http;
    if (!holder.reverseProxy)
      return protocol +
          holder.ip +
          ":" +
          _port +
          _trainingPath +
          _token +
          holder.token;
    else
      return protocol + holder.domain + _trainingPath + _token + holder.token;
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
