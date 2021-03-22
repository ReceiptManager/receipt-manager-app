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
import 'package:receipt_manager/database/receipt_database.dart';
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

  String getAPIUrl(final ip, final token, final legacyParser, final gaussian,
      final grayscale, final rotate, final https, final reverseProxy) {
    if (https)

      /// override the agent to provide support for self signed
      /// certificates.
      ///
      /// Since the server runs local and the certificate is protected
      /// with a password, the security risk is small.
      HttpOverrides.global = new SelfSignedHttpAgent();

    String protocol = https ? _https : _http;
    if (token == null || token == "") {
      if (reverseProxy)
        return protocol +
            ip +
            "/" +
            _uploadPath +
            "&legacy_parser=" +
            getValue(legacyParser) +
            "&grayscale_image=" +
            getValue(grayscale) +
            "&gaussian_blur=" +
            getValue(gaussian) +
            "&rotate=" +
            getValue(rotate);

      return protocol +
          ip +
          ":" +
          _port +
          _uploadPath +
          "&legacy_parser=" +
          getValue(legacyParser) +
          "&grayscale_image=" +
          getValue(grayscale) +
          "&gaussian_blur=" +
          getValue(gaussian) +
          "&rotate=" +
          getValue(rotate);
    }

    if (reverseProxy)
      return protocol +
          ip +
          "/" +
          _uploadPath +
          _token +
          token +
          "&legacy_parser=" +
          getValue(legacyParser) +
          "&grayscale_image=" +
          getValue(grayscale) +
          "&gaussian_blur=" +
          getValue(gaussian) +
          "&rotate=" +
          getValue(rotate);

    return protocol +
        ip +
        ":" +
        _port +
        _uploadPath +
        _token +
        token +
        "&legacy_parser=" +
        getValue(legacyParser) +
        "&grayscale_image=" +
        getValue(grayscale) +
        "&gaussian_blur=" +
        getValue(gaussian) +
        "&rotate=" +
        getValue(rotate);
  }

  /// Convert boolean values to python boolean values
  String getValue(final bool val) {
    if (val == null || val == false) {
      return "False";
    } else {
      return "True";
    }
  }

  toHomeScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: _transactionDuration), () {});

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomeScreen(null, true)));
  }

  sendTrainingData(String ip, String token, String company, String date,
      String total, BuildContext context) async {
    log("Submit training data.");
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"company": "$company", "date": "$date","total": "$total"}';
    Response response =
        await post(getTrainingUrl(ip, token), headers: headers, body: json);
    if (response.statusCode != 0) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(S.of(context).failedToSubmitTrainingData),
        backgroundColor: Colors.red,
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Submitted training data"),
        backgroundColor: Colors.green,
      ));
    }
  }

  /// Send image via post request to the server and capture the response.
  sendImage(File imageFile, NetworkClientHolder holder, BuildContext context,
      [GlobalKey<ScaffoldState> key]) async {
    log("Try to upload new image.");
    if ((!holder.reverseProxy && (holder.ip == null || holder.ip.isEmpty)) ||
        (holder.reverseProxy &&
            (holder.domain == null || holder.domain.isEmpty))) {
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
    var uri;
    if (!holder.reverseProxy)
      uri = Uri.parse(getAPIUrl(
          holder.ip,
          holder.token,
          holder.legacyParser,
          holder.gaussian,
          holder.grayscale,
          holder.rotate,
          holder.https,
          true));
    else
      uri = Uri.parse(getAPIUrl(
          holder.domain,
          holder.token,
          holder.legacyParser,
          holder.gaussian,
          holder.grayscale,
          holder.rotate,
          holder.https,
          false));

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
        log("Could not upload image.");
      }

      ReceiptsCompanion receipt;
      response.stream
          .transform(utf8.decoder)
          .listen((value) {
            Map<String, dynamic> r = jsonDecode(value);
            DateTime _date;

            log("Receipt item list:");
            if (holder.showItemList == false) {
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

      key.currentState
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
      key.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text(msg), backgroundColor: Colors.red));

      toHomeScreen(context);
      return;
    } on HandshakeException catch (_) {
      String msg = "";
      if (holder.sendDebugOutput == null || holder.sendDebugOutput == false) {
        msg = "General exception";
      } else {
        msg = S.of(context).handshakeException + _.toString();
      }

      key.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text(msg), backgroundColor: Colors.red));

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

      key.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text(msg), backgroundColor: Colors.red));

      toHomeScreen(context);
      return;
    }
  }

  getTrainingUrl(String ip, String token) {
    return _https + ip + ":" + _port + _trainingPath + _token + token;
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
